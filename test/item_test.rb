require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/item'
require_relative '../lib/item_repository'
require_relative '../lib/sales_engine'
require 'pry'


class ItemTest < Minitest::Test

  def test_it_can_grab_its_repository
    item = Item.new(1, 'name', 'description', 4, 5, '2015-02-02', '2015-02-05', 'repository')
    assert_equal 'repository', item.repository
  end

  def test_it_returns_a_merchant_instance
    engine = SalesEngine.new
    item_repo = engine.item_repository
    item_repo.load('./data/fixtures/dummy_items.csv')
    item = item_repo.find_by_id(3)
    assert_equal "Willms and Sons", item.merchant
  end



end