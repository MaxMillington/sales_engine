require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/sales_engine'
require_relative '../lib/invoice_item'
require_relative '../lib/invoice_item_repository'

class InvoiceTest < Minitest::Test
  def test_it_returns_instance_of_invoice
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    invoice_item_repo = engine.invoice_item_repository
    invoice_item = invoice_item_repo.find_by_id(4)
    assert_equal 4, invoice_item.invoice.id
  end

  def test_it_returns_instance_of_item
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    invoice_item_repo = engine.invoice_item_repository
    invoice_item = invoice_item_repo.find_by_id(4)
    assert_equal "2", invoice_item.item.id
  end

end