### This is the development environment foreman file. Use like this: ###
### bundle exec foreman start -f ./Procfile web=4 worker=1
web: bundle exec thin start
node: redis-server /usr/local/etc/redis.conf
#jug: juggernaut
worker: bundle exec rake jobs:work
log: tail -f -n 0 log/development.log
