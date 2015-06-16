
#For each repository:
# 1) "all" returns all instances
# 2) "random" returns a random instances
# 3) "find_by_X(match)", where X is some attribute, returns a single instance whose X attribute case-insensitive
# attribute matches the (match) parameter. E.G. 'customer_repository.find_by_first_name("Mary")' could find
# a customer with the first name "Mary" or "mary" but not "Mary Ellen".
# 4)"find_by_all_X(match)", works just like "find_by_X(match)" except it returns all instances of the match
# as opposed to merely one instance. If there are no matches it returns an empty array.

require 'csv'
require_relative 'merchant'
require 'pry'


class MerchantRepository
  attr_reader :merchants, :sales_engine

  def initialize(sales_engine)
    @merchants = []
    @sales_engine = sales_engine
  end

  def load(filepath = '../data/merchants.csv')
    CSV.foreach(filepath, headers: true) do |row|
      @merchants << Merchant.new(row["id"],
                                 row["name"],
                                 row["created_at"],
                                 row["updated_at"],
                                  self)
    end
  end

  def all
    @merchants
  end

  def random
    @merchants.shuffle.first
  end

  def find_by_id(id)
    @merchants.find { |merchant| merchant.id == "#{id}" }
  end

  def find_by_name(name)
    @merchants.find {|merchant| merchant.name == "#{name}"}
  end

  def find_by_created_at(date)
    @merchants.find {|merchant| merchant.created_at == "#{date}"}
  end

  def find_by_updated_at(date)
    @merchants.find {|merchant| merchant.updated_at == "#{date}"}
  end

  def find_all_by_name(name)
    @merchants.find_all {|merchant| merchant.name == "#{name}"}
  end

  def find_all_by_created_at(date)
    @merchants.find_all {|merchant| merchant.created_at == "#{date}"}
  end

  def find_all_by_updated_at(date)
    @merchants.find_all {|merchant| merchant.updated_at == "#{date}"}
  end

end
