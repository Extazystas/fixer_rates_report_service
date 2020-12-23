require 'spec_helper'

RSpec.describe ReportsGenerator do
  let(:service) { described_class.new(rates_info, formats) }
  let(:rates_info) do
    [
      { 'base' => 'EUR',
        'date' => '2020-12-20',
        'symbols' => %w[GBP USD],
        'rates' => { 'GBP' => 0.911521, 'USD' => 1.221575 } },
      { 'base' => 'EUR',
        'date' => '2020-12-21',
        'symbols' => %w[GBP USD],
        'rates' => { 'GBP' => 0.909765, 'USD' => 1.223543 } },
      { 'base' => 'EUR',
        'date' => '2020-12-22',
        'symbols' => %w[GBP USD],
        'rates' => { 'GBP' => 0.913841, 'USD' => 1.221769 } }
    ]
  end

  context 'when all formatters enabled' do
    let(:formats) { DevConfig.new(report_formats: %w[html csv xls json]).report_formats }

    it do
      expect(::Formatters::HtmlFormatter).to receive(:new).with(rates_info).and_call_original
      expect(::Formatters::CsvFormatter).to receive(:new).with(rates_info).and_call_original
      expect(::Formatters::XlsFormatter).to receive(:new).with(rates_info).and_call_original
      expect(::Formatters::JsonFormatter).to receive(:new).with(rates_info).and_call_original

      service.call
    end
  end

  context 'when html and csv formatters enabled' do
    let(:formats) { DevConfig.new(report_formats: %w[html csv]).report_formats }

    it do
      expect(::Formatters::HtmlFormatter).to receive(:new).with(rates_info).and_call_original
      expect(::Formatters::CsvFormatter).to receive(:new).with(rates_info).and_call_original
      expect(::Formatters::XlsFormatter).not_to receive(:new).with(rates_info)
      expect(::Formatters::JsonFormatter).not_to receive(:new).with(rates_info)

      service.call
    end
  end
end
