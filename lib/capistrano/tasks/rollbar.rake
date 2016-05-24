require 'net/http'
require 'rubygems'
require 'json'

# This is copied from rollbar itself with the following changes:
# Only run on 1 server
# Don't hardcode the hook to always run (so we can skip for staging)

namespace :rollbar do
  desc 'Send the deployment notification to Rollbar.'
  task :deploy do
    on primary fetch(:rollbar_role) do
      uri    = URI.parse 'https://api.rollbar.com/api/1/deploy/'
      params = {
        local_username: fetch(:rollbar_user),
        access_token:   fetch(:rollbar_token),
        environment:    fetch(:rollbar_env),
        revision:       fetch(:current_revision) }

      debug "Building Rollbar POST to #{uri} with #{params.inspect}"

      request      = Net::HTTP::Post.new(uri.request_uri)
      request.body = ::JSON.dump(params)

      Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
        http.request(request)
      end

      info 'Rollbar notification complete.'
    end
  end
end

namespace :load do
  task :defaults do
    set :rollbar_user,  proc { ENV['USER'] || ENV['USERNAME'] }
    set :rollbar_env,   proc { fetch :rails_env, 'production' }
    set :rollbar_token, proc { abort "Please specify the Rollbar access token, set :rollbar_token, 'your token'" }
    set :rollbar_role,  proc { :app }
  end
end
