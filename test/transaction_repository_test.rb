require 'minitest/pride'
require 'minitest/autorun'
require_relative '../lib/transaction_repository'
require_relative '../lib/sales_engine'

class TransactionRepositoryTest < Minitest::Test

  def test_all_returns_an_array_of_all_tranactions
    engine = SalesEngine.new
    trans = engine.transaction_repository
    merc.load('../data/fixtures/dummy_merchants.csv')
    assert_equal Array, merc.all.class
  end

end
