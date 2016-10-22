# CheckoutStore
[![Build Status](https://travis-ci.org/danielRomero/checkout_store.svg?branch=master)](https://travis-ci.org/danielRomero/checkout_store)
[![Code Climate](https://codeclimate.com/github/danielRomero/checkout_store/badges/gpa.svg)](https://codeclimate.com/github/danielRomero/checkout_store)
[![Test Coverage](https://codeclimate.com/github/danielRomero/checkout_store/badges/coverage.svg)](https://codeclimate.com/github/danielRomero/checkout_store/coverage)

Exercise for a checkout process

To experiment with that code, run `rake console` for an interactive prompt.

## Instalation

Clone the repo and then execute

    $ bundle

## Test

Run tests with

``` ruby
rake test
```

## Usage

- More products can be added on `products.yml` at resources folder.

- Pricing rules can be added under `pricing_rules` folder

- Actual pricing rules are versatile:

  - instead of discounts 3 x 2 you can initialize the class with 4 x 2 or other.

  - also bulk purchases can modify the rules with params on class initializer, for example, you can get 8 or more 'MUG' products by 4.00€
  `DiscountBulkPurchases.new(code: 'MUG', bulk_quantity: 8, new_price: 4.0)`
