# config valid only for current version of Capistrano
lock '3.4.0'

set :application, 'wedding'
set :repo_url, 'git@github.com:rumdawgg/wedding.git'
set :scm, :git

# Run with cap production deploy branchname=master
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
set :rollbar_token, '78a045fd595846199397295062ffa7a1'
set :rollbar_env, Proc.new { fetch :stage }
set :rollbar_role, Proc.new { :app }

# Run db:migrate only if migrations exist
set :conditionally_migrate, true

# Check custom directories exist
set :custom_directories, %W{local_shared/passenger_restart}

# Default value for :linked_files is []
set :linked_files, %w{config/database.yml config/application.yml config/newrelic.yml}
set :linked_dirs, %w{log tmp/backup tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

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

namespace :newrelic do
  desc "Track release/deployment of code"
  task :track_release
      on roles(:db) do
        unless dry_run
          rails_env = fetch(:rails_env, "production")
        if %w(production demo).include?(ENV['environment'])
          release_desc = "branch #{ variables[:branch]||'master' }"
          revision = variables[:real_revision]
          revision = revision.call if revision.respond_to?(:call)
          unless dry_run
            run_locally "RAILS_ENV=#{rails_env} newrelic deployments '#{release_desc}' -r #{revision}"
          end
        end
      end
    end
end

# Deploy tasks
namespace :deploy do
  desc "Restart application simultaneously on all servers"
  task :simultaneous_restart do
    on roles(:app) do
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

  task :upload_images do
    on roles(:web) do
      upload! "app/assets/images/", "#{release_path}/app/assets/", recursive: true
    end
  end

  # desc "Create an empty database on the db server"
  # task :createdb do
  #   on roles(:db) do
  #       dbuser = 'postgres'
  #       database = "wedding_stage"
  #       execute :createdb, "-U #{dbuser} #{database} -h localhost"
  #     end
  # end

  before :deploy, 'environment_check:all'
  before :updated, 'deploy:upload_images'
  after :publishing, :simultaneous_restart
  after :restart, 'maint:down', 'newrelic:track_release'

end
