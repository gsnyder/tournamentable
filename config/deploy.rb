default_run_options[:pty] = true  # Must be set for the password prompt from git to work

set :application, "tournamentable"
set :repository, "git@github.com:tonycoco/#{application}.git"  # Your clone URL
set :scm, "git"
set :branch, "master"
set :user, "tribunedev"  # The server's user for deploys
set :scm_passphrase, "BLAHBLAHBLAH"  # The deploy user's password, yeah right. Replace this!
set :runner, user
set :use_sudo, false
set :deploy_to, "/Users/#{user}/Sites/#{application}"

role :web, "xserve.tii.trb"                          # Your HTTP server, Apache/etc
role :app, "xserve.tii.trb"                          # This may be the same as your `Web` server
role :db,  "xserve.tii.trb", :primary => true        # This is where Rails migrations will run

# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reapear helper you will need
# these http://github.com/rails/irs_process_scripts

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end