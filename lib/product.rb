class Product

  attr_accessor :name, :price
  attr_reader   :code

  def initialize(code:, name:, price:)
    @code = code.to_s
    @name = name.to_s
    @price = price.to_f
    validate
  end

  def price=(price)
    @price = price
    validate
  end

  def name=(name)
    @name = name
    validate
  end

  private

  def validate
    raise ArgumentError, 'price cant be empty'    if price.nil?
    raise ArgumentError, 'price must be a float'  unless price.is_a? Float
    raise ArgumentError, 'price cant be negative' if price < 0

    raise ArgumentError, 'name cant be empty' if name.to_s.empty?
    raise ArgumentError, 'code cant be empty' if code.to_s.empty?
  end
end
