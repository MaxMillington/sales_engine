require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/merchant'
require_relative '../lib/merchant_repository'
require_relative '../lib/sales_engine'


class MerchantTest < Minitest::Test
  def test_it_can_grab_its_repository
    item = Merchant.new('rows', 'repository')
    assert_equal 'repository', item.repository
  end

  def test_it_returns_associated_items
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    merchant_repo = engine.merchant_repository
    merchant = merchant_repo.find_by_id(1)
    assert_equal 10, merchant.items.count
  end

  def test_finds_associated_invoices
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    merchant = engine.merchant_repository.find_by_id(1)
    assert_equal 1, merchant.invoices.size
  end

end