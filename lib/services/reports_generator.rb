require 'ruby-progressbar'

class ReportsGenerator
  attr_reader :report_formats, :rates_info

  def initialize(rates_info, formats = DevConfig.new.report_formats)
    @rates_info     = rates_info
    @report_formats = formats.uniq
  end

  def call
    progress_bar.log("Starting report generation for #{report_formats.join(', ')} formats.")

    report_formats.each { |format| generate_report(format) }

    progress_bar.log('All reports successfully generated!')
  end

  private

  def generate_report(format)
    progress_bar.log("Generating #{format} report...")

    Module.const_get("::Formatters::#{format.capitalize}Formatter").new(rates_info)

    progress_bar.increment
  end

  def progress_bar
    @progress_bar ||= ProgressBar.create(
      format: "%a %b\u{15E7}%i %c/%C %p%% %e",
      progress_mark: ' ',
      remainder_mark: "\u{FF65}",
      starting_at: 0,
      total: report_formats.size
    )
  end
end
