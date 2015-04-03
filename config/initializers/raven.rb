# require 'raven'

# Raven.configure do |config|
#   config.dsn = 'https://2dd21f55f45843669fc58604bc0e78d2:bde03fe831af42d3a2ac0c9d0f06b8e1@app.getsentry.com/40870'
# end


if Rails.env.staging? || Rails.env.production?
  require 'raven'

  Raven.config do |config|
    config.dns = ENV['SENTRY_DNS']
  end
end
