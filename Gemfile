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
  gem "debug", platforms: %i[ mri windows ]
  gem 'rspec-rails', '~> 7.0.0'
  gem 'capybara'

  gem 'selenium-webdriver'
end

group :development do
  gem "web-console"
end

group :test do
end


gem "test", "~> 1.0", :group => :development
gem "image_processing", "~> 1.2"
gem "ruby-openai"