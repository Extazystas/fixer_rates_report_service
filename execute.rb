BASE_PATH = './lib'.freeze

%w[services formatters config uploaders].each do |dir|
  Dir["#{BASE_PATH}/#{dir}/*.rb"].each { |file| require_relative file }
end

begin
  require 'anyway_config'
  require 'pry'
  require 'ruby-progressbar'
  require 'rspec'
rescue LoadError => e
  puts "#{e}. Installing..."
  # Installing missed gems
  system('gem install pry')
  system('gem install rspec')
  system('gem install anyway_config')
  system('gem install ruby-progressbar')
  puts 'Installation was completed successfully. Please re-run the program'
  exit
end

Anyway::Settings.default_config_path = ->(name) { "#{BASE_PATH}/config/settings/#{name}.yml" }

# Report generation workflow:
rates_info = RatesFetcher.call
ReportsGenerator.new(rates_info).call
ReportsUploader.call if ENV['RACK_ENV'] == 'production'
