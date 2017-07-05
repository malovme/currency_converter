require "currency_converter/version"

module CurrencyConverter
  class Money
    @@rnd = 2
    @@base_currency = ''
    @@rates = {}

    attr_accessor :amount
    attr_accessor :currency

    def initialize(amount, currency)
      raise 'Amount argument required' if amount.nil?
      raise 'Currency argument required' if currency.nil?

      @amount = amount.to_f
      @currency = currency.to_s
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
        converted_amount = (self.amount * rate).round(@@rnd)
        self.class.new(converted_amount, currency)
      end
    end

    def == money
      check_type(money)
      self.amount == money.convert_to(self.currency).amount
    end

    def > money
      check_type(money)
      self.amount > money.convert_to(self.currency).amount
    end

    def < money
      check_type(money)
      self.amount < money.convert_to(self.currency).amount
    end

    def + money
      check_type(money)
      self.amount = (self.amount + money.convert_to(self.currency).amount).round(@@rnd)
      self
    end

    def - money
      check_type(money)
      self.amount = (self.amount - money.convert_to(self.currency).amount).round(@@rnd)
      self
    end

    def * multiplier
      self.amount = (self.amount * multiplier).round(@@rnd)
      self
    end

    def / divider
      self.amount = (self.amount / divider).round(@@rnd)
      self
    end

    private

    def calculate_rate input_currency, output_currency
      if input_currency == @@base_currency
        @@rates[output_currency]
      elsif output_currency == @@base_currency
        1/@@rates[input_currency]
      else
        @@rates[output_currency]/@@rates[input_currency]
      end
    end

    def check_type money
      raise 'Money instance expected' unless money.is_a?(CurrencyConverter::Money)
    end

  end
end
