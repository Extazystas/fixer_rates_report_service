## This is Exchange Rates Consumer Application for Freska test application. Part of Test assignment for fetching exchange currencies data from fixer.io.
<p>
<img src="https://devicons.github.io/devicon/devicon.git/icons/ruby/ruby-original-wordmark.svg" alt="ruby" width="40" height="40"/>
</p>

## Description
Create a reports on currency development.
For a given it describe the value and delta for:
 - today vs yesterday
 - today vs 7 days ago
 - today vs 1 month ago
 - today vs 1 year ago

You can add and remove any currency supported by Fixer to the report via app configuration.
The application supports the following output formats: CSV, XLS, HTML, JSON.
The report is created in one or several of these formats, depending on the applications configuration.

- Units specs written with `Rspec`.
- Rates info is fetched from https://github.com/Extazystas/fixer_rates_proxy_api application.
- **Rubocop** is used for a good code style. Run example: `rubocop lib`

## Tech info:
* Ruby version 2.6

## Setup
You can start this app with `ruby execute.rb`:

## Run tests:
`rspec spec/`

## TODO List
- Add Sidekiq worker for scheduling application reports generation
