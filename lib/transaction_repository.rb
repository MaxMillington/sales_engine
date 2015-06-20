require 'csv'
require_relative 'transaction'
require 'pry'
require 'bigdecimal'
require 'bigdecimal/util'

class TransactionRepository
  attr_reader :transactions, :sales_engine

  def initialize(sales_engine, data)
    @transactions = data.map {|entry| Transaction.new(entry, self)}
    @sales_engine = sales_engine
  end

  def find_invoice(id)
    sales_engine.find_invoice_by_id(id)
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

  def find_all_by_invoice_id(id)
    transactions.find_all {|transaction| transaction.invoice_id == "#{id}"}
  end

end