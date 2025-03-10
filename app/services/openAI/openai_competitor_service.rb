module OpenAI
  class OpenaiCompetitorService
    require 'openai'
  
    def self.find_competitors(business_idea)
      client = OpenAI::Client.new(access_token: ENV['OPENAI_API_KEY'])

      prompt = "Find five competing companies based on the following business idea:\n\n" \
               "Business Idea: #{business_idea.description}\n" \
               "Country: #{business_idea.country}\n\n" \
               "Provide the competitors in JSON format with fields: name, description."

      response = client.chat(
        parameters: {
          model: "gpt-4",
          messages: [{ role: "system", content: prompt }],
          max_tokens: 500
        }
      )

      # Extract the AI message content
      raw_content = response.dig("choices", 0, "message", "content")
      Rails.logger.info "OpenAI RAW RESPONSE: #{raw_content}"

      # Ensure we have valid content
      return [] if raw_content.blank?

      # First, parse the string into a real JSON object
      begin
        parsed_response = JSON.parse(raw_content)
        return parsed_response if parsed_response.is_a?(Array) # If it's already an array, return it
      rescue JSON::ParserError
        Rails.logger.error "JSON Parsing Error: Trying to re-parse JSON string."
      end

      # If the first parse failed, attempt to extract valid JSON using regex
      json_match = raw_content.match(/\[.*\]/m) # Extracts anything inside [ ]
      if json_match
        begin
          parsed_response = JSON.parse(json_match[0]) # Try parsing again
          return parsed_response if parsed_response.is_a?(Array)
        rescue JSON::ParserError => e
          Rails.logger.error "JSON Parsing Failed Again: #{e.message}"
        end
      end

      # If everything fails, return an empty array
      Rails.logger.error "OpenAI returned an unexpected format."
      return []
    rescue StandardError => e
      Rails.logger.error "OpenAI Competitor Search Error: #{e.message}"
      return []
    end
  end  
end
