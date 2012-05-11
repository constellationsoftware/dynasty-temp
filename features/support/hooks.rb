Before do |scenario|
    # puts "FEATURE: #{scenario.feature.name}"
    # puts "SCENARIO: #{scenario.name}"

    # use the server in pow
    # Capybara.app_host = 'http://dynasty.dev'

    # this breaks 'Scenario outline' ?????
    # try using tagged hooks to fix this
    # if scenario.feature.name == 'Dashboard'
    #   Capybara::Server.manual_host = 'bros.dynasty.dev'
    #   Capybara.server_port = 8888
    #   # Capybara.run_server = true
    # end
end
