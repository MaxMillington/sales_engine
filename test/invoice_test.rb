require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/sales_engine'
require_relative '../lib/invoice'
require_relative '../lib/invoice_repository'
require 'pry'

class InvoiceTest < Minitest::Test
  def test_it_can_grab_its_repository
    invoice = Invoice.new('rows', 'repository')
    assert_equal 'repository', invoice.repository
  end

  def test_it_returns_instance_of_customer
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    invoice_repo = engine.invoice_repository
    invoice = invoice_repo.find_by_id(6)
    assert_equal "Joey", invoice.customer.first_name
  end

  def test_it_returns_instance_of_merchant
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    invoice_repo = engine.invoice_repository
    invoice = invoice_repo.find_by_id(6)
    assert_equal "Schroeder-Jerde", invoice.merchant.name
  end

  def test_it_returns_a_collection_of_associated_items
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    invoice_repo = engine.invoice_repository
    invoice = invoice_repo.find_by_id(1)
    assert_equal ["Viae", "Video", "Vincit", "Vivimus", "Veni"], invoice.items.map {|x| x.map {|y| y.name}}.flatten

  end

  def test_it_returns_a_collection_of_associated_transactions
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    invoice_repo = engine.invoice_repository
    invoice = invoice_repo.find_by_id(6)
    assert_equal ["5", "6"], invoice.transactions.map {|x| x.id}
  end

  def test_it_returns_a_collection_of_associated_invoice_items
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    invoice_repo = engine.invoice_repository
    invoice = invoice_repo.find_by_id(1)
    assert_equal ["1", "2", "3", "4", "5"], invoice.invoice_items.map {|x| x.id}
  end

end