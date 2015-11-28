set :rails_env, 'production'
set :stage, 'production'
    server 'rails.lan.chicarello.com', roles: %w{app db web}

namespace :deploy do
    puts "Please run 'git push heroku master' for the production deploy task"
    exit
end