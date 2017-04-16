Airbrake.configure do |config|
  config.host = ENV['ERRBIT_HOST']
  config.project_id = 1 # required, but any positive integer works
  config.project_key = ENV['ERRBIT_PROJECT_KEY']

  config.environment = Rails.env
  config.ignore_environments = %w(development test)
end
