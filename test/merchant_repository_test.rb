require 'minitest/pride'
require 'minitest/autorun'
require_relative '../lib/merchant_repository'
require_relative '../lib/sales_engine'

class MerchantRepositoryTest < Minitest::Test

  def test_all_returns_an_array_of_all_merchant

    engine = SalesEngine.new
    merc = engine.merchant_repository
    merc.load('../data/fixtures/dummy_merchants.csv')
    assert_equal Array, merc.all.class
  end

  def test_merchant_person_has_a_name
    engine = SalesEngine.new
    merc = engine.merchant_repository
    merc.load('../data/fixtures/dummy_merchants.csv')
    name = merc.merchants.first.name
    assert_equal "Schroeder-Jerde", name
  end

  def test_random_returns_one_random_merchant_obj
    engine = SalesEngine.new
    merc = engine.merchant_repository
    merc.load
    refute_equal merc.random, merc.random
  end

  def test_find_a_merchant_by_id
    engine = SalesEngine.new
    merc = engine.merchant_repository
    merc.load('../data/fixtures/dummy_merchants.csv')
    assert_equal "Williamson Group", merc.find_by_id(5).name
  end

  def test_find_a_merchant_by_name
    engine = SalesEngine.new
    merc = engine.merchant_repository
    merc.load('../data/fixtures/dummy_merchants.csv')
    assert_equal "Klein, Rempel and Jones", merc.find_by_name("Klein, Rempel and Jones").name
  end

  def test_it_can_find_by_created_at
    engine = SalesEngine.new
    merc = engine.merchant_repository
    merc.load('../data/fixtures/dummy_merchants.csv')
    assert_equal "Schroeder-Jerde", merc.find_by_created_at("2012-03-27 14:53:59 UTC").name
  end

  def test_it_can_find_by_updated_at
    engine = SalesEngine.new
    merc = engine.merchant_repository
    merc.load('../data/fixtures/dummy_merchants.csv')
    assert_equal "Schroeder-Jerde", merc.find_by_updated_at("2012-03-27 14:53:59 UTC").name
  end

  def test_find_all_merchants_by_name
    engine = SalesEngine.new
    merc = engine.merchant_repository
    merc.load('../data/fixtures/dummy_merchants.csv')
    assert_equal 2, merc.find_all_by_name("Williamson Group").count
  end

  def test_it_can_find_all_by_created_at
    engine = SalesEngine.new
    merc = engine.merchant_repository
    merc.load('../data/fixtures/dummy_merchants.csv')
    assert_equal 6, merc.find_all_by_created_at("2012-03-27 14:53:59 UTC").count
  end

  def test_it_can_find_all_by_updated_at
    engine = SalesEngine.new
    merc = engine.merchant_repository
    merc.load('../data/fixtures/dummy_merchants.csv')
    assert_equal 6, merc.find_all_by_updated_at("2012-03-27 14:53:59 UTC").count
  end

end