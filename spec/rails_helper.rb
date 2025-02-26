# frozen_string_literal: true

# This file is copied to spec/ when you run 'rails generate rspec:install'
require "spec_helper"
# require "simplecov"
# SimpleCov.start
ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require "rspec/rails"
require "devise"
# require "support/request_macros"

Rails.root.glob("spec/support/**/*.rb").sort.each { |f| require f }

# Checks for pending migrations and applies them before tests are run.
# If you are not using ActiveRecord, you can remove these lines.
# begin
#   ActiveRecord::Migration.maintain_test_schema!
# rescue ActiveRecord::PendingMigrationError => e
#   abort e.to_s.strip
# end
RSpec.configure do |config|
  config.before(:suite) do
    Rails.application.load_tasks
    Rake::Task["db:test:prepare"].invoke
  end
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!

  # Filter lines from Rails gems in backtraces.
  config.filter_rails_from_backtrace!
  # arbitrary gems may also be filtered via:
  # config.filter_gems_from_backtrace("gem name")
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.include Devise::Test::ControllerHelpers, type: :views
  # config.extend ControllerMacros, type: :controller
  # config.extend SystemMacros, type: :system
  # config.extend RequestMacros, type: :request
  config.include Devise::Test::IntegrationHelpers, type: :request
  config.include Devise::Test::IntegrationHelpers, type: :feature

  # Include Warden test helpers
  config.include Warden::Test::Helpers, type: :system

  # Clean up Warden state after each test
  config.after do
    Warden.test_reset!
  end
  config.example_status_persistence_file_path = "spec/examples.txt"
  # config.action_mailer.preview_path = Rails.root.join("spec/mailers/previews")
end
