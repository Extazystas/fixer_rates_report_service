require 'spec_helper'

RSpec.describe Presenters::RatesInfoPresenter do
  let(:service) { described_class.new(rates_info) }
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
  let(:expected_rates_info) do
    {
      base_currencies_hash: { 'GBP' => 0.911521, 'USD' => 1.221575 },
      base_currency: 'EUR',
      base_date: '2020-12-20',
      currencies: %w[GBP USD],
      rates_to_compare: [
        { 'GBP' => 0.909765, 'USD' => 1.223543, 'date' => '2020-12-21' },
        { 'GBP' => 0.913841, 'USD' => 1.221769, 'date' => '2020-12-22' }
      ]
    }
  end

  it { expect(service.call).to eq expected_rates_info }
end
