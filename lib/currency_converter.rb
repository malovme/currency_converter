require "currency_converter/version"

module CurrencyConverter
  class Money
    @@base_currency = ''
    @@rates = {}

    attr_accessor :amount
    attr_accessor :currency

    def initialize(amount, currency)
      raise 'Amount argument required' if amount.nil?
      raise 'Currency argument required' if currency.nil?

      @amount = amount.to_f
      @currency = currency.to_s.upcase
    end

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

    def inspect
      "%.2f " % @amount + @currency
    end
  end
end
