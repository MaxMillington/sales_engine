#For each repository:
# 1) "all" returns all instances
# 2) "random" returns a random instances
# 3) "find_by_X(match)", where X is some attribute, returns a single instance whose X attribute case-insensitive
# attribute matches the (match) parameter. E.G. 'customer_repository.find_by_first_name("Mary")' could find
# a customer with the first name "Mary" or "mary" but not "Mary Ellen".
# 4)"find_by_all_X(match)", works just like "find_by_X(match)" except it returns all instances of the match
# as opposed to merely one instance. If there are no matches it returns an empty array.

require 'csv'
require_relative 'invoice_item'
require 'pry'


class InvoiceItemRepository
  attr_reader :invoice_items, :sales_engine

  def initialize(sales_engine)
    @invoice_items = []
    @sales_engine = sales_engine
  end

  def load(filepath = '../data/invoice_items.csv')
    CSV.foreach(filepath, headers: true) do |row|
      @invoice_items << InvoiceItem.new(row["id"],
                                        row["item_id"],
                                        row["invoice_id"],
                                        row["quantity"],
                                        row["unit_price"],
                                        row["created_at"],
                                        row["updated_at"],
                                        self)
    end
  end

  def all
    @invoice_items
  end

  def random
    @invoice_items.shuffle.first
  end

  def find_by_id(id)
    @invoice_items.find { |invoice_item| invoice_item.id == "#{id}" }
  end

  def find_by_item_id(item_id)
    @invoice_items.find { |invoice_item| invoice_item.item_id == "#{item_id}" }
  end

  def find_by_invoice_id(invoice_id)
    @invoice_items.find { |invoice_item| invoice_item.invoice_id == "#{invoice_id}" }
  end

  def find_by_quantity(quantity)
    @invoice_items.find { |invoice_item| invoice_item.quantity == "#{quantity}" }
  end

  def find_by_unit_price(unit_price)
    @invoice_items.find { |invoice_item| invoice_item.unit_price == "#{unit_price}" }
  end

  def find_by_created_at(created_at)
    @invoice_items.find { |invoice_item| invoice_item.created_at == "#{created_at}" }
  end

  def find_by_updated_at(updated_at)
    @invoice_items.find { |invoice_item| invoice_item.updated_at == "#{updated_at}" }
  end

  def find_all_by_id(id)
    @invoice_items.find_all { |invoice_item| invoice_item.id == "#{id}" }
  end

  def find_all_by_item_id(item_id)
    @invoice_items.find_all { |invoice_item| invoice_item.item_id == "#{item_id}" }
  end

  def find_all_by_invoice_id(invoice_id)
    @invoice_items.find_all { |invoice_item| invoice_item.invoice_id == "#{invoice_id}" }
  end

  def find_all_by_quantity(quantity)
    @invoice_items.find_all { |invoice_item| invoice_item.quantity == "#{quantity}" }
  end

  def find_all_by_unit_price(unit_price)
    @invoice_items.find_all { |invoice_item| invoice_item.unit_price == "#{unit_price}" }
  end

  def find_all_by_created_at(created_at)
    @invoice_items.find_all { |invoice_item| invoice_item.created_at == "#{created_at}" }
  end

  def find_all_by_updated_at(updated_at)
    @invoice_items.find_all { |invoice_item| invoice_item.updated_at == "#{updated_at}" }
  end
end
