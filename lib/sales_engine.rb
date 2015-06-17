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
require 'pry'

class SalesEngine

  attr_reader :item_repository, :merchant_repository, :transaction_repository,
              :invoice_item_repository, :invoice_repository, :customer_repository

  def initialize
    @item_repository
    @merchant_repository
    @transaction_repository
    # @invoice_repository
    # @invoice_item_repository
    # @customer_repository
  end


  def start_up(filepath = "./data")
    @merchant_repository = CSVParser.create_merchant_repo(self, filepath)
    @item_repository = CSVParser.create_item_repo(self, filepath)
    @transaction_repository = CSVParser.create_transaction_repo(self, filepath)
    # @invoice_repository = CSVParser.create_invoice_repo(self, filepath)
    # @invoice_item_repository = CSVParser.create_invoice_item_repo(self, filepath)
    # @customer_repository = CSVParser.create_customer_repo(self, filepath)
  end

  def find_merchant_by_id(merchant_id)
    merchant_repository.find_by_id(merchant_id)
  end

  def fill_item_repository(filepath)
    @item_repository.load(filepath)
  end

  def fill_merchant_repository(filepath)
    @merchant_repository.load(filepath)
  end

  def fill_transaction_repository(filepath)
    @transaction_repository.load(filepath)
  end

  def fill_invoice_repository(filepath)
    @invoice_repository.load(filepath)
  end

  def fill_invoice_item_repository(filepath)
    @invoice_item_repository.load(filepath)
  end

  def fill_customer_repository(filepath)
    @customer_repository.load(filepath)
  end

end
