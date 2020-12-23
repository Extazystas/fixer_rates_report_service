require 'erb'

module Formatters
  class HtmlFormatter
    def initialize(rates_info)
      current_rate_info = rates_info.first
      @current_date     = current_rate_info['date']
      @base_currency    = current_rate_info['base']
      @current_rates    = current_rate_info['rates']
      @currencies       = @current_rates.keys
      @comparable_rates = rates_info.drop(1)
    end

    def call
      File.open(target_report_file, 'w') do |f|
        f.write ERB.new(File.read(template_file)).result(binding)
      end
    end

    private

    def template_file
      File.join(File.dirname(__FILE__), '..', 'templates', 'html_report.html.erb')
    end

    def target_report_file
      report_name = "html_report_#{@current_date}.html"

      if ENV['RACK_ENV'] == 'test'
        File.join(File.dirname(__FILE__), "..", "..", 'spec', 'fixtures', 'reports', report_name)
      else
        File.join(File.dirname(__FILE__), "..", "..", 'reports', report_name)
      end
    end
  end
end
