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
      @checkout = Checkout.new(pricing_rules)
    end

    it 'cant find product on store' do
      @checkout.scan('NOTFOUND').must_equal nil
    end

    it 'find product on store' do
      @checkout.scan('VOUCHER').must_be_instance_of LineItem
    end

    it 'Items: VOUCHER, TSHIRT, MUG. Total: 32.50' do
      @checkout.scan('VOUCHER')
      @checkout.scan('TSHIRT')
      @checkout.scan('MUG')
      price = @checkout.total
      assert_equal '32.50€', price
    end

    it 'Items: VOUCHER, TSHIRT, VOUCHER. Total: 25.00' do
      @checkout.scan('VOUCHER')
      @checkout.scan('TSHIRT')
      @checkout.scan('VOUCHER')
      price = @checkout.total
      assert_equal '25.00€', price
    end

    it 'Items: TSHIRT, TSHIRT, TSHIRT, VOUCHER, TSHIRT. Total: 81.00' do
      @checkout.scan('TSHIRT')
      @checkout.scan('TSHIRT')
      @checkout.scan('TSHIRT')
      @checkout.scan('VOUCHER')
      @checkout.scan('TSHIRT')
      price = @checkout.total
      assert_equal '81.00€', price
    end

    it 'Items: VOUCHER, TSHIRT, VOUCHER, VOUCHER, MUG, TSHIRT, TSHIRT. Total: 74.50' do
      @checkout.scan('VOUCHER')
      @checkout.scan('TSHIRT')
      @checkout.scan('VOUCHER')
      @checkout.scan('VOUCHER')
      @checkout.scan('MUG')
      @checkout.scan('TSHIRT')
      @checkout.scan('TSHIRT')
      price = @checkout.total
      assert_equal '74.50€', price
    end
  end
end
