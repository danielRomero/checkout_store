require_relative '../../test_helper'

describe BuyXPayY do
  let (:buy_two_pay_one) { BuyXPayY.new(code: 'VOUCHER', buy_units: 2, pay_units: 1) }
  let(:product) { Product.new(code: 'VOUCHER', name: 'Cabify Voucher', price: 5.00) }
  let (:line_items) { { 'VOUCHER' => LineItem.new(product: product) } }

  it { buy_two_pay_one.must_be_instance_of BuyXPayY }
  it { buy_two_pay_one.kind_of?(PricingRule).must_equal true }
  it { buy_two_pay_one.code.must_equal 'VOUCHER' }
  it { buy_two_pay_one.buy_units.must_equal 2 }
  it { buy_two_pay_one.pay_units.must_equal 1 }

  it 'attrs cant change' do
    proc { buy_two_pay_one.code = 'other_code' }.must_raise NoMethodError
    proc { buy_two_pay_one.buy_units = 33 }.must_raise NoMethodError
    proc { buy_two_pay_one.pay_units = 22 }.must_raise NoMethodError
  end

  it 'validate wrong attributes' do
    proc { BuyXPayY.new(code: nil, buy_units: 2, pay_units: 1) }.must_raise ArgumentError
    proc { BuyXPayY.new(code: 2, buy_units: 2, pay_units: 1) }.must_raise ArgumentError

    proc { BuyXPayY.new(code: 'VOUCHER', buy_units: nil, pay_units: 1) }.must_raise ArgumentError
    proc { BuyXPayY.new(code: 'VOUCHER', buy_units: '2', pay_units: 1) }.must_raise ArgumentError

    proc { BuyXPayY.new(code: 'VOUCHER', buy_units: 2, pay_units: nil) }.must_raise ArgumentError
    proc { BuyXPayY.new(code: 'VOUCHER', buy_units: 2, pay_units: '1') }.must_raise ArgumentError
  end

  it 'must apply discount rules' do
    line_items[product.code].quantity = 2
    buy_two_pay_one.must_apply?(line_items).must_equal true
    total = - product.price
    buy_two_pay_one.apply(line_items).must_equal total
  end

  it 'not apply discount rules' do
    line_items[product.code].quantity = 1
    buy_two_pay_one.apply(line_items).must_equal 0.0
  end
end
