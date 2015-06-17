#For each repository:
# 1) "all" returns all instances
# 2) "random" returns a random instances
# 3) "find_by_X(match)", where X is some attribute, returns a single instance whose X attribute case-insensitive
# attribute matches the (match) parameter. E.G. 'customer_repository.find_by_first_name("Mary")' could find
# a customer with the first name "Mary" or "mary" but not "Mary Ellen".
# 4)"find_by_all_X(match)", works just like "find_by_X(match)" except it returns all instances of the match
# as opposed to merely one instance. If there are no matches it returns an empty array.

require 'csv'
require_relative 'invoice'
require 'pry'


class InvoiceRepository
  attr_reader :invoices, :sales_engine

  def initialize(sales_engine)
    @invoices = []
    @sales_engine = sales_engine
  end

  def load(filepath = '../data/invoices.csv')
    CSV.foreach(filepath, headers: true) do |row|
      @invoices << Invoice.new(row["id"],
                               row["customer_id"],
                               row["merchant_id"],
                               row["status"],
                               row["created_at"],
                               row["updated_at"],
                               self)
    end
  end

  def all
    @invoices
  end

  def random
    @invoices.shuffle.first
  end

  def find_by_id(id)
    @invoices.find { |invoice| invoice.id == "#{id}" }
  end

  def find_by_customer_id(customer_id)
    @invoices.find { |invoice| invoice.customer_id == "#{customer_id}" }
  end

  def find_by_merchant_id(merchant_id)
    @invoices.find { |invoice| invoice.merchant_id == "#{merchant_id}" }
  end

  def find_by_status(status)
    @invoices.find { |invoice| invoice.status == "#{status}" }
  end

  def find_by_created_at(created_at)
    @invoices.find { |invoice| invoice.created_at == "#{created_at}" }
  end

  def find_by_updated_at(updated_at)
    @invoices.find { |invoice| invoice.updated_at == "#{updated_at}" }
  end

  def find_all_by_customer_id(customer_id)
    @invoices.find_all { |invoice| invoice.customer_id == "#{customer_id}" }
  end

  def find_all_by_merchant_id(merchant_id)
    @invoices.find_all { |invoice| invoice.merchant_id == "#{merchant_id}" }
  end

  def find_all_by_status(status)
    @invoices.find_all { |invoice| invoice.status == "#{status}" }
  end

  def find_all_by_created_at(created_at)
    @invoices.find_all { |invoice| invoice.created_at == "#{created_at}" }
  end

  def find_all_by_updated_at(updated_at)
    @invoices.find_all { |invoice| invoice.updated_at == "#{updated_at}" }
  end
end

