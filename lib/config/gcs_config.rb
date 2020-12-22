require 'anyway_config'

class GCSConfig < Anyway::Config
  attr_config :project_id, :credentials, :storage_bucket, :bucket_file_path

  def storage_configured?
    !project_id.nil? && !credentials.nil? && !storage_bucket.nil?
  end
end
