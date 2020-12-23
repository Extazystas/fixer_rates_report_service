class ReportsGenerator
  attr_reader :report_formats, :rates_info

  def initialize(rates_info, formats = DevConfig.new.report_formats)
    @rates_info     = rates_info
    @report_formats = formats.uniq
  end

  def call
    report_formats.each do |format|
      Module.const_get("::Formatters::#{format.capitalize}Formatter").new(rates_info)
    end
  end
end
