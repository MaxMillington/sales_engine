require 'csv'
require_relative 'item'
require_relative '../lib/sales_engine'
require 'bigdecimal'
require 'bigdecimal/util'


class ItemRepository
  attr_reader :items, :sales_engine

  def initialize(sales_engine, data)
    @items = data.map {|entry| Item.new(entry, self) }
    @sales_engine = sales_engine
  end

  def inspect
    "#<#{self.class} #{@items.size} rows>"
  end

  def find_merchant(merchant_id)
    sales_engine.find_merchant_by_id(merchant_id)
  end

  def find_invoice_item(id)
    sales_engine.find_invoice_item_by_id(id)
  end

  def all
    @items
  end

  def random
    items.shuffle.first
  end

  def find_by_id(id)
    items.find {|item| item.id == "#{id}"}
  end

  def find_all_by_id(id)
    items.find_all {|item| item.id == "#{id}"}
  end

  def find_by_name(name)
    items.find {|item| item.name == "#{name}"}
  end

  def find_all_by_name(name)
    items.find_all {|item| item.name == "#{name}"}
  end

  def find_by_description(description)
    items.find {|item| item.description == "#{description}"}
  end

  def find_all_by_description(description)
    items.find_all {|item| item.description == "#{description}"}
  end

  def find_by_unit_price(price)
    items.find {|item| item.unit_price == "#{price}"}
  end

  def find_all_by_unit_price(price)
    items.find_all {|item| item.unit_price == "#{price}"}
  end

  def find_by_merchant_id(merchant_id)
    items.find {|item| item.merchant_id == "#{merchant_id}"}
  end

  def find_all_by_merchant_id(merchant_id)
    items.find_all {|item| item.merchant_id == "#{merchant_id}"}
  end

  def find_by_created_at(date)
    items.find {|item| item.created_at == "#{date}"}
  end

  def find_all_by_created_at(date)
    items.find_all {|item| item.created_at == "#{date}"}
  end

  def find_by_updated_at_at(date)
    items.find {|item| item.updated_at == "#{date}"}
  end

  def find_all_by_updated_at(date)
    items.find_all {|item| item.updated_at == "#{date}"}
  end

end
