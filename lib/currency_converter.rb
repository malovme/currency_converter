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

    def convert_to currency
      if self.currency == currency
        self
      else
        rate = calculate_rate( self.currency, currency)
        converted_amount = (self.amount * rate).round(2)
        self.class.new(converted_amount, currency)
      end
    end

    private

    def calculate_rate input_currency, output_currency
      if input_currency == @@base_currency
        @@rates[output_currency]
      elsif output_currency == @@base_currency
        1/@@rates[input_currency]
      else
        @@rates[input_currency]/@@rates[output_currency]
      end
    end

  end
end
