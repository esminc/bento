source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.0.1'

gem 'jbuilder'
gem 'pg'
gem 'puma'
gem 'sass-rails'
gem 'seed-fu'
gem 'slim-rails'

group :development, :test do
  gem 'bullet'
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'rubocop', require: false
  gem 'slim_lint'
end

group :test do
  gem 'database_rewinder'
  gem 'factory_girl_rails'
  gem 'ffaker'
  gem 'rspec-rails'
end

group :development do
  gem 'annotate'
  gem 'listen'
end
