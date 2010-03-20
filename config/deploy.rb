set :stages, %w(staging production)
set :default_stage, 'staging'
require 'capistrano/ext/multistage'

# repository elsewhere
set :scm, :git
set :repository, "git@home.eyequeue.us:Repositories/wavetronix.git"
set :ssh_options, { :forward_agent => true }
set :deploy_via, :remote_cache

namespace :deploy do
  task :default do
    set(:branch) do
      br = Capistrano::CLI.ui.ask "What branch do you want to deploy?: ".downcase
      raise 'Cannot deploy master branch to production.' if (stage == 'production') && br == 'master'
      br
    end
    puts "*** Deploying to the #{stage} server!"
    update
    restart
    
    # Clean up old deployments
    deploy.cleanup
    
    # Send deployment notification except, for the default stage
  end
  
  # override migrations task to inject branch
  desc <<-DESC
  Deploy and run pending migrations. This will work similarly to the \
  'deploy' task, but will also run any pending migrations (via the \
  'deploy:migrate' task) prior to updating the symlink. Note that the \
  update in this case it is not atomic, and transactions are not used, \
  because migrations are not guaranteed to be reversible.
  DESC
  task :migrations do
    set :migrate_target, :latest
    set(:branch) do
      br = Capistrano::CLI.ui.ask 'What branch do you want to deploy?: '.downcase
      raise 'Cannot deploy master branch to production.' if (stage.upcase == 'PRODUCTION') && br == 'master'
      br
    end
    puts "*** Deploying to the #{stage} server!"
    update_code
    migrate
    symlink
    restart

    # cleanup old deployments
    deploy.cleanup

    # Send deployment notification, except for the default stage
  end
  
  desc "Create symlink to shared files and folders on each release."
  task :symlink_shared do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end
  
  after "deploy:update_code", "deploy:symlink_shared"
end
