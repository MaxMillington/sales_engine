require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/merchant'
require_relative '../lib/merchant_repository'
require_relative '../lib/sales_engine'
require 'pry'

class MerchantTest < Minitest::Test
  def test_it_can_grab_its_repository
    item = Merchant.new('rows', 'repository')
    assert_equal 'repository', item.repository
  end

  def test_it_returns_an_invoice_instance
    skip
    engine = SalesEngine.new
    engine.start_up
    merchant_repo = engine.merchant_repository
    merchant = merchant_repo.find_by_id(3)
    assert_equal "4", merchant.items
  end

  def test_can_find_associated_invoice
    skip
    engine = SalesEngine.new
    engine.start_up
    merchant = engine.merchant_repository.find_by_id(10)
    assert_equal "609", merchant.invoices
  end

end