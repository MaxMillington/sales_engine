require 'minitest/pride'
require 'minitest/autorun'
require_relative '../lib/invoice_item_repository'
require_relative '../lib/sales_engine'

class InvoiceItemTest < Minitest::Test

  def test_all_returns_an_array_of_all_invoice_items
    engine = SalesEngine.new
    inv = engine.invoice_item_repository
    inv.load('../data/fixtures/dummy_invoice_items.csv')
    assert_equal Array, inv.all.class
  end

  def test_invoice_item_has_an_item_id
    engine = SalesEngine.new
    inv = engine.invoice_item_repository
    inv.load('../data/fixtures/dummy_invoice_items.csv')
    item_id = inv.invoice_items.first.item_id
    assert_equal "539", item_id
  end

  def test_random_returns_one_random_invoice_item_obj
    engine = SalesEngine.new
    inv = engine.invoice_item_repository
    inv.load
    refute_equal inv.random, inv.random
  end

  def test_find_a_invoice_item_by_id
    engine = SalesEngine.new
    inv = engine.invoice_item_repository
    inv.load('../data/fixtures/dummy_invoice_items.csv')
    assert_equal "5", inv.find_by_id(5).id
  end

  def test_find_a_invoice_item_by_invoice_id
    engine = SalesEngine.new
    inv = engine.invoice_item_repository
    inv.load('../data/fixtures/dummy_invoice_items.csv')
    assert_equal "1", inv.find_by_invoice_id("1").invoice_id
  end

  def test_find_a_invoice_item_by_quantity
    engine = SalesEngine.new
    inv = engine.invoice_item_repository
    inv.load('../data/fixtures/dummy_invoice_items.csv')
    assert_equal "5", inv.find_by_quantity("5").quantity
  end

  def test_find_a_invoice_item_by_unit_price
    engine = SalesEngine.new
    inv = engine.invoice_item_repository
    inv.load('../data/fixtures/dummy_invoice_items.csv')
    assert_equal "13635", inv.find_by_unit_price("13635").unit_price
  end

  def test_it_can_find_by_created_at
    engine = SalesEngine.new
    inv = engine.invoice_item_repository
    inv.load('../data/fixtures/dummy_invoice_items.csv')
    assert_equal "539", inv.find_by_created_at("2012-03-27 14:54:09 UTC").item_id
  end

  def test_it_can_find_by_updated_at
    engine = SalesEngine.new
    inv = engine.invoice_item_repository
    inv.load('../data/fixtures/dummy_invoice_items.csv')
    assert_equal "539", inv.find_by_updated_at("2012-03-27 14:54:09 UTC").item_id
  end

  def test_find_all_invoice_items_by_id
    engine = SalesEngine.new
    inv = engine.invoice_item_repository
    inv.load('../data/fixtures/dummy_invoice_items.csv')
    assert_equal 1, inv.find_all_by_item_id("539").count
  end

  def test_find_all_invoice_items_by_item_id
    engine = SalesEngine.new
    inv = engine.invoice_item_repository
    inv.load('../data/fixtures/dummy_invoice_items.csv')
    assert_equal 2, inv.find_all_by_item_id("529").count
  end

  def test_find_all_invoice_items_by_invoice_id
    engine = SalesEngine.new
    inv = engine.invoice_item_repository
    inv.load('../data/fixtures/dummy_invoice_items.csv')
    assert_equal 6, inv.find_all_by_invoice_id("1").count
  end

  def test_find_all_invoice_items_by_quantity
    engine = SalesEngine.new
    inv = engine.invoice_item_repository
    inv.load('../data/fixtures/dummy_invoice_items.csv')
    assert_equal 2, inv.find_all_by_quantity("7").count
  end

  def test_find_all_invoice_items_by_unit_price
    engine = SalesEngine.new
    inv = engine.invoice_item_repository
    inv.load('../data/fixtures/dummy_invoice_items.csv')
    assert_equal 2, inv.find_all_by_unit_price("79140").count
  end

  def test_find_all_invoice_items_by_created_at
    engine = SalesEngine.new
    inv = engine.invoice_item_repository
    inv.load('../data/fixtures/dummy_invoice_items.csv')
    assert_equal 6, inv.find_all_by_created_at("2012-03-27 14:54:09 UTC").count
  end

  def test_find_all_invoice_items_by_updated_at
    engine = SalesEngine.new
    inv = engine.invoice_item_repository
    inv.load('../data/fixtures/dummy_invoice_items.csv')
    assert_equal 6, inv.find_all_by_updated_at("2012-03-27 14:54:09 UTC").count
  end


end