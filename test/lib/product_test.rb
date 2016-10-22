require_relative '../test_helper'

describe Product do
  let (:product) { Product.new(code: 'MUG', name: 'Cafify Coffee Mug', price: 7.50) }
  it { product.code.must_equal 'MUG' }
  it { product.name.must_equal 'Cafify Coffee Mug' }
  it { product.price.must_equal 7.5 }

  it 'code cant change' do
    proc { product.code = 'other_code' }.must_raise NoMethodError
  end

  it 'validate wrong attributes on update' do
    proc { product.name = nil }.must_raise ArgumentError
    proc { product.price = nil }.must_raise ArgumentError
    proc { product.price = -1.0 }.must_raise ArgumentError
    proc { product.price = 'not_a_number' }.must_raise ArgumentError
  end
end
