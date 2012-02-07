### This is the development environment foreman file. Use like this: ###
### bundle exec foreman start -f ./Procfile web=4 worker=1
#redis: redis-server /usr/local/etc/redis.conf
#jug: juggernaut
web: bundle exec thin start
#worker: bundle exec rake jobs:work
log: tail -f -n 0 log/development.log
