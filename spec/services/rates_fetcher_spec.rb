require 'spec_helper'

RSpec.describe RatesFetcher do
  let(:service)        { described_class.call }
  let(:today)          { '2020-12-23' }
  let(:yesterday)      { '2020-12-22' }
  let(:week_ago)       { '2020-12-16' }
  let(:year_ago)       { '2019-12-23' }
  let(:dates_to_fetch) { [today, yesterday, week_ago, year_ago] }

  let(:today_response_stub) do
    { 'base' => 'EUR', 'date' => '2020-12-23', 'symbols' => ['USD'], 'rates' => { 'USD' => 1.218658 } }
  end
  let(:yersterday_response_stub) do
    { 'base' => 'EUR', 'date' => '2020-12-22', 'symbols' => ['USD'], 'rates' => { 'USD' => 1.221307 } }
  end
  let(:week_ago_response_stub) do
    { 'base' => 'EUR', 'date' => '2020-12-16', 'symbols' => ['USD'], 'rates' => { 'USD' => 1.219818 } }
  end
  let(:year_ago_response_stub) do
    { 'base' => 'EUR', 'date' => '2019-12-23', 'symbols' => ['USD'], 'rates' => { 'USD' => 1.109145 } }
  end
  let(:bad_response_stub) do
    { 'message' => 'Invalid date. Date format: 2019-12-31 ' }
  end

  context 'good response' do
    before do
      allow(Faraday).to receive(:get).and_call_original
      allow(Faraday).to receive(:get)
        .with(/#{today}/).and_return(double(body: today_response_stub.to_json))
      allow(Faraday).to receive(:get)
        .with(/#{yesterday}/).and_return(double(body: yersterday_response_stub.to_json))
      allow(Faraday).to receive(:get)
        .with(/#{week_ago}/).and_return(double(body: week_ago_response_stub.to_json))
      allow(Faraday).to receive(:get)
        .with(/#{year_ago}/).and_return(double(body: year_ago_response_stub.to_json))

      allow(described_class).to receive(:dates_to_fetch).and_return(dates_to_fetch)
    end

    it do
      expect(service).to match_array(
        [
          { 'base' => 'EUR', 'date' => today, 'symbols' => ['USD'], 'rates' => { 'USD' => 1.218658 } },
          { 'base' => 'EUR', 'date' => yesterday, 'symbols' => ['USD'], 'rates' => { 'USD' => 1.221307 } },
          { 'base' => 'EUR', 'date' => week_ago, 'symbols' => ['USD'], 'rates' => { 'USD' => 1.219818 } },
          { 'base' => 'EUR', 'date' => '2019-12-23', 'symbols' => ['USD'], 'rates' => { 'USD' => 1.109145 } }
        ]
      )
    end
  end

  context 'bad response' do
    let(:dates_to_fetch) { ['2099-12-12'] }

    before do
      allow(Faraday).to receive(:get).and_return(double(body: bad_response_stub.to_json))
      allow(described_class).to receive(:dates_to_fetch).and_return(dates_to_fetch)
    end

    it { expect(service).to match_array([{ 'message' => 'Invalid date. Date format: 2019-12-31 ' }]) }
  end
end
