## This is Exchange Rates Consumer Application for Freska test application. Part of Test assignment for fetching exchange currencies data from fixer.io.
<p>
<img src="https://devicons.github.io/devicon/devicon.git/icons/ruby/ruby-original-wordmark.svg" alt="ruby" width="40" height="40"/>
</p>

## Description
Create a reports on currency development.
Addplication configuration stored in DevConfig, AwsConfig etc in `/config` folder via `anyway_config` lib.

For a given it calculates the value and delta for:
 - today vs yesterday
 - today vs 7 days ago
 - today vs 1 month ago
 - today vs 1 year ago

You can add and remove any currency supported by Fixer to the report via app configuration.
The application supports the following output formats: HTML, XLS, ~CSV, JSON~.
The report is created in one or several of these formats, depending on the applications configuration.

- Units specs written with `Rspec`.
- Rates info is fetched from https://github.com/Extazystas/fixer_rates_proxy_api application.
- **Rubocop** is used for a good code style. Run example: `rubocop lib`

## Tech info:
* Ruby version 2.6.3

## Setup
Please run `bundle install` before starting the script.
You can start this app with `ruby execute.rb`:

## Run tests:
`RACK_ENV=test rspec spec/`

## Report example:
<img alt='1 step' title='1 step' src="https://raw.githubusercontent.com/Extazystas/fixer_rates_report_service/master/examples/html_report_example.png" width="500">

## TODO List
- Add Sidekiq worker for scheduling application reports generation
- Add Formatters for JSON and CSV reports
