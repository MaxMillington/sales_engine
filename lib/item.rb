require 'bigdecimal'
require_relative 'item_repository'
require 'bigdecimal'
require 'bigdecimal/util'

class Item
  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :merchant_id,
              :created_at,
              :updated_at,
              :repository

  def initialize(data, repository)
    @id = data["id"]
    @name = data["name"]
    @description = data["description"]
    @unit_price = BigDecimal.new(data["unit_price"])/100
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

  def successful_invoice_items
    invoice_items.select(&:successful?)
  end

  def success_invoice_items_by_date
    invoice_items.select(&:successful?).group_by do |invoice_item|
      invoice_item.invoice.created_at
    end
  end

  def quantify(invoice_items)
    invoice_items.map(&:quantity).reduce(:+)
  end

  def day_rankings
    success_invoice_items_by_date.map do |date, invoice_items|
      [invoice_items.map(&:quantity).reduce(:+), date_format(date)]
    end
  end

  def date_format(date)
    Date.parse(date)
  end

  def best_day
    best_day = day_rankings.sort_by(&:first)[-1]
    best_day[-1]
  end

  def quantity_of_items
    successful_invoice_items.map(&:quantity)
  end

  def quantity_sold
    quantity_of_items.map(&:to_i).reduce(0, :+)
  end

  def revenue
    successful_invoice_items.map(&:revenue).reduce(0, :+)
  end

end
