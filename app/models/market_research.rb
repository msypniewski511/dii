class MarketResearch < ApplicationRecord
  belongs_to :business_idea

  validates :market_trends, :competitor_insights, :customer_segments, :industry_reports, presence: true

  def generate_ai_suggestions
    prompt = "Provide AI insights for market research based on:
              Market Trends: #{market_trends}
              Competitor Insights: #{competitor_insights}
              Customer Segments: #{customer_segments}
              Industry Reports: #{industry_reports}"
    
    ai_response = OpenAiService.generate_text(prompt)
    update(ai_suggestions: ai_response)
  end
end
