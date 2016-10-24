require_relative 'line_item'
require_relative 'price_formatter'

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
    total_before_discounts = line_items.values.inject(0){ |total, li| total + li.quantity * li.product.price }

    total_after_discounts = pricing_rules.inject(total_before_discounts){ |total, pricing_rule|
      total +( pricing_rule.must_apply?(line_items) ? pricing_rule.apply(line_items) : 0)
    }
    PriceFormatter.to_euro(total_after_discounts)
  end
end
