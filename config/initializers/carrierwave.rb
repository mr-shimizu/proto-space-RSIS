CarrierWave.configure do |config|
  # 画像更新時に以前のバージョンを削除する。
  config.remove_previously_stored_files_after_update = true
end
