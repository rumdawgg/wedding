set :rails_env, 'stage'
set :stage, 'stage'
    server '192.168.33.33', roles: %w{app db web}

namespace :deploy do
  task :restart do
    invoke 'deploy:rolling_restart'
  end
end