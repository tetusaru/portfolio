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

gem "tzinfo-data", platforms: %i[ windows jruby ]

gem "solid_cache"
gem "solid_queue"
gem "solid_cable", "~> 3.0.5"

gem "bootsnap", require: false
gem "kamal", require: false
gem "thruster", require: false

gem "sorcery", "0.16.3"
gem "image_processing", "~> 1.2"

group :development, :test do
  # gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"  ← 一時的にコメントアウト
  gem "brakeman", "~> 7.0.0"
  gem "rubocop-rails-omakase", require: false
end

group :development do
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
end
