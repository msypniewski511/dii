class MarketResearch < ApplicationRecord
  belongs_to :business_idea

  validates :market_trends, :competitor_insights, :customer_segments, :industry_reports, presence: true

  def generate_ai_suggestions
    prompt = "Provide environment insights for company #{business_idea.title} described: #{business_idea.description} based in country: #{business_idea.country}
              for market research based on:
              Market Trends: #{market_trends}
              Competitor Insights: #{competitor_insights}
              Customer Segments: #{customer_segments}
              Industry Reports: #{industry_reports}"
    puts prompt
    ai_response = OpenAiService.generate_text(prompt)
    update(ai_suggestions: ai_response)
  end
end
