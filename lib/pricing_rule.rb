class PricingRule
  attr_reader :code

  def initialize(code)
    @code = code
    validate
  end

  def must_apply?(line_items)
    !line_items[code].nil?
  end

  def apply(_line_items = {})
    0.0
  end

  private

  def validate
    raise ArgumentError, 'code cant be empty' if code.nil?
    raise ArgumentError, 'code must be a string' unless code.kind_of?(String)
  end
end
