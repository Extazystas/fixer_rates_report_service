require 'spec_helper'
require 'write_xlsx'

RSpec.describe Formatters::XlsFormatter do
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

  it do
    expect(::WriteXLSX).to receive(:new)
      .and_return(double(add_worksheet: double(write: true), close: true))
    service.call
  end
end
