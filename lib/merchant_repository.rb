require 'csv'
require_relative 'merchant'
require_relative '../lib/invoice'
require 'bigdecimal'
require 'bigdecimal/util'


class MerchantRepository
  attr_reader :merchants, :sales_engine

  def initialize(sales_engine, data)
    @merchants = data.map {|entry| Merchant.new(entry, self) }
    @sales_engine = sales_engine
    @revenue = []
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

  def find_items(id)
    sales_engine.find_items_by_merchant_id(id)
  end

  def find_invoices(id)
    sales_engine.find_invoices_by_merchant_id(id)
  end

  def revenue
    @revenue
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

  def find_customer(customer_id)
    sales_engine.customer_repository.find_by_id(customer_id)
  end

  def revenue(date)
    merchants_on_date = @merchants.find_all do |merchant|
      merchant.invoices.any? do |invoice|
        Date.parse(invoice.created_at) == date
      end
    end
    merchants_on_date.map { |merchant| merchant.revenue(date) }.reduce(:+)
  end

end
