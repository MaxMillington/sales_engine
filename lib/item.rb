require 'bigdecimal'
require 'pry'
require_relative 'item_repository'

class Item
  attr_reader :id, :name, :description, :unit_price, :merchant_id, :created_at, :updated_at, :repository

  def initialize(id, name, description, unit_price, merchant_id, created_at, updated_at, repository)
    @id = id
    @name = name
    @description = description
    @unit_price = unit_price
    @merchant_id = merchant_id
    @created_at = created_at
    @updated_at = updated_at
    @repository = repository
  end

  def invoice_items

  end

  def merchant(merchant_id)
    repository.find_merchant(merchant_id)
  end


end
