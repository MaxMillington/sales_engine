require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/transaction'
require_relative '../lib/transaction_repository'
require_relative '../lib/sales_engine'
require 'pry'


class TransactionTest < Minitest::Test
  def test_it_can_grab_its_repository
    item = Transaction.new('rows', 'repository')
    assert_equal 'repository', item.repository
  end

  def test_it_returns_an_invoice_instance
    engine = SalesEngine.new
    engine.start_up("./data/fixtures")
    transaction_repo = engine.transaction_repository
    transaction = transaction_repo.find_by_id(3)
    assert_equal "4", transaction.invoice_id
  end

  def test_can_find_associated_invoice
    engine = SalesEngine.new
    engine.start_up
    transaction = engine.transaction_repository.find_by_id(717)
    assert_equal "609", transaction.invoice_id
  end


end