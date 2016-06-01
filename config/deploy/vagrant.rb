set :rails_env, 'stage'
set :stage, 'stage'

server '192.168.33.33', roles: %w{web app db}, ssh_options: { user_known_hosts_file: '/dev/null' }
