require_relative '../test_helper'

describe LineItem do
  let(:product) { Product.new(code: 'VOUCHER', name: 'Cabify Voucher', price: 5.00) }

  describe 'attribute product checks' do
    it 'product is mandatory' do
      proc { LineItem.new }.must_raise Exception
    end

    it 'have a product' do
      LineItem.new(product: product).product.must_equal product
    end

    it 'product cant change' do
      line_item = LineItem.new(product: product)
      other_product = Product.new(code: 'MUG', name: 'Cafify Coffee Mug', price: 7.50)
      proc { line_item.product = other_product }.must_raise NoMethodError
    end
  end

  describe 'attribute quantity checks' do
    it 'have quantity' do
      LineItem.new(product: product, quantity: 3).quantity.must_equal 3
    end

    it 'quantity is optional' do
      LineItem.new(product: product).quantity.must_equal 1
    end

    it 'quantity cant be negative' do
      proc { LineItem.new(product: product, quantity: -1) }.must_raise Exception
    end

    it 'quantity can change' do
      line_item = LineItem.new(product: product)
      line_item.quantity.must_equal 1
      line_item.quantity = 8
      line_item.quantity.must_equal 8
    end
  end
end
