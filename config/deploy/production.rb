set :rails_env, 'production'

set :stage, 'production'

server 'wedding-web01.chicarello.com', roles: %w(web app db)

set :merge_branch, 'current'

after 'deploy:finished', 'newrelic:notice_deployment'
after 'deploy:finished', 'rollbar:deploy'
# after 'deploy:finished', 'git:tag'
# after 'deploy:finished', 'git:merge_release'
