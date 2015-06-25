require 'minitest/pride'
require 'minitest/autorun'
require_relative '../lib/invoice_repository'
require_relative '../lib/sales_engine'

class InvoiceRepositoryTest < Minitest::Test

  def test_all_returns_an_array_of_all_invoices
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    inv = engine.invoice_repository
    assert_equal Array, inv.all.class
  end

  def test_invoice_has_an_id
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    inv = engine.invoice_repository
    id = inv.invoices.first.id
    assert_equal 1, id
  end

  def test_random_returns_one_random_invoice_obj
    engine = SalesEngine.new
    engine.startup
    inv = engine.invoice_repository
    refute_equal inv.random, inv.random
  end

  def test_find_a_invoice_by_customer_id
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    inv = engine.invoice_repository
    assert_equal 1, inv.find_by_id(4).customer_id
  end

  def test_find_a_invoice_by_merchant_id
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    inv = engine.invoice_repository
    assert_equal "1", inv.find_by_id(1).merchant_id
  end

  def test_find_a_invoice_by_status
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    inv = engine.invoice_repository
    assert_equal "1", inv.find_by_customer_id(1).merchant_id
  end

  def test_it_can_find_by_created_at
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    inv = engine.invoice_repository
    assert_equal "1", inv.find_by_created_at("2012-03-25 09:54:09 UTC").merchant_id
  end

  def test_it_can_find_by_updated_at
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    inv = engine.invoice_repository
    assert_equal "1", inv.find_by_updated_at("2012-03-25 09:54:09 UTC").merchant_id
  end

  def test_find_all_invoices_by_customer_id
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    inv = engine.invoice_repository
    assert_equal 6, inv.find_all_by_customer_id(1).count
  end

  def test_find_all_invoices_by_merchant_id
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    inv = engine.invoice_repository
    assert_equal 2, inv.find_all_by_merchant_id("2").count
  end

  def test_find_all_invoices_by_status
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    inv = engine.invoice_repository
    assert_equal 6, inv.find_all_by_status("shipped").count
  end

  def test_find_all_invoices_by_created_at
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    inv = engine.invoice_repository
    assert_equal 3, inv.find_all_by_created_at("2012-03-24 15:54:10 UTC").count
  end

  def test_find_all_invoices_by_updated_at
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    inv = engine.invoice_repository
    assert_equal 3, inv.find_all_by_updated_at("2012-03-24 15:54:10 UTC").count
  end

  def test_create_new_invoices
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    customer = engine.customer_repository.find_by_id(1)
    merchant = engine.merchant_repository.find_by_id(2)
    item1 = engine.item_repository.find_by_id(1)
    item2 = engine.item_repository.find_by_id(2)
    engine.invoice_repository.create(customer: customer, merchant: merchant, items: [item1, item2])
    invoice = engine.invoice_repository.invoices.last
    assert_equal 1, invoice.customer_id
    assert_equal "2", invoice.merchant_id
    assert_equal 8, engine.invoice_item_repository.invoice_items.last.id
  end

  # def test_charge_method
  #   engine = SalesEngine.new("./data/fixtures")
  #   engine.startup
  #   engine.invoice_repository.charge(credit_card_number: "4444333322221111",
  #                                    credit_card_expiration: "10/13", result: "success", id: => id)
  #   transaction = engine.transaction_repository.transactions.last
  #   assert_equal 9, transaction.id
  #   assert_equal 23, transaction.invoice_id
  #   assert transaction.successful?
  # end

end