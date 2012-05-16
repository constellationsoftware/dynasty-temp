### This is the development environment foreman file. Use like this: ###
### bundle exec foreman start -f ./Procfile -c web=4 worker=1


web: bundle exec thin start -p 5000 -e development
jobs: rake jobs:work
juggernaut: ./script/juggernaut_listener




#web:                 rails server thin start -p $PORT
#jobs:                rake jobs:work
#pusher-presence:     ./script/pusher
#juggernaut:          ./script/juggernaut_listener
#
##redis:              redis-server /usr/local/etc/redis.conf
##log:                tail -f -n 0 log/development.log
#
