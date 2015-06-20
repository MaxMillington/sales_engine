require 'csv'
require_relative 'customer'
require 'pry'
require 'bigdecimal'
require 'bigdecimal/util'


class CustomerRepository
  attr_reader :customers, :sales_engine

  def initialize(sales_engine, data)
    @customers = data.map {|entry| Customer.new(entry, self)}
    @sales_engine = sales_engine
  end

  def find_invoices(customer_id)
    sales_engine.find_invoices_by_customer_id(customer_id)
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