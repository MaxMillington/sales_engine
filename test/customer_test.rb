require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/sales_engine'
require_relative '../lib/customer'
require_relative '../lib/customer_repository'

class CustomerTest < Minitest::Test
  def test_it_can_grab_its_repository
    invoice = Customer.new('rows', 'repository')
    assert_equal 'repository', invoice.repository
  end

  def test_it_returns_a_collection_of_invoices
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    customer_repo = engine.customer_repository
    customer = customer_repo.find_by_id(1)
    assert_equal [1, 2, 3, 4, 5, 6], customer.invoices.map {|x| x.id}
  end
end
