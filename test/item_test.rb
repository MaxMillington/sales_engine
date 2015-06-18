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

  def test_it_returns_invoice_items
    skip
    engine = SalesEngine.new
    engine.start_up
    item_repo= engine.item_repository
    item = item_repo.find_by_id("528")
    assert_equal "2", item.invoice_items.id
  end

  def test_can_find_associated_invoice_items
    skip
    engine = SalesEngine.new
    engine.start_up
    item = engine.item_repository.find_by_id(847)
    assert_equal 1, item.invoice_items.size
    # assert_equal InvoiceItem, item.invoice_items[0].class
  end

end