require 'minitest/pride'
require 'minitest/autorun'
require_relative '../lib/transaction_repository'
require_relative '../lib/sales_engine'

class TransactionRepositoryTest < Minitest::Test

  def test_all_returns_an_array_of_all_tranactions
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    trans = engine.transaction_repository
    assert_equal Array, trans.all.class
  end

  def test_random_returns_one_random_transaction_obj
    engine = SalesEngine.new
    engine.startup
    trans = engine.transaction_repository
    refute_equal trans.random, trans.random
  end

  def test_find_a_transaction_by_id
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    trans = engine.transaction_repository
    assert_equal "4654405418249632", trans.find_by_id(1).credit_card_number
  end

  def test_find_a_transaction_by_invoice_id
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    trans = engine.transaction_repository
    assert_equal "4654405418249632", trans.find_by_invoice_id(1).credit_card_number
  end

  def test_it_can_find_by_credit_card_number
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    trans = engine.transaction_repository
    assert_equal 5, trans.find_by_credit_card_number("4844518708741275").id
  end

  def test_it_can_find_by_results
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    trans = engine.transaction_repository
    assert_equal nil, trans.find_by_result(nil)
  end

  def test_it_can_find_all_by_result
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    trans = engine.transaction_repository
    assert_equal [], trans.find_all_by_result(nil)
  end

  def test_it_can_find_by_credit_card_expiration
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    trans = engine.transaction_repository
    assert_equal nil, trans.find_by_credit_card_expiration(nil)
  end

  def test_it_can_find_all_by_credit_card_number
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    trans = engine.transaction_repository
    assert_equal 5, trans.find_all_by_credit_card_number("4844518708741275").count
  end

  def test_it_can_find_by_created_at
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    trans = engine.transaction_repository
    assert_equal "4654405418249632", trans.find_by_created_at("2012-03-27 14:54:09 UTC").credit_card_number
  end

  def test_it_can_find_by_updated_at
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    trans = engine.transaction_repository
    assert_equal "4654405418249632", trans.find_by_updated_at("2012-03-27 14:54:09 UTC").credit_card_number
  end

  def test_it_can_find_all_by_created_at
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    trans = engine.transaction_repository
    assert_equal 2, trans.find_all_by_created_at("2012-03-27 14:54:09 UTC").count
  end

  def test_it_can_find_all_by_updated_at
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    trans = engine.transaction_repository
    assert_equal 2, trans.find_all_by_updated_at("2012-03-27 14:54:09 UTC").count
  end

end
