require_relative 'item_repository'
require_relative 'merchant_repository'
require_relative 'transaction_repository'
require_relative 'invoice_repository'
require_relative 'invoice_item_repository'
require_relative 'customer_repository'



class CSVParser

  def self.create_merchant_repo(sales_engine, filepath)
    MerchantRepository.new(sales_engine, load_merchant_data(filepath))
  end

  def self.create_item_repo(sales_engine, filepath)
    ItemRepository.new(sales_engine, load_item_data(filepath))
  end

  def self.create_transaction_repo(sales_engine, filepath)
    TransactionRepository.new(sales_engine, load_transaction_data(filepath))
  end

  def self.create_invoice_repo(sales_engine, filepath)
    InvoiceRepository.new(sales_engine, load_invoice_data(filepath))
  end

  def self.create_invoice_item_repo(sales_engine, filepath)
    InvoiceItemRepository.new(sales_engine, load_invoice_item_data(filepath))
  end

  def self.create_customer_repo(sales_engine, filepath)
    CustomerRepository.new(sales_engine, load_customer_data(filepath))
  end

  private

  def self.load_merchant_data(filepath)
    CSV.read("#{filepath}/merchants.csv", headers: true)
  end

  def self.load_item_data(filepath)
    CSV.read("#{filepath}/items.csv", headers: true)
  end

  def self.load_transaction_data(filepath)
    CSV.read("#{filepath}/transactions.csv", headers: true)
  end

  def self.load_invoice_data(filepath)
    CSV.read("#{filepath}/invoices.csv", headers: true)
  end

  def self.load_invoice_item_data(filepath)
    CSV.read("#{filepath}/invoice_items.csv", headers: true)
  end

  def self.load_customer_data(filepath)
    CSV.read("#{filepath}/customers.csv", headers: true)
  end

end