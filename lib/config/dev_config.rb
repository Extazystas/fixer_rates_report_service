require 'anyway_config'

class DevConfig < Anyway::Config
  attr_config s3_enabled: false,
              gcs_enabled: false,
              report_formats: ['html', 'csv', 'xls', 'json']
end
