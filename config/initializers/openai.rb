# config/initializers/openai.rb
require "openai"

OpenAI.configure do |config|
  config.access_token = Rails.application.credentials.dig(:open_ai_access_token) || ENV["OPENAI_API_KEY"]

  if config.access_token.nil?
    Rails.logger.warn("⚠️ OpenAI API key is missing! Some features may not work.")
  end

  config.log_errors = true
end