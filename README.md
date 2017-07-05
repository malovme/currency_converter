# CurrencyConverter

It easy to convert money items between currencies. Just use this gem.
## Installation

Add this line to your application's Gemfile:

```ruby
gem 'currency_converter', :git => 'git@github.com:malovme/currency_converter.git'
```

And then execute:

    $ bundle

## Usage

#### Configure the currency rates with respect to a base:

```ruby
CurrencyConverter::Money.conversion_rates('EUR', {
    'USD'     => 1.11,
    'Bitcoin' => 0.0047,
    'GBP' => 0.8789
})
```

#### Instantiate money objects:

```ruby
fifty_eur = CurrencyConverter::Money.new(50, 'EUR')
```

#### Get amount and currency:

```ruby
fifty_eur.amount   # => 50

fifty_eur.currency # => "EUR"

fifty_eur.inspect  # => "50.00 EUR"
```

#### Convert to a different currency

```ruby
fifty_eur.convert_to('USD') # => 55.50 USD
```

#### Perform operations in different currencies:

```ruby
fifty_eur + twenty_dollars # => 68.02 EUR

fifty_eur - twenty_dollars # => 31.98 EUR

fifty_eur / 2              # => 25 EUR

twenty_dollars * 3         # => 60 USD
```

#### Comparisons (also in different currencies):

```ruby
twenty_dollars == CurrencyConverter::Money.new(20, 'USD') # => true

twenty_dollars == CurrencyConverter::Money.new(30, 'USD') # => false
```

```ruby
fifty_eur_in_usd = fifty_eur.convert_to('USD')

fifty_eur_in_usd == fifty_eur          # => true
```
 
```ruby
twenty_dollars > CurrencyConverter::Money.new(5, 'USD')   # => true

twenty_dollars < fifty_eur             # => true
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/malovme/currency_converter.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
