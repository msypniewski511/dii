module OpenAI
  class FundingPlanGenerator
    def initialize(business_idea)
      @business_idea = business_idea
      
    end

    def bank_loan_borrowing
      client = OpenAI::Client.new(access_token: ENV['OPENAI_API_KEY'])
      prompt = <<~PROMPT
        Write a 300-word plan and exactly 300 words with 10% margin, explaining how to secure a £25,000 bank loan using the 5 Cs of Credit for a business idea: "#{@business_idea.description}".
        Structure using:
        - Character
        - Capacity
        - Capital
        - Collateral
        - Conditions
      PROMPT

      response = client.chat(
        parameters: {
          model: "gpt-4",
          messages: [{ role: "system", content: prompt }],
          max_tokens: 2500
        }
      )

      content = response.dig("choices", 0, "message", "content")

      Rails.logger.info "Raw AI Response Content: #{content.inspect}"
      content
    end

    def alternative_funding
      client = OpenAI::Client.new(access_token: ENV['OPENAI_API_KEY'])
      prompt = <<~PROMPT
        Write a 300-word explanation discussing one alternative funding source instead of a £25,000 bank loan for a business idea: "#{@business_idea.description}".
        Explain:
        - Why it's a better option
        - Its advantages and disadvantages
      PROMPT

      response = client.chat(
        parameters: {
          model: "gpt-4",
          messages: [{ role: "system", content: prompt }],
          max_tokens: 2500
        }
      )

      content = response.dig("choices", 0, "message", "content")
    end
  end
end