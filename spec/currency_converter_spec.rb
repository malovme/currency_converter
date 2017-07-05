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
      expect CurrencyConverter::Money.base_currency.to eq 'EUR'
    end

    it "sets conversion rates while setting conversion rates" do
      epect CurrencyConverter::Money.rates['USD'].to eq 1.11
    end
  end

  it "should be valid with integer amount and string currency"
  it "should be valid with float amount and symbol currency"

  it "should be invalid without amount"
  it "should be invalid without currency"

  it "should return amount"
  it "should return currency"
  it "should return inspect"

  it "should convert one currency to another (return Money class object)"
  it "should convert one currency to another (check amount)"

  it "should add moneys with same currency"
  it "should substract moneys with same currency"
  it "should multiply moneys with same currency"
  it "should divide moneys with same currency"

  it "should add moneys with different currencies"
  it "should substract moneys with different currencies"
  it "should multiply moneys with different currencies"
  it "should divide moneys with different currencies"

  it "should compare equality of moneys with same currency"
  it "should compare equality of moneys with different currencies"
  it "should consider two monetary amounts as equal if they agree up to the cents"

  it "should test greater than for moneys with same currency"
  it "should test less than for moneys with same currency"

  it "should test greater than for moneys with different currencies"
  it "should test less than for moneys with different currencies"
end
