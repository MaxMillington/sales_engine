require 'bigdecimal'
require 'bigdecimal/util'

class Invoice
  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at,
              :repository

  def initialize(data, repository)
    @id           = data["id"].to_i
    @customer_id  = data["customer_id"].to_i
    @merchant_id  = data["merchant_id"]
    @status       = data["status"]
    @created_at   = data["created_at"]
    @updated_at   = data["updated_at"]
    @repository   = repository
  end

  def customer
    repository.find_customer(customer_id)
  end

  def merchant
    repository.find_merchant(merchant_id)
  end

  def items
    repository.find_items(id)
  end

  def transactions
    repository.find_transactions(id)
  end

  def invoice_items
    repository.find_invoice_items(id)
  end

  def successful?
    transactions.any? { |t| t.successful? }
  end

  def revenue
    total = invoice_items.map(&:revenue).reduce(:+) if successful?
    total ? total : 0
  end

  def quantity
    total = invoice_items.map(&:quantity).reduce(:+) if successful?
    total ? total : 0
  end

  def charge(data)
    repository.charge(data, id)
  end

end