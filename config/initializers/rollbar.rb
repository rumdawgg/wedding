Rollbar.configure do |config|
  # Without configuration, Rollbar is enabled in all environments.
  # To disable in specific environments, set config.enabled=false.

  config.access_token = '78a045fd595846199397295062ffa7a1'

  if Rails.env.test? ||  Rails.env == 'stage' || Rails.env == 'development'
    config.enabled = false
  end
  
end
