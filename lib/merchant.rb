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

  # def revenue(date = nil)
  #   repository.total_revenue_for_a_merchant(id, date)
  # end

  # def merchant_revenue_by_id
  #   repository.find_revenue_by_id(id)
  # end
  #
  # def merchant_revenue(date)
  #   date = date.to_s
  #   repository.find_revenue_by_id_by_date(id, date)
  # end

end