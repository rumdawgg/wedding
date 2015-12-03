set :rails_env, 'stage'
set :stage, 'stage'
    server 'aria.lan.chicarello.com', roles: %w{app db web}

namespace :deploy do
  task :restart do
    invoke 'deploy:simultaneous_restart'
  end
end