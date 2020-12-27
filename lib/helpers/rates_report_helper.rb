module RatesReportHelper
  HEADER_TITLE =
    'This is currencies report based on Fixer currency rates. Freska test cunsumer app.'.freeze
  HEADER_SUBTITLE = 'Below is provided current value and delta for next dates:'.freeze

  def target_report_file(date, format)
    report_name = "#{format}_report_#{date}.#{format}"

    if ENV['RACK_ENV'] == 'test'
      File.join(File.dirname(__FILE__), '..', '..', 'spec', 'fixtures', 'reports', report_name)
    else
      File.join(File.dirname(__FILE__), '..', '..', 'reports', report_name)
    end
  end

  def calculate_delta_for(base_value, changed_value)
    (base_value - changed_value).round(5)
  end
end
