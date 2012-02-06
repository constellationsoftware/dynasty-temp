Before do |scenario|
  # puts "FEATURE: #{scenario.feature.name}"
  # puts "SCENARIO: #{scenario.name}"
  
  Capybara.app_host = 'http://dynasty.dev:88'
  Capybara.run_server = false
end
