module OpenAI
  class AiPorterAnalysis
    require "openai"

    def self.call(industry)
      client = OpenAI::Client.new
      response = client.chat(
        parameters: {
          model: "gpt-4",
          messages: [
            { role: "system", content: "Provide a competitive analysis of an industry using Porter's Five Forces." },
            { role: "user", content: "Analyze the #{industry} industry using Porter's Five Forces. Provide five scores from 1 to 5 for the following: 
              (1) Threat of New Entrants, 
              (2) Bargaining Power of Suppliers, 
              (3) Bargaining Power of Buyers, 
              (4) Threat of Substitutes, 
              (5) Industry Rivalry.
              
              Respond **only** with five comma-separated numbers (e.g., '3,2,4,5,1'). No additional text."
            }
          ]
        }
      )

      # Extract numbers safely
      content = response.dig("choices", 0, "message", "content")
      return default_scores unless content # Fallback if AI response is missing

      scores = content.scan(/\d+/).map(&:to_i) # Extracts only numbers from AI response
      puts scores
      # Ensure exactly 5 scores (fallback if AI messes up)
      scores = normalize_scores(scores)

      {
        threat_of_new_entrants: scores[0],
        supplier_power: scores[1],
        buyer_power: scores[2],
        threat_of_substitutes: scores[3],
        industry_rivalry: scores[4]
      }
    end

    private

    def self.default_scores
      { 
        threat_of_new_entrants: 1, 
        supplier_power: 1, 
        buyer_power: 1, 
        threat_of_substitutes: 1, 
        industry_rivalry: 1 
      }
    end

    def self.normalize_scores(scores)
      while scores.length < 5
        scores << 1 # Fill missing values with 1 (default)
      end
      scores.first(5) # Ensure only 5 values
    end
  end  
end
