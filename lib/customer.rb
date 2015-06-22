require 'bigdecimal'
require 'bigdecimal/util'

class Customer
  attr_reader :id,
              :first_name,
              :last_name,
              :created_at,
              :updated_at,
              :repository

  def initialize(data, repository)
    @id         = data["id"].to_i
    @first_name = data["first_name"]
    @last_name  = data["last_name"]
    @created_at = data["created_at"]
    @updated_at = data["updated_at"]
    @repository = repository
  end

  def invoices
    repository.find_invoices(id)
  end

  def transactions
    invoices.map(&:transactions).flatten
  end

  def successful_invoices
    invoices.select(&:successful?)
  end

  def favorite_merchant
    grouped_invoices = successful_invoices.group_by(&:merchant_id)
    merchant_id = grouped_invoices.map do |merchant_id, invoices|
      [invoices.size, merchant_id]
    end.sort[-1][1]
    repository.find_merchant(merchant_id)
  end

end