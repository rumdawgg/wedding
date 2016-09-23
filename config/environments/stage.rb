Rails.application.configure do
  config.cache_classes = true
  config.eager_load = true
  config.consider_all_requests_local = false
  config.action_controller.perform_caching = true
  config.serve_static_files = false
  config.assets.js_compressor = :uglifier
  config.assets.compile = false
  config.assets.digest = true
  config.assets.version = '1.0'
  config.log_level = :info
  config.colorize_logging = false
  config.i18n.fallbacks = true
  config.active_support.deprecation = :notify
  config.log_formatter = ::Logger::Formatter.new
  config.active_record.dump_schema_after_migration = false
  config.active_record.raise_in_transactional_callbacks = false
  host = ENV["SERVER_HOSTNAME"] || 'localhost'
  ActionMailer::Base.delivery_method = :sendmail
  config.action_mailer.asset_host = "http://#{host}"
  config.action_mailer.default_url_options = { host: host, protocol: 'http' }
end
