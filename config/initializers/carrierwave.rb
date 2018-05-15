require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'

CarrierWave.configure do |config|
  config.storage = :fog
  config.fog_credentials = {
    provider: 'AWS',
    aws_access_key_id: Rails.application.secrets.aws_access_key_id,
    aws_secret_access_key: Rails.application.secrets.aws_secret_access_key,
    region: 'ap-northeast-1'
  }

  config.fog_directory  = 'bucket-name-upload-test'
  config.asset_host = 'https://s3-ap-northeast-1.amazonaws.com/bucket-name-upload-test'

  # 画像更新時に以前のバージョンを削除する。
  config.remove_previously_stored_files_after_update = true
end
