require 'active_support/core_ext/integer/time'
require 'faraday'
require 'json'

class RatesFetcher
  class << self
    def call
      dates_to_fetch.each_with_object([]) do |date, memo|
        response = Faraday.get("#{base_url}/#{date}", query_params, headers)

        memo << JSON.parse(response.body)
      end
    end

    private

    def query_params
      {
        base: base_currency,
        symbols: target_currencies
      }
    end

    def headers
      { 'Accept' => 'application/json' }
    end

    def dates_to_fetch
      [
        Date.today,
        Date.today - 1.day,
        Date.today - 1.week,
        Date.today - 1.month,
        Date.today - 1.year
      ].map(&:to_s)
    end

    def base_url
      config.proxy_api_url
    end

    def base_currency
      config.base_currency
    end

    def target_currencies
      config.target_currencies
    end

    def config
      ::DevConfig.new
    end
  end
end
