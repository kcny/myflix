if Rails.env.staging? || Rails.env.production?
  require 'raven'

  Raven.config do |config|
    config.dns = ENV['SENTRY_DNS']
  end
end
