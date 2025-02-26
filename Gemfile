source "https://rubygems.org"

ruby "3.2.2"

gem "rails", "~> 7.1.5"
gem "sprockets-rails"
gem "sqlite3", ">= 1.4"
gem "puma", ">= 5.0"
gem "jsbundling-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "cssbundling-rails"
gem "jbuilder"
gem "tzinfo-data", platforms: %i[ windows jruby ]
gem "bootsnap", require: false


group :development, :test do
  gem "capybara"
  gem "debug", platforms: %i[mri windows]
  gem "factory_bot"
  gem "guard-rspec", require: false
  gem "rspec-rails", "~> 6.1.0"
  gem "selenium-webdriver", "~> 4.4"
  gem 'database_cleaner-active_record' # Cleans test database
end

group :development do
  gem "web-console"
  gem "letter_opener"
end

group :test do
  gem 'rails-controller-testing'
  gem 'faker'          # Generates random test data
end

gem "test", "~> 1.0", :group => :development
gem "image_processing", "~> 1.2"
gem "ruby-openai"
gem "sidekiq", "~> 7.3"
gem 'country_select', '~> 8.0'
gem "devise", "~> 4.9"
