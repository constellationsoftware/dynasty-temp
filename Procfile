#web: bundle exec unicorn_rails -p $PORT -c ./config/unicorn.rb
web: bundle exec rails server thin -p 5000
#web: bundle exec rails server thin -p 5001
#web: bundle exec rails server thin -p 5002
worker: bundle exec rake jobs:work --trace
#clock: bundle exec clockwork clock.rb
