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
    assert_equal 3, merchant.items.count
  end

  def test_finds_associated_invoices
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    merchant = engine.merchant_repository.find_by_id(1)
    assert_equal 1, merchant.invoices.size
  end

  def test_find_total_revenue_for_a_merchant
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    merchant = engine.merchant_repository.find_by_id(1)
    assert_equal '5539.8', merchant.revenue.to_digits
  end

  def test_find_revenue_by_date
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    merchant = engine.merchant_repository.find_by_id(1)
    assert_equal '5539.8', merchant.revenue(Date.parse('2012-03-25')).to_digits
  end

  def test_finds_favorite_customer
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    merchant = engine.merchant_repository.find_by_id(2)
    customer = merchant.favorite_customer
    assert_equal Customer, customer.class
    assert_equal "Joey", customer.first_name
  end

  def test_find_customers_with_pending_invoices
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    merchant = engine.merchant_repository.find_by_id(1)
    pending_customers = merchant.customers_with_pending_invoices
    assert_equal 0, pending_customers.size
  end

end