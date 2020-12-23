require 'anyway_config'

class DevConfig < Anyway::Config
  attr_config s3_enabled: false,
              gcs_enabled: false,
              report_formats: %w[html csv xls json],
              proxy_api_url: 'http://localhost:4567/api/v1',
              base_currency: 'EUR',
              target_currencies: ['USD']
end
