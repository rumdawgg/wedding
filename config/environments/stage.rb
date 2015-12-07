Rails.application.configure do
  config.cache_classes = true

  config.eager_load = true

  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  config.serve_static_assets = false

  config.assets.js_compressor  = Uglifier.new(compress: {unused: false})
  # config.assets.css_compressor = :sass

  config.assets.compile = false

  config.assets.digest = true

  config.log_level = :debug

  config.force_ssl = false

  config.i18n.fallbacks = true

  # Send deprecation notices to registered listeners.
  config.active_support.deprecation = :notify

  config.log_formatter = ::Logger::Formatter.new
  config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
end
