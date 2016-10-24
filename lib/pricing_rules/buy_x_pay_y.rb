require_relative '../pricing_rule'
# Offer buy X and pay Y for free
# By default buy 2 units and pay 1 (1 free) -- 2 x 1
class BuyXPayY < PricingRule

  attr_reader :buy_units, :pay_units
  def initialize(code:, buy_units: 2, pay_units: 1)
    @buy_units = buy_units
    @pay_units = pay_units
    super code
    validate
  end

  def apply(line_items)
    (line_items[code].quantity / buy_units) *
      (-line_items[code].product.price * (buy_units - pay_units))
  end

  private

  def validate
    raise ArgumentError, 'buy_units cant be empty' if buy_units.nil?
    raise ArgumentError, 'buy_units must be a number' unless buy_units.kind_of?(Integer)
    raise ArgumentError, 'pay_units cant be empty' if pay_units.nil?
    raise ArgumentError, 'pay_units must be a number' unless pay_units.kind_of?(Integer)
    super
  end
end
