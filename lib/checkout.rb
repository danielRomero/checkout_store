require_relative 'line_item'

class Checkout
  attr_reader :pricing_rules
  attr_accessor :line_items
  def initialize(pricing_rules)
    @line_items = {}
    @pricing_rules = pricing_rules
  end

  def scan(product_code)
    product = Store.find_product_by_code product_code
    if product
      if line_items[product.code].nil?
        line_items[product.code] = LineItem.new(product: product)
      else
        line_items[product.code].quantity += 1
      end
    else
      puts 'product not found'
    end
  end

  def total
    total_before_discounts = 0
    line_items.values.each do |line_item|
      total_before_discounts += line_item.product.price * line_item.quantity
    end

    total_after_discounts = total_before_discounts

    pricing_rules.each do |pricing_rule|
      total_after_discounts +=
        pricing_rule.apply line_items if pricing_rule.must_apply?(line_items)
    end
    format('%.2f€', total_after_discounts)
  end
end
