require 'spec_helper'

RSpec.describe RatesReportHelper do
  let(:class_with_helper) { Class.new { include RatesReportHelper } }

  it '#target_report_file' do
    expect(class_with_helper.new.target_report_file('2020-12-12', 'html'))
      .to match(%r{reports/html_report_2020-12-12.html})
  end

  it '#calculate_delta_for' do
    expect(class_with_helper.new.calculate_delta_for(2.125, 2.23)).to eq(-0.105)
  end
end
