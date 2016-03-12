set :rails_env, 'production'
set :stage, 'production'
    server 'vernaccia.chicarello.com', roles: %w{app db web}
