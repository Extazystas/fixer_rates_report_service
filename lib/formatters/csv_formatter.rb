require 'csv'

module Formatters
  class CsvFormatter
    def initialize(rates_info)
      @currencies           = rates_info[:currencies]
      @base_date            = rates_info[:base_date]
      @base_currency        = rates_info[:base_currency]
      @base_currencies_hash = rates_info[:base_currencies_hash]
      @rates_to_compare     = rates_info[:rates_to_compare]
    end

    def call
      build_report
    end

    private

    def build_report
      CSV.open(target_report_file(@base_date, 'csv'), 'w') do |csv|
        csv << headers
        csv << base_currency_info
        comparable_currency_info.each { |info| csv << info }
      end
    end

    def headers
      [ 'Dates', @currencies ].flatten
    end

    def base_currency_info
      [ @base_date, @base_currencies_hash.values ].flatten
    end

    def comparable_currency_info
      @rates_to_compare.map do |rate_info|
        [
          rate_info['date'],
          @currencies.map { |c| calculate_delta_for(rate_info[c], @base_currencies_hash[c]) }
        ].flatten
      end
    end
  end
end
