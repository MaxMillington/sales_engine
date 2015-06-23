require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/item'
require_relative '../lib/item_repository'
require_relative '../lib/sales_engine'


class ItemTest < Minitest::Test
  def test_it_returns_a_merchant_instance
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    item_repo = engine.item_repository
    item = item_repo.find_by_id(3)
    assert_equal "Schroeder-Jerde", item.merchant.name
  end

  def test_it_returns_invoice_items
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    item_repo= engine.item_repository
    item = item_repo.find_by_id(528)
    assert_equal "2", item.invoice_items.map {|x| x.id}.join
  end

  def test_best_day_returns_day_with_most_sales
    engine = SalesEngine.new
    engine.startup
    item = engine.item_repository.find_by_id(600)
    assert_equal '2012-03-26', item.best_day.to_s
  end

end