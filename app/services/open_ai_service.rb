class OpenAiService
  require 'openai'

  def self.generate_text(prompt)
    client = OpenAI::Client.new
    
    response = client.chat(
      parameters: {
        model: "gpt-4",
        messages: [{ role: "system", content: prompt }],
        temperature: 0.7
      }
    )

    response.dig("choices", 0, "message", "content")
  rescue StandardError => e
    Rails.logger.error "OpenAI Error: #{e.message}"
    "AI generation failed. Please try again."
  end
end
