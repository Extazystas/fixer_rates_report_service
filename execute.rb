BASE_PATH = './lib'.freeze

Dir["#{BASE_PATH}/services/*.rb"].each   { |file| require_relative file }
Dir["#{BASE_PATH}/formatters/*.rb"].each { |file| require_relative file }
Dir["#{BASE_PATH}/config/*.rb"].each     { |file| require_relative file }

begin
  require 'anyway_config'
  require 'pry'
  require 'progressbar'
  require 'rspec'
rescue LoadError => e
  puts "#{e}. Installing..."
  # Installing missed gems
  system('gem install pry')
  system('gem install rspec')
  system('gem install progressbar')
  system('gem install anyway_config')
  puts 'Installation was completed successfully. Please re-run the program'
  exit
end

Anyway::Settings.default_config_path = ->(name) { "#{BASE_PATH}/config/settings/#{name}.yml" }

ReportsGenerator.new.call
ReportsUploader.new.call if ENV['RACK_ENV'] == 'production'
