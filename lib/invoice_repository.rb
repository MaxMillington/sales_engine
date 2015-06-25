require 'csv'
require_relative 'invoice'
require 'bigdecimal'
require 'bigdecimal/util'

class InvoiceRepository
  attr_reader :invoices, :sales_engine


  def initialize(sales_engine, data)
    @invoices = data.map {|entry| Invoice.new(entry, self)}
    @sales_engine = sales_engine
  end

  def inspect
    "#<#{self.class} #{@invoices.size} rows>"
  end

  def find_customer(customer_id)
    sales_engine.find_customer_by_id(customer_id)
  end

  def find_merchant(merchant_id)
    sales_engine.find_merchant_by_id(merchant_id)
  end

  def invoice_items(invoice_id)
    sales_engine.invoice_item_repository.find_all_by_invoice_id(invoice_id)
  end

  def find_items(id)
    item_id_list = invoice_items(id).map { |x| x.item_id.to_i }
    items = item_id_list.map do |id|
      sales_engine.find_items_by_id(id)
    end
    items.flatten
  end

  def find_transactions(id)
    sales_engine.find_transactions_by_invoice_id(id)
  end

  def find_invoice_items(id)
    sales_engine.find_invoice_items_by_invoice_id(id)
  end

  def create(data)
    date = Time.now.strftime('%Y-%m-%d %H:%M:%S UTC')
    new_invoice_data = {"id" => new_number, "customer_id" => data[:customer].id,
                        "merchant_id" => data[:merchant].id, "status" => data[:status], "created_at" => date,
                        "updated_at" => date}
    new_invoice = Invoice.new(new_invoice_data, self)
    @invoices << new_invoice
    sales_engine.create_invoice_items(data, new_invoice.id)
    new_invoice
  end

  def new_number
    largest_id_number = invoices.sort_by {|invoice| invoice.id}.last.id
    largest_id_number + 1
  end

  def charge(data)
    sales_engine.transaction_repository
        .create(credit_card_number, credit_card_expiration, result, id, date)
  end

  def all
    @invoices
  end

  def random
    @invoices.shuffle.first
  end

  def find_by_id(id)
    @invoices.find { |invoice| invoice.id == id.to_i }
  end

  def find_all_by_id(id)
    @invoices.find_all { |invoice| invoice.id == id.to_i }
  end

  def find_by_customer_id(customer_id)
    @invoices.find { |invoice| invoice.customer_id.to_i == customer_id.to_i }
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
    @invoices.find_all { |invoice| invoice.customer_id == customer_id.to_i }
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

  def successful?(invoice_id)
    sales_engine.successful_invoice?(invoice_id)
  end

end