set :rails_env, 'stage'
set :stage, 'stage'

server 'winterfell.lan.chicarello.com', roles: %w{web app db}, ssh_options: { user_known_hosts_file: '/dev/null' }
