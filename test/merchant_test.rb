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

  def test_it_returns_associated_items
    engine = SalesEngine.new
    engine.start_up("./data/fixtures")
    merchant_repo = engine.merchant_repository
    merchant = merchant_repo.find_by_id(1)
    assert_equal 10, merchant.items.count
  end

  def test_finds_associated_invoices
    engine = SalesEngine.new
    engine.start_up("./data/fixtures")
    merchant = engine.merchant_repository.find_by_id(1)
    assert_equal "6", merchant.invoices.id
  end

end