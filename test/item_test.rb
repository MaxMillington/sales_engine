require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/item'
require_relative '../lib/item_repository'
require_relative '../lib/sales_engine'
require 'pry'


class ItemTest < Minitest::Test
  def test_it_can_grab_its_repository
    item = Item.new('rows', 'repository')
    assert_equal 'repository', item.repository
  end

  def test_it_returns_a_merchant_instance
    engine = SalesEngine.new
    engine.start_up("./data/fixtures")
    item_repo = engine.item_repository
    item = item_repo.find_by_id(3)
    assert_equal "Schroeder-Jerde", item.merchant.name
  end



end