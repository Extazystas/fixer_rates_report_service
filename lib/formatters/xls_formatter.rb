require 'write_xlsx'

module Formatters
  class XlsFormatter
    attr_reader :workbook, :worksheet

    def initialize(rates_info)
      @currencies           = rates_info[:currencies]
      @base_date            = rates_info[:base_date]
      @base_currency        = rates_info[:base_currency]
      @base_currencies_hash = rates_info[:base_currencies_hash]
      @rates_to_compare     = rates_info[:rates_to_compare]

      @workbook  = WriteXLSX.new(target_report_file(@base_date, 'xlsx'))
      @worksheet = workbook.add_worksheet
    end

    def call
      build_report
    end

    private

    def build_report
      add_table_description
      add_table_header
      add_base_currency_info
      add_comparable_dates_deltas

      workbook.close
    end

    def add_table_description
      worksheet.write(0, 0, HEADER_TITLE)
      worksheet.write(1, 0, HEADER_SUBTITLE)
    end

    def add_table_header
      worksheet.write(2, 0, 'Dates')
      @currencies.each_with_index { |currency, i| worksheet.write(2, i + 1, currency) }
    end

    def add_base_currency_info
      worksheet.write(3, 0, @base_date)
      @base_currencies_hash.each_with_index { |(_, value), i| worksheet.write(3, i + 1, value) }
    end

    def add_comparable_dates_deltas
      @rates_to_compare.each_with_index do |rate_info, i|
        worksheet.write(4 + i, 0, rate_info['date'])
        @currencies.each_with_index do |currency, j|
          worksheet.write(
            4 + i,
            j + 1,
            calculate_delta_for(rate_info[currency], @base_currencies_hash[currency])
          )
        end
      end
    end
  end
end
