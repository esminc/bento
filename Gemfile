source 'https://rubygems.org'

ruby '2.4.0'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '5.0.1'

gem 'bootstrap-sass'
gem 'holiday_jp'
gem 'jquery-rails'
gem 'pg'
gem 'puma'
gem 'sass-rails'
gem 'seed-fu'
gem 'slim-rails'

group :development, :test do
  gem 'dotenv-rails'
  gem 'bullet'
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'rubocop', require: false
  gem 'slim_lint'
end

group :test do
  gem 'capybara'
  gem 'database_rewinder'
  gem 'factory_girl_rails'
  gem 'ffaker'
  gem 'rspec-rails'
  gem 'timecop'
end

group :development do
  gem 'annotate'
  gem 'listen'
end
