CarrierWave.configure do |config|
  if Rails.env.staging? || Rails.env.production?
  config.storage = :fog 
  config.fog_credentials = {
    :provider              => 'AWS',                       
    :aws_access_key_id     => ENV['S3_ACCESS_KEY'],                       
    :aws_secret_access_key => ENV['S3_SECRET_KEY'],                       
  }
  config.fog_directory  = ENV['S3_BUCKET']
  else
    config.storage = :file
    config.enable_processing = Rails.env.development?
  end                         
end


