require 'bigdecimal'
require 'bigdecimal/util'


class Merchant
  attr_reader :id,
              :name,
              :created_at,
              :updated_at,
              :repository

  def initialize(data, repository)
    @id = data['id']
    @name = data['name']
    @created_at = data['created_at']
    @updated_at = data['updated_at']
    @repository = repository
  end

  def items
    repository.find_items(id)
  end

  def invoices
    repository.find_invoices(id)
  end

  def revenue(date=nil)
    if date.nil?
      invoices.map { |invoice| invoice.revenue}.reduce(:+)
    else
      revenue_by_date(date)
    end
  end

  def revenue_by_date(date)
    invoices_for_date = invoices.find_all do |invoice|
      Date.parse(invoice.created_at[0..9]) == date
    end
    invoices_for_date.map(&:revenue).reduce(:+)
  end

  def successful_invoices
    invoices.find_all(&:successful?)
  end

  def success_invoice_by_customer_id
    successful_invoices.group_by(&:customer_id)
  end

  def worst_to_best_customer
    success_invoice_by_customer_id.map do |customer_id, invoices|
      [invoices.size, customer_id]
    end
  end

  def favorite_customer
    favorite = worst_to_best_customer.sort_by(&:first).last
    favorite_id = favorite.last
    repository.find_customer(favorite_id)
  end

  def customers_with_pending_invoices
    customer_ids = unsuccessful_invoices.map(&:customer_id).uniq
    customer_ids.map { |id| repository.find_customer(id) }
  end

  def unsuccessful_invoices
    invoices.select do |invoice|
      invoice.successful? == false
    end
  end

end