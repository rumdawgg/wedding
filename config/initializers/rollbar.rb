require 'rollbar/rails'
Rollbar.configure do |config|
  # Without configuration, Rollbar is enabled in all environments.
  # To disable in specific environments, set config.enabled=false.

  config.access_token = '78a045fd595846199397295062ffa7a1'

  unless Rails.env.production?
    config.enabled = false
  end

end
