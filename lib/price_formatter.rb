class PriceFormatter
  def self.to_euro(number)
    format('%.2f€', number)
  end
end
