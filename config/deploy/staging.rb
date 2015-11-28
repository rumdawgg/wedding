set :rails_env, 'staging'
set :stage, 'staging'
    server '10.0.1.17', roles: %w{app db web}

namespace :deploy do
  task :restart do
    invoke 'deploy:rolling_restart'
  end
end