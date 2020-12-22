require 'rspec'
require 'pry'

BASE_PATH = '../lib'.freeze

Dir["#{BASE_PATH}/services/*.rb"].each   { |file| require_relative file }
Dir["#{BASE_PATH}/formatters/*.rb"].each { |file| require_relative file }

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
