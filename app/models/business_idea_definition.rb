class BusinessIdeaDefinition < ApplicationRecord
  belongs_to :business_idea

  after_save :update_stage_status

  def generate_ai_summary
    prompt = <<~PROMPT
      Provide a clear, structured summary of the business idea using:

      Problem: #{problem_statement}
      Solution: #{solution}
      Target Audience: #{target_audience}
      Market Size: #{market_size}
      Customer Segment: #{target_customer_segment}
      Value Proposition: #{value_proposition}
      Key Differentiators: #{key_differentiators}

      Return only the summary without any headings.
    PROMPT

    response = OpenAiService.generate_text(prompt)
    update(ai_summary: response.strip, ai_generated: true)
  end


  REQUIRED_FIELDS = %w[
    problem_statement solution target_audience market_size 
    target_customer_segment value_proposition key_differentiators
  ].freeze

  def progress_percentage
    calculate_progress(REQUIRED_FIELDS)
  end

  def completed?
    progress_percentage == 100
  end
  private

  def update_stage_status
    stage = business_idea.stages.find_by(name: "Business Idea Definition")
    return unless stage

    stage.update(
      progress_percentage: progress_percentage, 
      status: completed? ? :completed : :in_progress
    )
  end
end
