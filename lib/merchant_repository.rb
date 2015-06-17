require 'csv'
require_relative 'merchant'
require 'pry'


class MerchantRepository
  attr_reader :merchants, :sales_engine

  def initialize(sales_engine, data)
    @merchants = data.map {|entry| Merchant.new(entry, self) }
    @sales_engine = sales_engine
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
