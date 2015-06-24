require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/item'
require_relative '../lib/item_repository'
require_relative '../lib/sales_engine'


class ItemTest < Minitest::Test
  def setup
    @engine = SalesEngine.new("./data/fixtures")
    @engine.startup
  end

  def test_it_returns_a_merchant_instance
    item_repo = @engine.item_repository
    item = item_repo.find_by_id(3)
    assert_equal "Willms and Sons", item.merchant.name
  end

  def test_it_returns_invoice_items
    item_repo= @engine.item_repository
    item = item_repo.find_by_id(3)
    assert_equal "26", item.invoice_items.map {|x| x.id}.join
  end

  def test_best_day_returns_day_with_most_sales
    item = @engine.item_repository.find_by_id(1)
    assert_equal '2012-03-24', item.best_day.to_s
  end

  def test_number_sold_excludes_failed_transactions
    failed_item = @engine.item_repository.find_by_id(5) #item 5 has failed transaction in fixture data
    success_item = @engine.item_repository.find_by_id(9) #item 9 should be good
    assert_equal 0, failed_item.number_sold
  end
end