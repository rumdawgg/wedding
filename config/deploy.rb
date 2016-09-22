# config valid only for current version of Capistrano
lock '3.4.0'

set :application, 'wedding'
set :repo_url, 'git@github.com:rumdawgg/wedding.git'
set :scm, :git

ask :branch, 'ready_for_production'

set :user, 'www'
set :deploy_to, "/home/#{fetch(:user)}/#{fetch(:application)}"
set :keep_releases, 5
set :log_level, :info
set :format, :pretty

set :ssh_options, user: fetch(:user), forward_agent: true

set :conditionally_migrate, true

set :linked_files, fetch(:linked_files, []).push('config/database.yml',
                                                 'config/secrets.yml',
                                                 'config/newrelic.yml')

set :linked_dirs, fetch(:linked_dirs, []).push('log',
                                               'tmp/backup',
                                               'tmp/pids',
                                               'tmp/cache',
                                               'tmp/sockets',
                                               'public/system',
                                               'vendor/bundle')

set :assets_roles, %w(app web static)
set :migration_role, :app

set :rollbar_token, '78a045fd595846199397295062ffa7a1'
set :rollbar_env, proc { fetch :stage }
set :rollbar_role, proc { :app }

set :passenger_check_url, 'http://localhost:8888'
set :maintenance_fetch_url, 'http://localhost:8888/maintenance'
