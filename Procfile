### This is the development environment foreman file. Use like this: ###
### bundle exec foreman start -f ./Procfile -c web=4 worker=1


web: 					bundle exec thin start -p 5000 -e development
jobs: 					rake jobs:work
#guard:					bundle exec guard
juggernaut-server:		node_modules/.bin/juggernaut
juggernaut-listener: 	./script/juggernaut_listener
log:                tail -f -n 0 log/development.log



#web:                 rails server thin start -p $PORT
#jobs:                rake jobs:work
#pusher-presence:     ./script/pusher
#juggernaut:          ./script/juggernaut_listener
#
##redis:              redis-server /usr/local/etc/redis.conf
##log:                tail -f -n 0 log/development.log
#
