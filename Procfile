#web: bundle exec unicorn_rails -p $PORT -c ./config/unicorn.rb
web: bundle exec rails server thin start --servers 3 -e development
worker: bundle exec rake jobs:work --trace
#clock: bundle exec clockwork clock.rb
