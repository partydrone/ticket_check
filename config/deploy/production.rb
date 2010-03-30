require 'rt_capistrano'

set :site,         "82472"
set :application,  "brandieframpton2010"
set :webpath,      "brandieframpton2010.com"
set :domain,       "whiteboxmedia.com"              #
set :user,         "serveradmin%whiteboxmedia.com"  # change to Miles' server info
set :password,     "dogVE13@"                 #
set :use_sudo,      false

# these shouldn't be changed
role :web, "#{domain}"
role :app, "#{domain}"
role :db,  "#{domain}", :primary => true
set :deploy_to,    "/home/#{site}/containers/rails/#{application}"

# repository elsewhere
# set :branch, "master"
