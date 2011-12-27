#web: bundle exec unicorn_rails -p $PORT -c ./config/unicorn.rb
web: bundle exec rails server thin -p $PORT -e $RACK_ENV
worker: bundle exec rake jobs:work --trace
