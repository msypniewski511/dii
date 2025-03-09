module OpenAI
  class AiCompetitorAnalysis
    require 'openai'
  
    def self.do_analise(competitor)
      client = OpenAI::Client.new(access_token: ENV['OPENAI_API_KEY'])

      prompt = "Assess the strategic strengths: This means evaluate the firm: #{competitor.name} in UK and its industry to determine the better and worse strategies:\n\n" \
               "Provide the response in structured format to display as web list"

      response = client.chat(
        parameters: {
          model: "gpt-4",
          messages: [{ role: "system", content: prompt }],
          max_tokens: 500
        }
      )

      puts "inside AI Competitors"

      # Extract the AI message content
      raw_content = response.dig("choices", 0, "message", "content")
      Rails.logger.info "OpenAI RAW RESPONSE: #{raw_content}"

      # Ensure we have valid content
      return [] if raw_content.blank?

      puts raw_content
      # First, parse the string into a real JSON object
      begin
        parsed_response = (raw_content)
        return parsed_response
      rescue JSON::ParserError
        Rails.logger.error "JSON Parsing Error: Trying to re-parse JSON string."
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
