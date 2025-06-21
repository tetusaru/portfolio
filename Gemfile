source "https://rubygems.org"

gem "rails", "~> 8.0.1"
gem "propshaft"
gem "pg", "~> 1.1"
gem "puma", ">= 5.0"
gem "jsbundling-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "cssbundling-rails"
gem "jbuilder"

gem "aws-sdk-s3", require: false

# gem 'tzinfo-data', platforms: %i[ windows jruby ]

gem "solid_cache"
gem "solid_queue", "1.1.4"
gem "solid_cable", "~> 3.0.5"

gem "bootsnap", require: false
gem "kamal", require: false
gem "thruster", require: false

gem "sorcery", "0.16.3"
gem "image_processing", "~> 1.2"

gem "omniauth"
gem "omniauth-google-oauth2"

group :development, :test do
  # gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"  ← 一時的にコメントアウト
  gem "brakeman", "~> 7.0.0"
  gem "rubocop-rails-omakase", require: false
  gem "dotenv-rails"
  gem "rspec-rails"
  gem 'rails-i18n'
  gem 'factory_bot_rails'
end

group :development do
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
  gem 'shoulda-matchers', '~> 5.3'
end
