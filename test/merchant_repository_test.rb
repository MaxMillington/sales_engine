
require 'minitest/pride'
require 'minitest/autorun'
require_relative '../lib/merchant_repository'
require_relative '../lib/sales_engine'

class MerchantRepositoryTest < Minitest::Test

  def test_all_returns_an_array_of_all_merchant
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    merc = engine.merchant_repository
    assert_equal Array, merc.all.class
  end

  def test_merchant_person_has_a_name
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    merc = engine.merchant_repository
    name = merc.merchants.first.name
    assert_equal "Schroeder-Jerde", name
  end

  def test_random_returns_one_random_merchant_obj
    engine = SalesEngine.new
    engine.startup
    merc = engine.merchant_repository
    refute_equal merc.random, merc.random
  end

  def test_find_a_merchant_by_id
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    merc = engine.merchant_repository
    assert_equal "Williamson Group", merc.find_by_id(5).name
  end

  def test_find_a_merchant_by_name
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    merc = engine.merchant_repository
    assert_equal "Klein, Rempel and Jones", merc.find_by_name("Klein, Rempel and Jones").name
  end

  def test_it_can_find_by_created_at
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    merc = engine.merchant_repository
    assert_equal "Schroeder-Jerde", merc.find_by_created_at("2012-03-27 14:53:59 UTC").name
  end

  def test_it_can_find_by_updated_at
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    merc = engine.merchant_repository
    assert_equal "Schroeder-Jerde", merc.find_by_updated_at("2012-03-27 14:53:59 UTC").name
  end

  def test_find_all_merchants_by_name
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    merc = engine.merchant_repository
    assert_equal 1, merc.find_all_by_name("Williamson Group").count
  end

  def test_it_can_find_all_by_created_at
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    merc = engine.merchant_repository
    assert_equal 6, merc.find_all_by_created_at("2012-03-27 14:53:59 UTC").count
  end

  def test_it_can_find_all_by_updated_at
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    merc = engine.merchant_repository
    assert_equal 6, merc.find_all_by_updated_at("2012-03-27 14:53:59 UTC").count
  end

  def test_returns_total_revenue_by_date_for_all_merchants
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    merc   = engine.merchant_repository
    assert_equal '5539.8', merc.revenue(Date.parse('2012-03-25')).to_digits
  end

  def test_return_top_x_merchants_by_revenue
    skip
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    merc_repo = engine.merchant_repository
    mercs = merc_repo.most_revenue(3)
    assert_equal 3, mercs.size
    assert_equal Merchant, mercs[0].class
    assert_equal "Klein, Rempel and Jones", mercs.first.name
  end

  def test_returns_top_x_merchants_by_items_sold
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    merc_repo = engine.merchant_repository
    merc = merc_repo.most_items(4)
    assert_equal "Klein, Rempel and Jones", merc.first.name
    assert_equal 4, merc.size
  end

end