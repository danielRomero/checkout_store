require_relative '../test_helper'

describe PriceFormatter do
  it 'to_euro' do
    proc { PriceFormatter.to_euro('not a number') }.must_raise ArgumentError
    PriceFormatter.to_euro(2).must_equal '2.00€'
    PriceFormatter.to_euro(2.2).must_equal '2.20€'
    PriceFormatter.to_euro(2.23).must_equal '2.23€'
  end
end
