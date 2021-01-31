if Rails.env.production? || ENV['SENTRY_ACTIVATED']
  Sentry.init do |config|
    config.dsn = 'https://7f4becb415ba451f863a276c6acdcff9@o513694.ingest.sentry.io/5616033'
    config.breadcrumbs_logger = [:active_support_logger]

    config.traces_sample_rate = 1
  end
end
