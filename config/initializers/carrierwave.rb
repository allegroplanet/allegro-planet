CarrierWave.configure do |config|
  config.storage    = :aws
  config.aws_bucket = Figaro.env.aws_allegro_planet_bucket

  config.aws_credentials = {
    access_key_id:     Figaro.env.aws_access_key_id,
    secret_access_key: Figaro.env.aws_secret_access_key,
    region:            Figaro.env.aws_region
  }
end
