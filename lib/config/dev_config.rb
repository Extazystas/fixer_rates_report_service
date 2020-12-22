require 'anyway_config'

class DevConfig < Anyway::Config
  attr_config s3_enabled: false,
              gcs_enabled: false,
              html_format: true,
              xls_format: true,
              json_format: true,
              csv_format: true
end
