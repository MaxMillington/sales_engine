require 'csv'
require_relative 'invoice_item'
require 'bigdecimal'
require 'bigdecimal/util'


class InvoiceItemRepository
  attr_reader :invoice_items, :sales_engine

  def initialize(sales_engine, data)
    @invoice_items = data.map {|entry| InvoiceItem.new(entry, self)}
    @sales_engine = sales_engine
  end

  def inspect
    "#<#{self.class} #{@invoice_items.size} rows>"
  end

  def find_invoice(invoice_id)
    sales_engine.find_invoice_by_id(invoice_id)
  end

  def find_item(item_id)
    sales_engine.find_item_by_id(item_id)
  end

  def create(data, invoice_id)
    result = data[:items].map do |item|
      new_invoice_item = InvoiceItem.new({"id" => next_id,
                                         "item_id" => item.id,
                                         "invoice_id" => invoice_id,
                                         "quantity" => 1,
                                         "unit_price" => item.unit_price,
                                         "created_at" => item.created_at,
                                         "updated_at" => item.updated_at},
                                         self)
      @invoice_items << new_invoice_item
      # new_invoice_item
      # require 'pry'; binding.pry
    end
  end

  def next_id
    largest_id_number = invoice_items.sort_by {|item| item.id}.last.id
    largest_id_number + 1
  end

  def all
    @invoice_items
  end

  def random
    @invoice_items.shuffle.first
  end

  def find_by_id(id)
    @invoice_items.find { |invoice_item| invoice_item.id == id }
  end

  def find_by_item_id(item_id)
    @invoice_items.find { |invoice_item| invoice_item.item_id == "#{item_id}" }
  end

  def find_by_invoice_id(invoice_id)
    @invoice_items.find { |invoice_item| invoice_item.invoice_id == invoice_id }
  end

  def find_by_quantity(quantity)
    @invoice_items.find { |invoice_item| invoice_item.quantity == quantity }
  end

  def find_by_unit_price(unit_price)
    @invoice_items.find { |invoice_item| invoice_item.unit_price == unit_price }
  end

  def find_by_created_at(created_at)
    @invoice_items.find { |invoice_item| invoice_item.created_at == created_at.to_s }
  end

  def find_by_updated_at(updated_at)
    @invoice_items.find { |invoice_item| invoice_item.updated_at == "#{updated_at}" }
  end

  def find_all_by_id(id)
    @invoice_items.find_all { |invoice_item| invoice_item.id == "#{id}" }
  end

  def find_all_by_item_id(item_id)
    @invoice_items.find_all {|invoice_item|invoice_item.item_id=="#{item_id}"}
  end

  def find_all_by_invoice_id(invoice_id)
    @invoice_items.find_all { |invoice_item| invoice_item.invoice_id == invoice_id }
  end

  def find_all_by_quantity(quantity)
    @invoice_items.find_all { |invoice_item| invoice_item.quantity == quantity }
  end

  def find_all_by_unit_price(unit_price)
    @invoice_items.find_all { |invoice_item| invoice_item.unit_price == unit_price }
  end

  def find_all_by_created_at(created_at)
    @invoice_items.find_all do |invoice_item|
      invoice_item.created_at == "#{created_at}"
    end
  end

  def find_all_by_updated_at(updated_at)
    @invoice_items.find_all do |invoice_item|
      invoice_item.updated_at == "#{updated_at}"
    end
  end

  def find_invoice_ids_from_invoices(invoices)
    invoices.map do |invoice|
      invoice.id
    end
  end

  def find_invoice_items_from_ids(invoices)
    find_invoice_ids_from_invoices(invoices).flat_map do |invoice_id|
      find_all_by_invoice_id(invoice_id)
    end
  end

end