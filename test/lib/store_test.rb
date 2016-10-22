require_relative '../test_helper'
require 'yaml'

describe Store do
  let(:product) { Product.new(code: 'VOUCHER', name: 'Cabify Voucher', price: 5.00) }

  before do
    Store.empty
  end

  it 'cant add nil to store' do
    Store.add_product nil
    Store.products.length.must_equal 0
  end

  it 'can add products to store' do
    Store.add_product product
    Store.products.length.must_equal 1
  end
  it 'cant add duplicate products to store' do
    Store.add_product product
    Store.add_product product
    Store.products.length.must_equal 1
  end

  it 'can remove produts from store' do
    Store.add_product product
    Store.products.length.must_equal 1
    Store.remove_product product
    Store.products.length.must_equal 0
  end

  it 'can find product by product_code' do
    Store.add_product product
    Store.find_product_by_code(product.code).must_equal product
  end

  it 'populate inventory with yaml file products' do
    source_file = 'test/resources/products_test.yml'
    total_products = YAML.load_file(source_file).length
    Store.setup_products(source_file)
    Store.products.length.must_equal total_products
  end
end
