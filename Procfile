#web: bundle exec unicorn_rails -p $PORT -c ./config/unicorn.rb
web: bundle exec rails server thin -p 3000
web: bundle exec rails server thin -p 3001
web: bundle exec rails server thin -p 3002
worker: bundle exec rake jobs:work --trace
#clock: bundle exec clockwork clock.rb
