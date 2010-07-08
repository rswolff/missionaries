set :application, "missionaries"

role :web, "192.168.1.10"                          # Your HTTP server, Apache/etc
role :app, "192.168.1.10"                          # This may be the same as your `Web` server
role :db,  "192.168.1.10", :primary => true # This is where Rails migrations will run

before "deploy:setup", :db
after "deploy:update_code", "db:symlink"

set :repository,  "git://github.com/rswolff/missionaries.git"
default_run_options[:pty] = true
set :scm, "git"
set :user, "deploy"
set :branch, "master"
set :deploy_via, :remote_cache
set :scm_verbose, true
#set :git_enable_submodules, 1
set :keep_releases, 3

ssh_options[:port] = 30000
set :use_sudo, true

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

namespace :db do
  desc "Create database yaml in shared path"
  task :default do
    db_config = ERB.new <<-EOF
production:
  username: root
  password: r00t
  adapter: mysql
  encoding: utf8
  database: missionary_production
EOF
    run "mkdir -p #{shared_path}/config"
    put db_config.result, "#{shared_path}/config/database.yml"
  end
    
  desc "Make symlink for database yaml"
  task :symlink do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end
end