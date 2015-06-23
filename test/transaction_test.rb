require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/transaction'
require_relative '../lib/transaction_repository'
require_relative '../lib/sales_engine'



class TransactionTest < Minitest::Test
  def test_it_can_grab_its_repository
    item = Transaction.new('rows', 'repository')
    assert_equal 'repository', item.repository
  end

  def test_it_returns_an_invoice_instance
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    transaction_repo = engine.transaction_repository
    transaction = transaction_repo.find_by_id(3)
    # require 'pry'; binding.pry
    assert_equal 4, transaction.invoice.id
  end

  def test_can_find_associated_invoice
    engine = SalesEngine.new("./data/fixtures")
    engine.startup
    transaction_repo = engine.transaction_repository
    transaction = transaction_repo.find_by_id(717)
    assert_equal 609, transaction.invoice.id
  end


end