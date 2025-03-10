module OpenAI
  class AiIndustryClassifier
    require "openai"
  
    def self.call(description)
      client = OpenAI::Client.new
      response = client.chat(
        parameters: {
          model: "gpt-4",
          messages: [
            { role: "system", content: "Classify the business idea into a well-known industry sector." },
            { role: "user", content: "Business Idea: #{description}. What is its industry?" }
          ]
        }
      )
  
      response.dig("choices", 0, "message", "content").strip
    end
  end
end
