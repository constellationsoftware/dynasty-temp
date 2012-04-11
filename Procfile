### This is the development environment foreman file. Use like this: ###
### bundle exec foreman start -f ./Procfile -c web=4 worker=1

# Trying out launchd to start redis on boot.
# redis: redis-server /usr/local/etc/redis.conf
web: bundle exec rails server thin start -p $PORT
jobs: rake jobs:work
pusher-presence: ./script/pusher
juggernaut: ./script/juggernaut_listener
#log: tail -f -n 0 log/development.log
