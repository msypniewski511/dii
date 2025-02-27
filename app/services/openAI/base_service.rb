module OpenAI
  class BaseService
    def initialize
      @client = OpenAI::Client.new(access_token: Rails.credentials.open_ai_access_token!)
    end
    def speech(text)
      @client.audio.speech(
        parameters: {
          model: "tts-1",
          input: text,
          voice: "alloy"
        }
      )
    end
  end
end