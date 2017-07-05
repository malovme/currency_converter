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
          'USD'     => 1.11,
          'GBP'     => 1.29
      })
      @fifty_eur = CurrencyConverter::Money.new(50, 'EUR')
      @fifty_usd = CurrencyConverter::Money.new(50, 'USD')
    end

    it "should convert one currency to another (return Money class object)" do
      fifty_eur_in_usd = @fifty_eur.convert_to('USD')
      expect(fifty_eur_in_usd).to be_instance_of(CurrencyConverter::Money)
    end

    it "should convert while convert base currency to another" do
      fifty_eur_in_usd = @fifty_eur.convert_to('USD')
      expect(fifty_eur_in_usd.inspect).to eq '55.50 USD'
    end

    it "should convert while convert another currency to base" do
      fifty_usd_in_eur = @fifty_usd.convert_to('EUR')
      expect(fifty_usd_in_eur.inspect).to eq '45.05 EUR'
    end

    it "should convert while convert not base currency to another not base" do
      fifty_usd_in_gbp = @fifty_usd.convert_to('GBP')
      expect(fifty_usd_in_gbp.inspect).to eq '43.02 GBP'
    end

    it "should convert while convert currency to same currency" do
      fifty_eur_in_eur = @fifty_eur.convert_to('EUR') # => 50.00 EUR
      expect(fifty_eur_in_eur.inspect).to eq '50.00 EUR'
    end
  end

  context "math operations" do
    before do
      CurrencyConverter::Money.conversion_rates('EUR', {
          'USD'     => 1.11,
      })
      @fifty_eur = CurrencyConverter::Money.new(50, 'EUR')
      @fifty_usd = CurrencyConverter::Money.new(50, 'USD')
    end

    it "should multiply moneys" do
      expect((@fifty_eur * 2).inspect).to eq '100.00 EUR'
    end

    it "should divide moneys" do
      expect((@fifty_eur / 2).inspect).to eq '25.00 EUR'
    end

    it "should add moneys with same currency" do
      expect((@fifty_eur + @fifty_eur).inspect).to eq '100.00 EUR'
    end

    it "should substract moneys with same currency" do
      expect((@fifty_eur - @fifty_eur).inspect).to eq '0.00 EUR'
    end

    it "should add moneys with different currencies" do
      expect((@fifty_eur + @fifty_usd).inspect).to eq '95.05 EUR'
    end

    it "should substract moneys with different currencies" do
      expect((@fifty_eur - @fifty_usd).inspect).to eq '4.95 EUR'
    end
  end

  context "comparison" do
    before do
      CurrencyConverter::Money.conversion_rates('EUR', {
          'USD'     => 1.11,
      })
      @fifty_eur = CurrencyConverter::Money.new(50, 'EUR')
      @fifty_usd = CurrencyConverter::Money.new(50, 'USD')
    end

    it "should compare equality of moneys with same currency"
    it "should compare equality of moneys with different currencies"
    it "should consider two monetary amounts as equal if they agree up to the cents"

    it "should test greater than for moneys with same currency"
    it "should test less than for moneys with same currency"

    it "should test greater than for moneys with different currencies"
    it "should test less than for moneys with different currencies"
  end
end
