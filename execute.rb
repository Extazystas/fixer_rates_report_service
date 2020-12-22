BASE_PATH = './lib'

Dir["#{BASE_PATH}/services/*.rb"].each   { |file| require_relative file }
Dir["#{BASE_PATH}/formatters/*.rb"].each { |file| require_relative file }

begin
  require 'pry'
  require 'progressbar'
  require 'rspec'
rescue LoadError => e
  puts "#{e}. Installing..."
  # Installing missed gems
  system('gem install pry')
  system('gem install rspec')
  system('gem install progressbar')
  puts 'Installation was completed successfully. Please re-run the program'
  exit
end

ReportsGenerator.new.call
ReportsUploader.new.call if ENV['RACK_ENV'] == 'production'
