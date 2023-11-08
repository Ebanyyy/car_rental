source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.2"
gem "rails", "~> 7.0.8"
gem "pg", "~> 1.1"
gem "puma", "~> 5.0"


gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "sassc-rails"
gem "bootstrap", "~> 5.3.2"
gem "autoprefixer-rails"
gem "braintree"
gem "gon", "~> 5.1.2"

gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]
gem "bootsnap", require: false

gem "devise"

# S3 aws setup gem
gem "image_processing", "~> 1.2"
gem "aws-sdk-s3", "~> 1"

group :development, :test do
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
end

group :development do
  gem "web-console"

    # Deployment
  gem 'capistrano', '< 5'
  gem 'capistrano-rvm'
  gem 'capistrano-rails'
  gem 'capistrano-bundler'
  gem 'capistrano3-puma', '< 5'
  gem 'capistrano3-nginx'
  gem 'capistrano-rails-console'
  gem 'capistrano-rails-tail-log'
  gem 'capistrano-rails-db'
  gem 'capistrano-rake', require: false
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
end
