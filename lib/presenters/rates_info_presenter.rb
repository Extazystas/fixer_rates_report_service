module Presenters
  class RatesInfoPresenter
    attr_reader :rates_info

    def initialize(rates_info)
      @rates_info = rates_info
    end

    def call
      base_rate_data       = sorted_rates.first
      base_currencies_hash = base_rate_data['rates']

      {
        currencies: base_currencies_hash.keys,
        base_date: base_rate_data['date'],
        base_currency: base_rate_data['base'],
        base_currencies_hash: base_currencies_hash,
        rates_to_compare: rates_to_compare
      }
    end

    private

    def rates_to_compare
      sorted_rates
        .drop(1)
        .map { |info| info['rates'].merge('date' => info['date']) }
    end

    def sorted_rates
      @sorted_rates ||= rates_info.sort_by { |rate| Date.parse(rate['date']) }.reverse
    end
  end
end
