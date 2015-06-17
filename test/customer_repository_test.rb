require 'minitest/pride'
require 'minitest/autorun'
require_relative '../lib/customer_repository'
require_relative '../lib/sales_engine'

class CustomerRepositoryTest < Minitest::Test

  def test_all_returns_an_array_of_all_customers
    engine = SalesEngine.new
    cust = engine.customer_repository
    cust.load('../data/fixtures/dummy_customers.csv')
    assert_equal Array, cust.all.class
  end

  def test_customer_person_has_a_first_name
    engine = SalesEngine.new
    cust = engine.customer_repository
    cust.load('../data/fixtures/dummy_customers.csv')
    first_name = cust.customers.first.first_name
    assert_equal "Joey", first_name
  end

  def test_random_returns_one_random_customer_obj
    engine = SalesEngine.new
    cust = engine.customer_repository
    cust.load
    refute_equal cust.random, cust.random
  end

  def test_find_a_customer_by_id
    engine = SalesEngine.new
    cust = engine.customer_repository
    cust.load('../data/fixtures/dummy_customers.csv')
    assert_equal "Sylvester", cust.find_by_id(5).first_name
  end

  def test_find_a_customer_by_first_name
    engine = SalesEngine.new
    cust = engine.customer_repository
    cust.load('../data/fixtures/dummy_customers.csv')
    assert_equal "Joey", cust.find_by_first_name("Joey").first_name
  end

  def test_it_can_find_by_created_at
    engine = SalesEngine.new
    cust = engine.customer_repository
    cust.load('../data/fixtures/dummy_customers.csv')
    assert_equal "Cecelia", cust.find_by_created_at("2012-03-27 14:54:10 UTC").first_name
  end

  def test_it_can_find_by_updated_at
    engine = SalesEngine.new
    cust = engine.customer_repository
    cust.load('../data/fixtures/dummy_customers.csv')
    assert_equal "Cecelia", cust.find_by_updated_at("2012-03-27 14:54:10 UTC").first_name
  end

  def test_find_all_customers_by_name
    engine = SalesEngine.new
    cust = engine.customer_repository
    cust.load('../data/fixtures/dummy_customers.csv')
    assert_equal 1, cust.find_all_by_first_name("Sylvester").count
  end

  def test_it_can_find_all_by_created_at
    engine = SalesEngine.new
    cust = engine.customer_repository
    cust.load('../data/fixtures/dummy_customers.csv')
    assert_equal 4, cust.find_all_by_created_at("2012-03-27 14:54:10 UTC").count
  end

  def test_it_can_find_all_by_updated_at
    engine = SalesEngine.new
    cust = engine.customer_repository
    cust.load('../data/fixtures/dummy_customers.csv')
    assert_equal 4, cust.find_all_by_updated_at("2012-03-27 14:54:10 UTC").count
  end

end