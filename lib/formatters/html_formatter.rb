require 'erb'

module Formatters
  class HtmlFormatter
    def initialize(rates_info)
      @currencies           = rates_info[:currencies]
      @base_date            = rates_info[:base_date]
      @base_currency        = rates_info[:base_currency]
      @base_currencies_hash = rates_info[:base_currencies_hash]
      @rates_to_compare     = rates_info[:rates_to_compare]
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
      report_name = "html_report_#{@base_date}.html"

      if ENV['RACK_ENV'] == 'test'
        File.join(File.dirname(__FILE__), '..', '..', 'spec', 'fixtures', 'reports', report_name)
      else
        File.join(File.dirname(__FILE__), '..', '..', 'reports', report_name)
      end
    end
  end
end
