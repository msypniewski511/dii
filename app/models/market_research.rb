
class MarketResearch < ApplicationRecord
  belongs_to :business_idea

  after_save :update_stage_status

  REQUIRED_FIELDS = %w[
    market_trends competitor_insights customer_segments industry_reports
  ].freeze

  def progress_percentage
    calculate_progress(REQUIRED_FIELDS)
  end

  def completed?
    is_complete = progress_percentage == 100
    if progress_percentage == 100 && ai_suggestions.nil?
      generate_ai_suggestions
    end
    is_complete
  end

  def generate_ai_field(field)
    return unless REQUIRED_FIELDS.include?(field)

    definition = business_idea.business_idea_definition

    # Use definition fields if available, otherwise fallback to business idea base info
    summary_data = {
      problem: definition&.problem_statement,
      solution: definition&.solution,
      customer_segment: definition&.target_customer_segment,
      value_proposition: definition&.value_proposition,
      key_differentiators: definition&.key_differentiators
    }

    prompt = <<~PROMPT
      You are helping with market research for a business idea called "#{business_idea.title}" in #{business_idea.country}.

      Business Overview:
      - Problem: #{summary_data[:problem] || 'N/A'}
      - Solution: #{summary_data[:solution] || 'N/A'}
      - Customer Segment: #{summary_data[:customer_segment] || 'N/A'}
      - Value Proposition: #{summary_data[:value_proposition] || 'N/A'}
      - Key Differentiators: #{summary_data[:key_differentiators] || 'N/A'}

      Based on the above, generate a detailed analysis for: #{field.humanize}.
    PROMPT

    ai_response = OpenAiService.generate_text(prompt)
    update(field => ai_response.strip)
  end

  def generate_ai_suggestions
    prompt = "Provide environment insights for company #{business_idea.title} described: #{business_idea.description} based in country: #{business_idea.country}
              for market research based on:
              Market Trends: #{market_trends}
              Competitor Insights: #{competitor_insights}
              Customer Segments: #{customer_segments}
              Industry Reports: #{industry_reports}"
    ai_response = OpenAiService.generate_text(prompt)
    update(ai_suggestions: ai_response)
    return
  end

  private

  def update_stage_status
    stage = business_idea.stages.find_by(name: "Market Research")
    return unless stage

    stage.update(
      progress_percentage: progress_percentage,
      status: completed? ? :completed : :in_progress
    )
  end
end

