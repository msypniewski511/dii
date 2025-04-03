class OpenAiService
  require 'openai'

  def self.generate_text(prompt, max_tokens: 1000)
    client = OpenAI::Client.new
    
    response = client.chat(
      parameters: {
        model: "gpt-4",
        messages: [
          { role: "system", content: "You are a strategic business planning assistant. Today is #{Date.today.strftime("%B %d, %Y")}. Respond accordingly." },
          { role: "user", content: prompt }
        ],
        temperature: 0.7,
        max_tokens: max_tokens
      }
    )

    response.dig("choices", 0, "message", "content")
  rescue StandardError => e
    Rails.logger.error "OpenAI Error: #{e.message}"
    "AI generation failed. Please try again."
  end
end

# # app/services/open_ai/open_ai_service.rb
# require 'openai'

# class OpenAiService
#   def self.generate_text(prompt, max_tokens: 1000, temperature: 0.7)
#     client = OpenAI::Client.new

#     response = client.chat(
#       parameters: {
#         model: "gpt-4",
#         messages: [
#           { role: "system", content: "You are a strategic business planning assistant. Today is #{Date.today.strftime("%B %d, %Y")}. Respond accordingly." },
#           { role: "user", content: prompt }
#         ],
#         temperature: temperature,
#         max_tokens: max_tokens
#       }
#     )

#     response.dig("choices", 0, "message", "content")
#   rescue => e
#     Rails.logger.error "[OpenAiService Error] #{e.class}: #{e.message}"
#     "AI generation failed. Please try again."
#   end
# end
