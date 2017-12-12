# MdsolCurrency

A Ruby Library for dealing with currency, location, and currency conversion. A currency tool used in the Medidata.

## Features

- Provides a `Mdsol::Currency` class with all gmp-viewable currencies.
- Provides a `Mdsol::Location` class with all gmp-viewable locations.
- Provides a `Mdsol::Conversion` class that returns exchange rate from one currency to the other currency.

## Install

Add this line to your application's Gemfile:

    gem 'mdsol_currency', git: 'git@github.com/mdsol/mdsol_currency.git'

## Usage

```ruby
# Currency
Mdsol::Currency.all     # Get gmp-viewable currency list
Mdsol::Currency.new(currency_uuid)
Mdsol::Currency.new(currency_uuid).name      #=> Euro
Mdsol::Currency.new(currency_uuid).code      #=> EUR
Mdsol::Currency.new(currency_uuid).symbol    #=> €
Mdsol::Currency.new(currency_uuid).exchange_rate(build_tag: 65) #=> 0.8942

# Location
Mdsol::Location.all     # Get gmp-viewable location list
Mdsol::Location.new(country_uuid)
Mdsol::Location.new(country_uuid).name       #=> United States
Mdsol::Location.new(country_uuid).code       #=> USA
Mdsol::Location.new(country_uuid).default_currency_uuid  #=> 67c47460-caff-11e7-abc4-cec278b6b50a

# Exchange Rate
convert_helper = Mdsol::Conversion.new(build_tag)
convert_helper.exchange_rate(location_uuid: UK-uuid, to_currency_uuid: USD-uuid)       #=> 1.2747
convert_helper.exchange_rate(from_currency_uuid: GBP-uuid, to_currency_uuid: USD-uuid) #=> 1.2747
```
