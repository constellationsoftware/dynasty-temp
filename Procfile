#web: bundle exec unicorn_rails -p $PORT -c ./config/unicorn.rb
web: bundle exec rails server thin -p $PORT
#worker: bundle exec rake jobs:work --trace
