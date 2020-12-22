begin
  require 'pry'
  require 'csv'
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
