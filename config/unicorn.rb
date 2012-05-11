worker_processes 3 # amount of unicorn workers to spin up
timeout 30 # restarts workers that hang for 30 seconds
Configurator::DEFAULTS[:logger].formatter = Logger::Formatter.new #Keep rails from overriding the default logger
