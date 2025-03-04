# frozen_string_literal: true

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
  config.shared_context_metadata_behavior = :apply_to_host_groups

  config.before(:each, type: :system) do
    driven_by(:rack_test) # Use :selenium for JavaScript-driven tests
  end

  config.before(:each, :js, type: :system) do
    driven_by(:selenium_chrome_headless)
  end

  config.after(:each) do
    Capybara.reset_sessions!
  end
end
