require 'yaml'
# Management of products inventoried on Store
class Store
  @products = {}

  # return all products in inventory
  def self.products
    @products.values
  end

  # Add new product to inventory
  def self.add_product(product)
    @products[product.code] = product if product.is_a?(Product)
    @products
  end

  # remove existing product in inventory
  def self.remove_product(product)
    @products.delete(product.code) if product.is_a?(Product)
    @products
  end

  def self.find_product_by_code(product_code)
    @products[product_code]
  end

  # return the Store to initial state of empty inventory
  def self.empty
    @products = {}
  end

  def self.setup_products(source = 'resources/products.yml')
    YAML.load_file(source).each do |product|
      add_product Product.new(
        code:     product['code'],
        name:     product['name'],
        price:    product['price']
      )
    end
  end
end
