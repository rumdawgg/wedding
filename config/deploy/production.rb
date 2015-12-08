set :rails_env, 'production'
set :stage, 'production'
    server 'vernaccia.chicarello.com', roles: %w{app db web}


  namespace :deploy do
  	task :restart do
    invoke 'deploy:simultaneous_restart'
  end

end