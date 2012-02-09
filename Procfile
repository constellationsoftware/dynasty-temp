### This is the development environment foreman file. Use like this: ###
<<<<<<< HEAD
### bundle exec foreman start -f ./Procfile web=4 worker=1
#redis: redis-server /usr/local/etc/redis.conf
#jug: juggernaut
web: bundle exec rails server thin start -p $PORT
worker: bundle exec rake jobs:work --trace
=======
### bundle exec foreman start -f ./Procfile -c web=4 worker=1
web: bundle exec rails server thin start -p $PORT
#node: redis-server /usr/local/etc/redis.conf
#jug: juggernaut
worker: bundle exec rake jobs:work
>>>>>>> d14648eeff8e50f9d631f62fa507bf1148aa7327
#log: tail -f -n 0 log/development.log
