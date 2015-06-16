
#For each repository:
# 1) "all" returns all instances
# 2) "random" returns a random instances
# 3) "find_by_X(match)", where X is some attribute, returns a single instance whose X attribute case-insensitive
# attribute matches the (match) parameter. E.G. 'customer_repository.find_by_first_name("Mary")' could find
# a customer with the first name "Mary" or "mary" but not "Mary Ellen".
# 4)"find_by_all_X(match)", works just like "find_by_X(match)" except it returns all instances of the match
# as opposed to merely one instance. If there are no matches it returns an empty array.

require 'csv'
require_relative 'transaction'
require 'pry'


class TransactionRepository
  attr_reader :transactions, :sales_engine

  def initialize(sales_engine)
    @transactions = []
    @sales_engine = sales_engine
  end

  def load(filepath = '../data/transactions.csv')
    CSV.foreach(filepath, headers: true) do |row|
      @transactions << Transaction.new(row["id"],
                                 row["invoice_id"],
                                 row["credit_card_number"],
                                 row["credit_card_expiration_date"],
                                 row["result"],
                                 row["created_at"],
                                 row["updated_at"],
                                 self)
    end
  end

  def all
    transactions
  end

  def random
    transactions.shuffle.first
  end

  def find_by_id(id)
    transactions.find { |transaction| transaction.id == "#{id}" }
  end

  def find_by_invoice_id(id)
    transactions.find {|transaction| transaction.invoice_id == "#{id}"}
  end

  def find_by_credit_card_number(num)
    transactions.find {|transaction| transaction.credit_card_number == "#{num}"}
  end

  def find_all_by_credit_card_number(num)
    transactions.find_all {|transaction| transaction.credit_card_number == "#{num}"}
  end

  def find_by_result(result)
    transactions.find {|transaction| transaction.result == "#{result}"}
  end

  def find_all_by_result(result)
    transactions.find_all {|transaction| transaction.result == "#{result}"}
  end

  def find_by_credit_card_expiration(num)
    transactions.find {|transaction| transaction.credit_card_expiration_date == "#{num}"}
  end

  def find_by_created_at(date)
    @transactions.find {|transaction| transaction.created_at == "#{date}"}
  end

  def find_by_updated_at(date)
    @transactions.find {|transaction| transaction.created_at == "#{date}"}
  end

  def find_all_by_created_at(date)
    @transactions.find_all {|transaction| transaction.created_at == "#{date}"}
  end

  def find_all_by_updated_at(date)
    @transactions.find_all {|transaction| transaction.updated_at == "#{date}"}
  end

end