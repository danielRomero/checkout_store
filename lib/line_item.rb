class LineItem
  attr_accessor :quantity
  attr_reader :product

  def initialize(product:, quantity: 1)
    @product = product
    @quantity = quantity
    validate
  end

  private

  def validate
    raise ArgumentError, 'Quantity must be an integer' unless quantity.kind_of?(Integer)
    raise ArgumentError, 'Quantity must be a positive number' if quantity < 0
  end
end
