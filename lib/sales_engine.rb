require 'csv'
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

  attr_reader :item_repository, :merchant_repository, :transaction_repository,
              :invoice_item_repository, :invoice_repository, :customer_repository


  def initialize
    @item_repository = ItemRepository.new(self)
    @merchant_repository = MerchantRepository.new(self)
    @transaction_repository = TransactionRepository.new(self)
    # @invoice_repository = InvoiceRepository.new(self)
    # @invoice_item_repository = InvoiceItemRepository.new(self)
    # @customer_repository = CustomerRepository.new(self)
  end

  def start_up
    #fill_item_repository
    #fill_merchant_repository
    #fill_transaction_repository
    #fill_invoice_repository
    #fill_invoice_item_repository
    #fill_customer_repository
  end

  def fill_item_repository
    @item_repository
  end

  def fill_merchant_repository
    @merchant_repository
  end

  def fill_transaction_repository
    @transaction_repository
  end

  def fill_invoice_repository
    @invoice_repository
  end

  def fill_invoice_item_repository
    @invoice_item_repository
  end

  def fill_customer_repository
    @customer_repository
  end

end
