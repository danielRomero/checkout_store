require_relative '../pricing_rule'
# If you buy 3 or more TSHIRT items, the price per unit should be 19.00
class DiscountBulkPurchases < PricingRule

  attr_reader :bulk_quantity, :new_price
  def initialize(code:, bulk_quantity:, new_price:)
    @bulk_quantity = bulk_quantity
    @new_price = new_price
    super code
    validate
  end

  def must_apply?(line_items)
    return false if line_items[code] && line_items[code].quantity < bulk_quantity
    super line_items
  end

  def apply(line_items)
    - (line_items[code].quantity * (line_items[code].product.price - new_price))
  end

  private

  def validate
    raise ArgumentError, 'bulk_quantity cant be empty' if bulk_quantity.nil?
    raise ArgumentError, 'bulk_quantity must be a number' unless bulk_quantity.kind_of?(Integer)

    raise ArgumentError, 'new_price cant be empty' if new_price.nil?
    raise ArgumentError, 'new_price must be a number' unless new_price.kind_of?(Float)
    super
  end
end
