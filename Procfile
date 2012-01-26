### This is the development environment foreman file. Use like this: ###
### bundle exec foreman start -f ./Procfile web=4 worker=1
web: bundle exec rails server thin start
worker: bundle exec rake jobs:work
