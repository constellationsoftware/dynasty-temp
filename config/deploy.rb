require "bundler/capistrano"


server "184.107.238.210", :web, :app, :db, primary: true

# Deploy to iweb.com server via fom.beanstalkapp.com
set :application,       "dynastyowner.net"
set :domain,             "dynastyowner.net"
set :deploy_to,         "/home/dynasty_development"
set :user,              "deployer"
set :password,          "fom556"
set :use_sudo,          true



set :keep_releases,     3
set :scm,               :git
set :repository,        "git@fom.beanstalkapp.com:/dynasty.git"
set :scm_verbose, true
#set :scm_username       "bamurphymac"
#set :scm_passphrase, ""  # The deploy user's password

set :git_enable_submodules, 1
set :branch,            "master"

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

after "deploy", "deploy:cleanup" # keep only the last 5 releases
