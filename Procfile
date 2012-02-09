### This is the development environment foreman file. Use like this: ###
### bundle exec foreman start -f ./Procfile -c web=4 worker=1
web: bundle exec rails server thin start -p $PORT
worker: bundle exec rake jobs:work
#log: tail -f -n 0 log/development.log
