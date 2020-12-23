require 'active_support/core_ext/integer/time'
require 'rspec'
require 'pry'

# NOTE: This does not work for some reason:
# BASE_PATH = '../lib'.freeze

# %w[services formatters config uploaders].each do |dir|
#   Dir["#{BASE_PATH}/#{dir}/*.rb"].each { |file| require_relative file }
# end

require_relative '../lib/config/dev_config'
require_relative '../lib/config/aws_config'
require_relative '../lib/config/gcs_config'

require_relative '../lib/services/rates_fetcher'
require_relative '../lib/services/reports_generator'
require_relative '../lib/services/reports_uploader'

require_relative '../lib/uploaders/aws'
require_relative '../lib/uploaders/google_cloud_storage'
require_relative '../lib/uploaders/local'

require_relative '../lib/formatters/html_formatter'
require_relative '../lib/formatters/json_formatter'
require_relative '../lib/formatters/xls_formatter'
require_relative '../lib/formatters/csv_formatter'

begin
  require 'pry'
  require 'rspec'
rescue LoadError => e
  puts "#{e}. Installing..."
  # Installing missed gems
  system('gem install pry')
  system('gem install rspec')
  puts 'Installation was completed successfully. Please re-run the program'
  exit
end
