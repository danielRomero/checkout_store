require_relative '../test_helper'

describe PricingRule do
  let (:pricing_rule) { PricingRule.new('VOUCHER') }
  let(:product) { Product.new(code: 'VOUCHER', name: 'Cabify Voucher', price: 5.00) }
  let (:line_items) { { 'VOUCHER' => LineItem.new(product: product) } }

  it { pricing_rule.code.must_equal 'VOUCHER' }

  describe 'check if must apply' do
    it 'apply if at one line_item have the same code' do
      pricing_rule.must_apply?(line_items).must_equal true
    end

    it 'not apply if line_items are empty' do
      pricing_rule.must_apply?({}).must_equal false
    end

    it 'cant apply if none of line items contain the same code' do
      product = Product.new(code: 'MUG', name: 'Cabify Mug', price: 5.00)
      line_item = LineItem.new(product: product)
      line_items = {}
      line_items[product.code] = line_item
      pricing_rule.must_apply?(line_items).must_equal false
    end

  end

  it 'apply rules' do
    pricing_rule.apply(line_items).must_equal 0.0
    pricing_rule.apply({}).must_equal 0.0
  end

end
