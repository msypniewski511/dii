class BusinessIdeaDefinition < ApplicationRecord
  belongs_to :business_idea

  # validates :problem_statement, :solution, :target_audience, :market_size, presence: true

  after_save :update_stage_status

  # AI method to generate suggestions
  def generate_ai_suggestions
    prompt = "Provide AI suggestions to refine the business idea based on:
              Problem Statement: #{problem_statement}
              Solution: #{solution}
              Target Audience: #{target_audience}
              Market Size: #{market_size}"
    
    ai_response = OpenAiService.generate_text(prompt)
    update(ai_suggestions: ai_response)
  end

  private

  def update_stage_status
    stage = business_idea.stages.find_by(name: "Business Idea Definition")
    return unless stage

    if problem_statement.present? && solution.present? && target_audience.present? && market_size.present?
      stage.update(status: :completed)
    else
      stage.update(status: :in_progress)
    end
  end
end
  