# config valid only for current version of Capistrano
lock '3.4.0'

set :application, 'wedding'
set :repo_url, 'git@github.com:rumdawgg/wedding.git'


set :scm, :git
# Run with cap production deploy branchname=ops
if "#{ENV['branchname']}".empty?
  set :branch, "master"
else
  set :branch, "#{ENV['branchname']}"
end
set :currentbranch, "current"

# Deploy Settings
set :deploy_user, 'www'
set :deploy_to, "/home/#{fetch(:deploy_user)}/app"
set :keep_releases, 5
set :log_level, :debug
set :format, :pretty
set :pty, true
set :ssh_options, {
  user: "#{fetch(:deploy_user)}",
  forward_agent: true
}

# Run db:migrate only if migrations exist
set :conditionally_migrate, true

# Check custom directories exist
set :custom_directories, %W{local_shared/passenger_restart}

# Default value for :linked_files is []
set :linked_files, %w{config/database.yml config/application.yml}

# Make sure rails and rake commands are called with bundle exec
SSHKit.config.command_map[:rake]  = "bundle exec rake"
SSHKit.config.command_map[:rails] = "bundle exec rails"

# Check files and directories on all servers
namespace :environment_check do
  desc "Check config files exist in shared/config"
  task :config_files do
    on roles(:app, :resque) do |host|
      fetch(:linked_files).each do |file|
        if test "([ -r #{fetch(:deploy_to)}/shared/#{file} ])"
          info "#{fetch(:deploy_to)}/shared/#{file} exists on #{host}"
        else
          error "#{fetch(:deploy_to)}/shared/#{file} do not exist on #{host}"
        end
      end
    end
  end

  desc "Check if custom directories exist"
  task :custom_directories do
    on roles(:app, :resque) do |host|
      fetch(:custom_directories).each do |dir|
        if test "([ -d #{fetch(:deploy_to)}/#{dir} ])"
          info "#{fetch(:deploy_to)}/#{dir} exists on #{host}"
        else
          execute :mkdir, '-p', "#{fetch(:deploy_to)}/#{dir}"
        end
      end
    end
  end

  desc "Run all environment check tasks"
  task :all do
    invoke 'environment_check:config_files'
    invoke 'environment_check:custom_directories'
  end
end

# Maintenance tasks
namespace :maint do
  desc "Setup maintenance page on webserver"
  task :up do
    on roles(:web) do
      within release_path do
        execute :mkdir, "-p public/system"
        execute :cp, "public/system_templates/maintenance.html public/system/maintenance.html"
      end
    end
  end
  
  task :down do
    on roles(:web) do
      within release_path do
        execute :rm, "-f public/system/maintenance.html"
      end
    end
  end
end

# Deploy tasks
namespace :deploy do
    desc "Restart application using a rolling restart"
    task :rolling_restart do
        on roles(:app), in: :sequence, wait: 10 do |host|
            info "[deploy:rolling_restart] Restarting passenger on #{host}"
            execute :touch, "#{fetch(:deploy_to)}/local_shared/passenger_restart/restart.txt"
        end
    end

  desc "Check if downtime is required and bring site down"
  task :downtime do
    on roles(:db) do
      if fetch(:conditionally_migrate) && test("diff -q #{release_path}/db/migrate #{current_path}/db/migrate")
        info "[deploy:downtime] Skip `deploy:downtime` No downtime necessary"
      else
        info "[deploy:downtime] Bringing site down to run migrations"
        invoke 'maint:up'
      end
    end
  end
  
  desc "Create an empty database on the db server"
  task :createdb do
    on roles(:db) do
        dbuser = 'postgres'
        database = "wedding_stage"
        execute :createdb, "-U #{dbuser} #{database} -h localhost"
      end
  end

  before :deploy, 'environment_check:all'
  #before :deploy, 'deploy:createdb'
  after :publishing, :restart
  after :restart, 'maint:down'

end