require 'bigdecimal'
require_relative 'item_repository'
require 'bigdecimal'
require 'bigdecimal/util'

class Item
  attr_reader :id, :name, :description, :unit_price, :merchant_id, :created_at, :updated_at, :repository

  def initialize(data, repository)
    @id = data["id"]
    @name = data["name"]
    @description = data["description"]
    @unit_price = data["unit_price"]
    @merchant_id = data["merchant_id"]
    @created_at = data["created_at"]
    @updated_at = data["updated_at"]
    @repository = repository
  end

  def invoice_items
    repository.find_invoice_item(id)
  end

  def merchant
    repository.find_merchant(merchant_id)
  end


end
