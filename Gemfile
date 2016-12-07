source 'https://rubygems.org'
gemfury = 'https://y6TLVUYJ6czrKHgA69ur@gem.fury.io/patientslikeme/'

gem 'rails',                '4.2.5.2'

# Rails
gem 'jbuilder'
gem 'turbolinks'

# Capistrano
gem 'capistrano', '~> 3.4.0'
gem 'capistrano-bundler', '~> 1.1'
gem 'capistrano-passenger'
gem 'capistrano-rails',   '~> 1.1'
gem 'capistrano-rbenv', '~> 2.0'
gem 'capistrano-rails-console'
source gemfury do
  gem 'capistrano_plm', '0.0.11', require: false
  gem 'plm_resque', '0.0.2'
end

# Misc
gem 'rollbar', '~> 2.5.0'
gem 'newrelic_rpm'
gem 'paperclip'
gem 'devise'
gem 'colorize'
gem 'sshkit', '~> 1.7.0'

# Assets
gem 'coffee-rails'
gem 'bootstrap-sass'
gem 'jquery-rails'
gem 'sass-rails'
gem 'uglifier'
gem 'blueimp-gallery'
gem 'bootstrap-will_paginate'
gem 'nested_form_fields'
gem 'bootstrap_form'

# Database
gem 'pg'
gem 'will_paginate'

group :development, :test do
  gem 'byebug'
  gem 'spring'
  gem 'codeclimate-test-reporter'
end

group :test do
  gem 'minitest-reporters', '1.0.5'
  gem 'mini_backtrace',     '0.1.3'
  gem 'guard-minitest',     '2.3.1'
end

group :doc do
  gem 'sdoc',               '~> 0.4.0'
end
