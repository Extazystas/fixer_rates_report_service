begin
  require 'pry'
  require 'csv'
  require 'rspec'
rescue LoadError => e
  puts "#{e}. Installing..."
  # Installing missed gems
  system('gem install pry')
  system('gem install rspec')
  puts 'Installation was completed successfully. Please re-run the program'
  exit
end
