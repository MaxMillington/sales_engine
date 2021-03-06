require 'minitest/pride'
require 'minitest/autorun'
require_relative '../lib/invoice_item_repository'
require_relative '../lib/sales_engine'

class InvoiceItemTest < Minitest::Test

  def test_all_returns_an_array_of_all_invoice_items
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    inv = engine.invoice_item_repository
    assert_equal Array, inv.all.class
  end

  def test_invoice_item_has_an_item_id
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    inv = engine.invoice_item_repository
    item_id = inv.invoice_items.first.item_id
    assert_equal "1", item_id
  end

  def test_random_returns_one_random_invoice_item_obj
    engine = SalesEngine.new
    engine.startup
    inv = engine.invoice_item_repository
    refute_equal inv.random, inv.random
  end

  def test_find_a_invoice_item_by_id
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    inv = engine.invoice_item_repository
    assert_equal 5, inv.find_by_id(5).id
  end

  def test_find_a_invoice_item_by_invoice_id
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    inv = engine.invoice_item_repository
    assert_equal 1, inv.find_by_invoice_id(1).invoice_id
  end

  def test_find_a_invoice_item_by_quantity
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    inv = engine.invoice_item_repository
    assert_equal 5, inv.find_by_quantity(5).quantity
  end

  def test_find_a_invoice_item_by_unit_price
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    inv = engine.invoice_item_repository
    assert_equal "136.35", inv.find_by_unit_price(BigDecimal.new("136.35")).unit_price.to_digits
  end

  def test_find_all_invoice_items_by_unit_price
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    inv = engine.invoice_item_repository
    assert_equal 1, inv.find_all_by_unit_price(BigDecimal.new("791.40")).count
  end

  def test_it_can_find_by_created_at
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    inv = engine.invoice_item_repository
    assert_equal "1", inv.find_by_created_at("2012-03-27 14:54:09 UTC").item_id
  end

  def test_it_can_find_by_updated_at
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    inv = engine.invoice_item_repository
    assert_equal "1", inv.find_by_updated_at("2012-03-27 14:54:09 UTC").item_id
  end

  def test_find_all_invoice_items_by_id
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    inv = engine.invoice_item_repository
    assert_equal 1, inv.find_all_by_item_id("5").count
  end

  def test_find_all_invoice_items_by_item_id
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    inv = engine.invoice_item_repository
    assert_equal 1, inv.find_all_by_item_id("2").count
  end

  def test_find_all_invoice_items_by_invoice_id
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    inv = engine.invoice_item_repository
    assert_equal 1, inv.find_all_by_invoice_id(1).count
  end

  def test_find_all_invoice_items_by_quantity
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    inv = engine.invoice_item_repository
    assert_equal 1, inv.find_all_by_quantity(5).count
  end

  def test_find_all_invoice_items_by_created_at
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    inv = engine.invoice_item_repository
    assert_equal 6, inv.find_all_by_created_at("2012-03-27 14:54:09 UTC").count
  end

  def test_find_all_invoice_items_by_updated_at
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    inv = engine.invoice_item_repository
    assert_equal 6, inv.find_all_by_updated_at("2012-03-27 14:54:09 UTC").count
  end

  def test_it_has_created_a_new_invoice_items
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    item1 = engine.item_repository.find_by_id(1)
    item2 = engine.item_repository.find_by_id(2)
    customer = engine.customer_repository.find_by_id(1)
    merchant = engine.merchant_repository.find_by_id(2)
    engine.invoice_repository.create(customer: customer, merchant: merchant, items: [item1, item2])
    first = engine.invoice_item_repository.invoice_items[0]
    second = engine.invoice_item_repository.invoice_items.last
    assert_equal "1", first.item_id
    assert_equal 5, first.quantity
    assert_equal "2", second.item_id
    assert_equal 1, second.quantity
    assert_equal 1, first.id
    assert_equal 8, second.id
  end

end