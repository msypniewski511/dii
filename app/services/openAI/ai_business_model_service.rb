module OpenAI
  class AiBusinessModelService
    require 'openai'
  
    def self.generate_suggestions(bmc_section, user_input = nil, industry = nil, competitors = nil)
      client = OpenAI::Client.new
      
      prompt = build_prompt(bmc_section, user_input, industry, competitors)
  
      response = client.chat(
        parameters: {
          model: "gpt-4",
          messages: [{ role: "user", content: prompt }],
          temperature: 0.7
        }
      )
  
      response.dig("choices", 0, "message", "content") || "No AI suggestion available."
    end
  
    private
  
    def self.build_prompt(section, user_input, industry, competitors)
      base_prompt = "Generate business model insights for #{section}."
      
      if user_input
        base_prompt += " User's input: #{user_input}."
      end
  
      if industry
        base_prompt += " Business operates in the #{industry} industry."
      end
  
      if competitors
        base_prompt += " Competitors include: #{competitors.join(', ')}."
      end
  
      base_prompt
    end
  end  
end