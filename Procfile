### This is the development environment foreman file. Use like this: ###
### bundle exec foreman start -f ./Procfile -c web=4 worker=1

web:                bundle exec rails server thin start -p $PORT
jobs:               bundle exec rake jobs:work
pusher-presence:    bundle exec ./script/pusher
juggernaut:         bundle exec ./script/juggernaut_listener

#redis:             bundle exec redis-server /usr/local/etc/redis.conf
#log:               bundle exec tail -f -n 0 log/development.log
