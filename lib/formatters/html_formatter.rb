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
      File.open(target_report_file(@base_date, 'html'), 'w') do |f|
        f.write ERB.new(File.read(template_file)).result(binding)
      end
    end

    private

    def template_file
      File.join(File.dirname(__FILE__), '..', 'templates', 'html_report.html.erb')
    end
  end
end
