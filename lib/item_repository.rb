require 'csv'
require_relative 'item'
require 'pry'


class ItemRepository
  attr_reader :items, :sales_engine

  def initialize(sales_engine)
    @items = []
    @sales_engine = sales_engine
  end

  def load(filepath = '../data/items.csv')
    CSV.foreach(filepath, headers: true) do |row|
      @items << Item.new(row["id"],
                                 row["name"],
                                 row["description"],
                                 row["unit_price"],
                                 row["merchant_id"],
                                 row["created_at"],
                                 row["updated_at"],
                                 self)
    end
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
