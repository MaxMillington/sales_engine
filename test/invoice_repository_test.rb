require 'minitest/pride'
require 'minitest/autorun'
require_relative '../lib/invoice_repository'
require_relative '../lib/sales_engine'

class InvoiceRepositoryTest < Minitest::Test

  def test_all_returns_an_array_of_all_invoices

    engine = SalesEngine.new
    inv = engine.invoice_repository
    inv.load('../data/fixtures/dummy_invoices.csv')
    assert_equal Array, inv.all.class
  end

  def test_invoice_has_a_id
    engine = SalesEngine.new
    inv = engine.invoice_repository
    inv.load('../data/fixtures/dummy_invoices.csv')
    id = inv.invoices.first.id
    assert_equal "1", id
  end

  def test_random_returns_one_random_invoice_obj
    engine = SalesEngine.new
    inv = engine.invoice_repository
    inv.load
    refute_equal inv.random, inv.random
  end

  def test_find_a_invoice_by_customer_id
    engine = SalesEngine.new
    inv = engine.invoice_repository
    inv.load('../data/fixtures/dummy_invoices.csv')
    assert_equal "1", inv.find_by_id(4).customer_id
  end

  def test_find_a_invoice_by_merchant_id
    engine = SalesEngine.new
    inv = engine.invoice_repository
    inv.load('../data/fixtures/dummy_invoices.csv')
    assert_equal "26", inv.find_by_id(1).merchant_id
  end

  def test_find_a_invoice_by_status
    engine = SalesEngine.new
    inv = engine.invoice_repository
    inv.load('../data/fixtures/dummy_invoices.csv')
    assert_equal "26", inv.find_by_customer_id(1).merchant_id
  end

  def test_it_can_find_by_created_at
    engine = SalesEngine.new
    inv = engine.invoice_repository
    inv.load('../data/fixtures/dummy_invoices.csv')
    assert_equal "26", inv.find_by_created_at("2012-03-25 09:54:09 UTC").merchant_id
  end

  def test_it_can_find_by_updated_at
    engine = SalesEngine.new
    inv = engine.invoice_repository
    inv.load('../data/fixtures/dummy_invoices.csv')
    assert_equal "26", inv.find_by_updated_at("2012-03-25 09:54:09 UTC").merchant_id
  end

  def test_find_all_invoices_by_customer_id
    engine = SalesEngine.new
    inv = engine.invoice_repository
    inv.load('../data/fixtures/dummy_invoices.csv')
    assert_equal 5, inv.find_all_by_customer_id("1").count
  end

  def test_find_all_invoices_by_merchant_id
    engine = SalesEngine.new
    inv = engine.invoice_repository
    inv.load('../data/fixtures/dummy_invoices.csv')
    assert_equal 2, inv.find_all_by_merchant_id("33").count
  end

  def test_find_all_invoices_by_status
    engine = SalesEngine.new
    inv = engine.invoice_repository
    inv.load('../data/fixtures/dummy_invoices.csv')
    assert_equal 5, inv.find_all_by_status("shipped").count
  end

  def test_find_all_invoices_by_created_at
    engine = SalesEngine.new
    inv = engine.invoice_repository
    inv.load('../data/fixtures/dummy_invoices.csv')
    assert_equal 2, inv.find_all_by_created_at("2012-03-24 15:54:10 UTC").count
  end

  def test_find_all_invoices_by_updated_at
    engine = SalesEngine.new
    inv = engine.invoice_repository
    inv.load('../data/fixtures/dummy_invoices.csv')
    assert_equal 2, inv.find_all_by_updated_at("2012-03-24 15:54:10 UTC").count
  end

end