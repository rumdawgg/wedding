set :rails_env, 'production'
set :stage, 'production'
    server 'test-wedding.chicarello.com', roles: %w{app db web}

namespace :deploy do
  task :restart do
    invoke 'deploy:rolling_restart'
  end
end