require "currency_converter/version"

module CurrencyConverter
  class Money
    @@base_currency = ''
    @@rates = {}

    def self.conversion_rates(base_currency, rates)
      @@base_currency = base_currency
      @@rates = rates
    end

    def self.base_currency
      @@base_currency
    end

    def self.rates
      @@rates
    end
  end
end
