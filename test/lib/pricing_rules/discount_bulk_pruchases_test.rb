require_relative '../../test_helper'

describe DiscountBulkPurchases do
  let (:bulk_discount) { DiscountBulkPurchases.new(code: 'VOUCHER', bulk_quantity: 3, new_price: 19.0) }
  let(:product) { Product.new(code: 'VOUCHER', name: 'Cabify Tshirt', price: 20.00) }
  let (:line_items) { { 'VOUCHER' => LineItem.new(product: product) } }

  it { bulk_discount.must_be_instance_of DiscountBulkPurchases }
  it { bulk_discount.kind_of?(PricingRule).must_equal true }
  it { bulk_discount.code.must_equal 'VOUCHER' }
  it { bulk_discount.bulk_quantity.must_equal 3 }
  it { bulk_discount.new_price.must_equal 19.0 }

  it 'attrs cant change' do
    proc { bulk_discount.code = 'other_code' }.must_raise NoMethodError
    proc { bulk_discount.bulk_quantity = 45 }.must_raise NoMethodError
    proc { bulk_discount.new_price = 55 }.must_raise NoMethodError
  end

  it 'validate wrong attributes' do
    proc { DiscountBulkPurchases.new(code: nil, bulk_quantity: 2, new_price: 1) }.must_raise ArgumentError
    proc { DiscountBulkPurchases.new(code: 2, bulk_quantity: 2, new_price: 1) }.must_raise ArgumentError

    proc { DiscountBulkPurchases.new(code: 'VOUCHER', bulk_quantity: nil, new_price: 1) }.must_raise ArgumentError
    proc { DiscountBulkPurchases.new(code: 'VOUCHER', bulk_quantity: '2', new_price: 1) }.must_raise ArgumentError

    proc { DiscountBulkPurchases.new(code: 'VOUCHER', bulk_quantity: 2, new_price: nil) }.must_raise ArgumentError
    proc { DiscountBulkPurchases.new(code: 'VOUCHER', bulk_quantity: 2, new_price: '1') }.must_raise ArgumentError
  end

  it 'must apply discount rules' do
    line_items[product.code].quantity = 3
    bulk_discount.must_apply?(line_items).must_equal true
    total = line_items[product.code].quantity * (bulk_discount.new_price - product.price)
    bulk_discount.apply(line_items).must_equal total
  end

  it 'not apply discount rules' do
    line_items[product.code].quantity = 1
    bulk_discount.must_apply?(line_items).must_equal false
  end
end
