class AssessmentsController < ApplicationController
  def new
    @questions = Question.includes(:answers).all
  end

  def create
    total_score = 0
    responses = []
    qa = ""

    params[:responses].each do |question_id, answer_id|
      q = Question.find(question_id).text
      a = Answer.find(answer_id).text
      qa_tmp = "Question: #{q} - answer: #{a}. "
      qa += qa_tmp
      answer = Answer.find(answer_id)
      total_score += answer.score
      responses << UserResponse.new(user: current_user, question_id: question_id, answer_id: answer_id)
    end

    assessment = Assessment.create!(
      user: current_user,
      total_score: total_score,
      level: categorize_score(total_score),
      ai_insights: generate_ai_insights(qa)
    )

    responses.each(&:save)
    puts qa
    # redirect_to assessment_path(assessment)
    redirect_to home_personal_path
  end

  def show
    @assessment = current_user.assessments.find(params[:id])
    Rails.logger.debug "Raw ai_insights: #{@assessment.ai_insights.inspect}"
    @ai_insights = @assessment.ai_insights
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

  def generate_ai_insights(user_responses)
    prompt = "Analyze the following entrepreneurial skills assessment and provide insights:

    #{user_responses}

    - Identify strengths and explain why these are valuable for entrepreneurship.
    - Identify areas of improvement and explain how to develop them.
    - Provide personalized advice to enhance overall entrepreneurial effectiveness.
    - Suggest actionable steps for improvement.
    - Include motivation and encouragement.

    Format the response into the following sections:
    1. **Strengths**
    2. **Areas for Improvement**
    3. **Personalized Advice**
    4. **Actionable Steps for Growth**
    5. **Motivational Closing Statement**
    "
    # prompt = "Analyze this entrepreneurial skills score: #{score}. Suggest ways to improve."
    client = OpenAI::Client.new
    response = client.chat(
      parameters: {
        model: "gpt-4",
        messages: [
          { role: "system", content: "You are a business analysis expert. Please provide" },
          { role: "user", content: prompt },
        ],
        # max_tokens: 500
      }
    ).dig("choices", 0, "message", "content")
    # response = OpenAI_API.call(prompt) # Replace with actual OpenAI integration
    puts response
    response
  end
end