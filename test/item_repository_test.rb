require 'minitest/pride'
require 'minitest/autorun'
require 'bigdecimal'
require_relative '../lib/item_repository'
require_relative '../lib/sales_engine'

class ItemRepositoryTest < Minitest::Test

  def test_all_returns_an_array_of_all_items
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    items = engine.item_repository
    assert_equal Array, items.all.class
  end

  def test_random_returns_one_random_item_obj
    engine = SalesEngine.new
    engine.startup
    items = engine.item_repository
    refute_equal items.random, items.random
  end

  def test_find_an_item_by_id
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    items = engine.item_repository
    assert_equal "Item Autem Minima", items.find_by_id(2).name
  end

  def test_find_an_item_by_name
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    items = engine.item_repository
    assert_equal "2", items.find_by_name("Item Autem Minima").id
  end

  def test_it_can_find_all_by_name
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    items = engine.item_repository
    assert_equal 1, items.find_all_by_name("Item Autem Minima").count
  end

  def test_it_can_find_by_description
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    items = engine.item_repository
    assert_equal "4", items.find_by_description("Sunt eum id eius magni consequuntur delectus veritatis. Quisquam laborum illo ut ab. Ducimus in est id voluptas autem.").id
  end

  def test_it_can_find_all_by_description
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    items = engine.item_repository
    assert_equal 1, items.find_all_by_description("Sunt eum id eius magni consequuntur delectus veritatis. Quisquam laborum illo ut ab. Ducimus in est id voluptas autem.").count
  end

  def test_it_can_find_by_unit_price
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    items = engine.item_repository
    assert_equal "2", items.find_by_unit_price(BigDecimal.new("670.76")).id
  end

  def test_it_can_find_all_by_unit_price
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    items = engine.item_repository
    assert_equal 1, items.find_all_by_unit_price(BigDecimal.new("670.76")).count
  end

  def test_it_can_find_by_merchant_id
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    items = engine.item_repository
    assert_equal "1", items.find_by_merchant_id("1").id
  end

  def test_it_can_find_all_by_merchant_id
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    items = engine.item_repository
    assert_equal 3, items.find_all_by_merchant_id("1").count
  end

  def test_it_can_find_by_created_at
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    items = engine.item_repository
    assert_equal "1", items.find_by_created_at("2012-03-27 14:53:59 UTC").id
  end

  def test_it_can_find_all_by_created_at
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    items = engine.item_repository
    assert_equal 10, items.find_all_by_created_at("2012-03-27 14:53:59 UTC").count
  end

  def test_it_can_find_by_updated_at
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    items = engine.item_repository
    assert_equal "1", items.find_by_created_at("2012-03-27 14:53:59 UTC").id
  end

  def test_it_can_find_all_by_updated_at
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    items = engine.item_repository
    assert_equal 10, items.find_all_by_created_at("2012-03-27 14:53:59 UTC").count
  end

  def test_returns_top_x_items_sold
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    top_selling = engine.item_repository.most_items(2)
    assert_equal "Item Ea Voluptatum", top_selling.first.name
  end

  def test_determines_revenue_for_top_x_items
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    top_selling = engine.item_repository.most_revenue(2)
    assert_equal "Item Ea Voluptatum", top_selling.first.name
  end
end
