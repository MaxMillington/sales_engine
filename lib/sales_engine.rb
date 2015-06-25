require 'csv'
require_relative 'csv_parser'
require_relative 'merchant'
require_relative 'merchant_repository'
require_relative 'customer'
require_relative 'customer_repository'
require_relative 'transaction'
require_relative 'transaction_repository'
require_relative 'invoice'
require_relative 'invoice_repository'
require_relative 'invoice_item'
require_relative 'invoice_item_repository'
require_relative 'item'
require_relative 'item_repository'

class SalesEngine

  attr_reader :item_repository,
              :merchant_repository,
              :transaction_repository,
              :invoice_item_repository,
              :invoice_repository,
              :customer_repository

  def initialize(filepath = "./data")
    @filepath = filepath
    @item_repository
    @merchant_repository
    @transaction_repository
    @invoice_repository
    @invoice_item_repository
    @customer_repository
  end

  def startup
    @merchant_repository = CSVParser.create_merchant_repo(self, @filepath)
    @item_repository = CSVParser.create_item_repo(self, @filepath)
    @transaction_repository = CSVParser.create_transaction_repo(self, @filepath)
    @invoice_repository = CSVParser.create_invoice_repo(self, @filepath)
    @invoice_item_repository=CSVParser.create_invoice_item_repo(self, @filepath)
    @customer_repository = CSVParser.create_customer_repo(self, @filepath)
  end

  def find_customer_by_id(customer_id)
    customer_repository.find_by_id(customer_id)
  end

  def find_merchant_by_id(merchant_id)
    merchant_repository.find_by_id(merchant_id)
  end

  def find_invoice_item_by_id(item_id)
    invoice_item_repository.find_all_by_item_id(item_id)
  end

  def find_invoice_by_id(invoice_id)
    invoice_repository.find_by_id(invoice_id)
  end

  def find_invoices_by_customer_id(customer_id)
    invoice_repository.find_all_by_customer_id(customer_id)
  end

  def find_item_by_id(item_id)
    item_repository.find_by_id(item_id)
  end

  def find_items_by_id(id)
    item_repository.find_all_by_id(id)
  end

  def find_items_by_merchant_id(merchant_id)
    item_repository.find_all_by_merchant_id(merchant_id)
  end

  def find_invoices_by_id(id)
    invoice_repository.find_all_by_id(id)
  end

  def find_invoices_by_merchant_id(merchant_id)
    invoice_repository.find_all_by_merchant_id(merchant_id)
  end

  def find_items_by_invoice_id(invoice_id)
    invoice_item_repository.find_all_by_invoice_id(invoice_id)
  end

  def find_transactions_by_invoice_id(invoice_id)
    transaction_repository.find_all_by_invoice_id(invoice_id)
  end

  def find_invoice_items_by_invoice_id(invoice_id)
    invoice_item_repository.find_all_by_invoice_id(invoice_id)
  end

  def find_successful_invoices(invoices)
    invoices.select {|invoice| invoice.successful?}
  end

  def successful_invoice?(invoice_id)
    transactions = transaction_repository.find_all_by_invoice_id(invoice_id)
    transactions.any? do |transaction|
      transaction.result == "success"
    end
  end

  def add_items(items, invoice_id)
    invoice_item_repository.add_items(items, invoice_id)
  end

  def create_invoice_items(data, invoice_id)
    invoice_item_repository.create(data, invoice_id)
  end

end
