require 'rt_capistrano'

set :site,         "8898"                     # change to Miles' server info
set :application,  "brandieframpton2010"
set :webpath,      "brandieframpton2010.com"
set :domain,       "eyequeue.us"              #
set :user,         "serveradmin%eyequeue.us"  # change to Miles' server info
set :password,     "dogVE13@"                 #
set :use_sudo,      false

# these shouldn't be changed
role :web, "#{domain}"
role :app, "#{domain}"
role :db,  "#{domain}", :primary => true
set :deploy_to,    "/home/#{site}/containers/rails/#{application}"

# repository elsewhere
# set :branch, "master"
