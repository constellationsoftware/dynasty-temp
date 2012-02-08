### This is the development environment foreman file. Use like this: ###
### bundle exec foreman start -f ./Procfile web=4 worker=1
#redis: redis-server /usr/local/etc/redis.conf
#jug: juggernaut
web: bundle exec rails server thin start -p $PORT
worker: bundle exec rake jobs:work --trace
#log: tail -f -n 0 log/development.log
