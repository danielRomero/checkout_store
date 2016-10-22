require_relative '../test_helper'

describe Checkout do
  describe 'exercise_use_case_examples' do
    let(:pricing_rules) {
      [
        BuyXPayY.new(
          code: 'VOUCHER',
          buy_units: 2,
          pay_units: 1),
        DiscountBulkPurchases.new(
          code: 'TSHIRT',
          bulk_quantity: 3,
          new_price: 19.0)
      ]
    }

    before do
      Store.empty
      Store.setup_products 'test/resources/products_test.yml'
    end

    it 'Items: VOUCHER, TSHIRT, MUG. Total: 32.50' do
      co = Checkout.new(pricing_rules)
      co.scan('VOUCHER')
      co.scan('TSHIRT')
      co.scan('MUG')
      price = co.total
      assert_equal '32.50€', price
    end

    it 'Items: VOUCHER, TSHIRT, VOUCHER. Total: 25.00' do
      co = Checkout.new(pricing_rules)
      co.scan('VOUCHER')
      co.scan('TSHIRT')
      co.scan('VOUCHER')
      price = co.total
      assert_equal '25.00€', price
    end

    it 'Items: TSHIRT, TSHIRT, TSHIRT, VOUCHER, TSHIRT. Total: 81.00' do
      co = Checkout.new(pricing_rules)
      co.scan('TSHIRT')
      co.scan('TSHIRT')
      co.scan('TSHIRT')
      co.scan('VOUCHER')
      co.scan('TSHIRT')
      price = co.total
      assert_equal '81.00€', price
    end

    it 'Items: VOUCHER, TSHIRT, VOUCHER, VOUCHER, MUG, TSHIRT, TSHIRT. Total: 74.50' do
      co = Checkout.new(pricing_rules)
      co.scan('VOUCHER')
      co.scan('TSHIRT')
      co.scan('VOUCHER')
      co.scan('VOUCHER')
      co.scan('MUG')
      co.scan('TSHIRT')
      co.scan('TSHIRT')
      price = co.total
      assert_equal '74.50€', price
    end
  end
end
