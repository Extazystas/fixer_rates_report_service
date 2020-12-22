require 'anyway_config'

class AwsConfig < Anyway::Config
  attr_config :access_key_id, :secret_access_key, :storage_bucket, region: 'eu-north-1'

  def storage_configured?
    !access_key_id.nil? && !secret_access_key.nil? && !storage_bucket.nil?
  end
end
