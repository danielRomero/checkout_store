require 'codeclimate-test-reporter'
CodeClimate::TestReporter.start
$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require_relative '../lib/pricing_rules/buy_x_pay_y'
require_relative '../lib/pricing_rules/discount_bulk_purchases'
require_relative '../lib/checkout'
require_relative '../lib/line_item'
require_relative '../lib/pricing_rule'
require_relative '../lib/product'
require_relative '../lib/store'

require 'minitest/autorun'
require 'minitest/reporters'
require 'pry'

Minitest::Reporters.use!(Minitest::Reporters::MeanTimeReporter.new({ color: true }))
