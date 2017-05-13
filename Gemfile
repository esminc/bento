source 'https://rubygems.org'

ruby '2.4.1'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '5.1.2'

gem 'airbrake', '~> 5.0' # errbit から、バージョン指定しろとの指示
gem 'bootsnap'
gem 'bootstrap-sass'
gem 'faraday'
gem 'holiday_jp'
gem 'jquery-rails'
gem 'pg'
gem 'puma'
gem 'sass-rails'
gem 'seed-fu'
gem 'slim-rails'
gem 'turbolinks'

group :development, :test do
  gem 'bullet'
  gem 'dotenv-rails'
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'rubocop', require: false, github: 'bbatsov/rubocop'
  gem 'slim_lint'
end

group :test do
  gem 'capybara'
  gem 'database_rewinder'
  gem 'factory_girl_rails'
  gem 'ffaker'
  gem 'launchy'
  gem 'rspec-rails'
  gem 'timecop'
end

group :development do
  gem 'annotate'
  gem 'listen'
end
