require "bundler/capistrano"

set :application,       "dynastyowner"
set :domain,            "dynastyowner.net"
set :deploy_to,         "/var/www/dynasty"
set :user,              "sshadmin@dynastyowner.net"
set :scm_passphrase,     "QnKFTK42"

server "dynastyowner.net", :web, :app, :db, :primary => true



set :keep_releases,     3
set :scm,               :git
set :repository,        "git@github.com:bamurphymac/Dynasty.git"
set :scm_verbose, true
#set :scm_username       "bamurphymac"
#set :scm_passphrase, ""  # The deploy user's password

set :git_enable_submodules, 1
set :branch,            "master"

#default_run_options[:pty] = true
ssh_options[:forward_agent] = true
set :deploy_via, :remote_cache
set :git_enable_submodules, 1
after "deploy", "deploy:cleanup" # keep only the last 5 releases
after "deploy", "bundle install --deployment"
