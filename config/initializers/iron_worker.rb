IronWorker.configure do |config|
  config.token = 'H-6n-pFsiR4RFiwJFPnhXW7E8WI'
  config.project_id = '4eebc865066bce1a4e0007a0'
  # Use the line below if you're using an ActiveRecord database
  config.database = Rails.configuration.database_configuration[Rails.env]
end