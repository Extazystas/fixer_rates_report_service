require 'spec_helper'

RSpec.describe Formatters::CsvFormatter do
  let(:service) { described_class.new(rates_info) }
  let(:rates_info) do
    {
      base_currencies_hash: { 'GBP' => 0.913841, 'USD' => 1.221769 },
      base_currency: 'EUR',
      base_date: '2020-12-22',
      currencies: %w[GBP USD],
      rates_to_compare: [
        { 'GBP' => 0.909765, 'USD' => 1.223543, 'date' => '2020-12-21' },
        { 'GBP' => 0.911521, 'USD' => 1.221575, 'date' => '2020-12-15' }
      ]
    }
  end

  let(:result) do
    [['2020-12-21', -0.00408, 0.00177], ['2020-12-15', -0.00232, -0.00019]]
  end

  it { expect(service.call).to eq result }
end
