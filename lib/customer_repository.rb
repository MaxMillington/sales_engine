#For each repository:
# 1) "all" returns all instances
# 2) "random" returns a random instances
# 3) "find_by_X(match)", where X is some attribute, returns a single instance whose X attribute case-insensitive
# attribute matches the (match) parameter. E.G. 'customer_repository.find_by_first_name("Mary")' could find
# a customer with the first name "Mary" or "mary" but not "Mary Ellen".
# 4)"find_by_all_X(match)", works just like "find_by_X(match)" except it returns all instances of the match
# as opposed to merely one instance. If there are no matches it returns an empty array.

require 'csv'
require_relative 'customer'
require 'pry'


class CustomerRepository
  attr_reader :customers, :sales_engine

  def initialize(sales_engine)
    @customers = []
    @sales_engine = sales_engine
  end

  def load(filepath = '../data/customers.csv')
    CSV.foreach(filepath, headers: true) do |row|
      @customers << Customer.new(row["id"],
                                 row["first_name"],
                                 row["last_name"],
                                 row["created_at"],
                                 row["updated_at"],
                                 self)
    end
  end

  def all
    @customers
  end

  def random
    @customers.shuffle.first
  end

  def find_by_id(id)
    @customers.find { |customer| customer.id == "#{id}" }
  end

  def find_by_first_name(first_name)
    @customers.find {|customer| customer.first_name == "#{first_name}"}
  end

  def find_by_last_name(last_name)
    @customers.find {|customer| customer.last_name == "#{last_name}"}
  end

  def find_by_created_at(date)
    @customers.find {|customer| customer.created_at == "#{date}"}
  end

  def find_by_updated_at(date)
    @customers.find {|customer| customer.updated_at == "#{date}"}
  end

  def find_all_by_first_name(first_name)
    @customers.find_all {|customer| customer.first_name == "#{first_name}"}
  end

  def find_all_by_last_name(last_name)
    @customers.find_all {|customer| customer.last_name == "#{last_name}"}
  end

  def find_all_by_created_at(date)
    @customers.find_all {|customer| customer.created_at == "#{date}"}
  end

  def find_all_by_updated_at(date)
    @customers.find_all {|customer| customer.updated_at == "#{date}"}
  end

end
