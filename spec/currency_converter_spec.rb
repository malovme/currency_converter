require "spec_helper"

RSpec.describe CurrencyConverter do
  it "has a version number" do
    expect(CurrencyConverter::VERSION).not_to be nil
  end
end

RSpec.describe CurrencyConverter::Money do
  context "setting base currency and conversion rates" do
    before do
      CurrencyConverter::Money.conversion_rates('EUR', {
          'USD'     => 1.11
      })
    end

    it "sets base currency while setting conversion rates" do
      expect(CurrencyConverter::Money.base_currency).to eq 'EUR'
    end

    it "sets conversion rates while setting conversion rates" do
      expect(CurrencyConverter::Money.rates['USD']).to eq 1.11
    end
  end

  context "valid initialization" do
    it "should be valid with integer amount and currency" do
      fifty_eur = CurrencyConverter::Money.new(50, 'EUR')
      expect(fifty_eur).to be_instance_of(CurrencyConverter::Money)
    end

    it "should be valid with float amount and currency" do
      fifty_eur = CurrencyConverter::Money.new(49.99, 'EUR')
      expect(fifty_eur).to be_instance_of(CurrencyConverter::Money)
    end
  end

  context "instance variables after valid initialization" do
    before do
      @fifty_eur = CurrencyConverter::Money.new(50, 'EUR')
    end

    it "should return amount" do
      expect(@fifty_eur.amount).to eq 50.00
    end

    it "should return currency" do
      expect(@fifty_eur.currency).to eq 'EUR'
    end

    it "should return inspect" do
      expect(@fifty_eur.inspect).to eq '50.00 EUR'
    end
  end

  context "invalid initialization" do
    it "should raise error without amount" do
      expect { CurrencyConverter::Money.new(nil, 'EUR') }.to raise_error('Amount argument required')
    end

    it "should be invalid without currency" do
      expect { CurrencyConverter::Money.new(50, nil) }.to raise_error('Currency argument required')
    end
  end

  context "currency conversion" do
    before do
      CurrencyConverter::Money.conversion_rates('EUR', {
          'USD'     => 1.11
      })
      @fifty_eur = CurrencyConverter::Money.new(50, 'EUR')
    end

    it "should convert one currency to another (return Money class object)" do
      fifty_eur_in_usd = @fifty_eur.convert_to('USD') # => 55.50 USD
      expect(fifty_eur_in_usd).to be_instance_of(CurrencyConverter::Money)
    end

    it "should convert one currency to another (check amount)" do
      fifty_eur_in_usd = @fifty_eur.convert_to('USD') # => 55.50 USD
      expect(fifty_eur_in_usd.amount).to eq 55.50
    end

    it "should convert one currency to another (check currency)" do
      fifty_eur_in_usd = @fifty_eur.convert_to('USD') # => 55.50 USD
      expect(fifty_eur_in_usd.currency).to eq 'USD'
    end
  end

  context "math operations with same currency" do
    it "should add moneys with same currency"
    it "should substract moneys with same currency"
    it "should multiply moneys with same currency"
    it "should divide moneys with same currency"
  end

  context "math operations with differnt currencies" do
    it "should add moneys with different currencies"
    it "should substract moneys with different currencies"
    it "should multiply moneys with different currencies"
    it "should divide moneys with different currencies"
  end

  context "comparison" do
    it "should compare equality of moneys with same currency"
    it "should compare equality of moneys with different currencies"
    it "should consider two monetary amounts as equal if they agree up to the cents"

    it "should test greater than for moneys with same currency"
    it "should test less than for moneys with same currency"

    it "should test greater than for moneys with different currencies"
    it "should test less than for moneys with different currencies"
  end
end
