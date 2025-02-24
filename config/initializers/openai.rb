# config/initializers/openai.rb
require "openai"

OpenAI.configure do |config|
  # config.access_token = Rails.credentials.open_ai_access_token!  # Set this environment variable with your API key
  config.access_token = Rails.application.credentials.open_ai_access_token!
  config.log_errors = true
end