class AssessmentsController < ApplicationController
  def new
    @questions = Question.includes(:answers).all
  end

  def create
    total_score = 0
    responses = []

    params[:responses].each do |question_id, answer_id|
      answer = Answer.find(answer_id)
      total_score += answer.score
      responses << UserResponse.new(user: current_user, question_id: question_id, answer_id: answer_id)
    end

    assessment = Assessment.create!(
      user: current_user,
      total_score: total_score,
      level: categorize_score(total_score),
      ai_insights: generate_ai_insights(total_score)
    )

    responses.each(&:save)
    redirect_to assessment_path(assessment)
  end

  def show
    @assessment = Assessment.find(params[:id])
  end

  private

  def categorize_score(score)
    case score
    when 13..26 then "Needs Improvement"
    when 27..39 then "Developing Entrepreneur"
    when 40..52 then "Competent Entrepreneur"
    when 53..65 then "High-Performing Entrepreneur"
    else "Undefined"
    end
  end

  def generate_ai_insights(score)
    "Some text from AI"
    # prompt = "Analyze this entrepreneurial skills score: #{score}. Suggest ways to improve."
    # OpenAI_API.call(prompt) # Replace with actual OpenAI integration
  end
end