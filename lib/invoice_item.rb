require 'bigdecimal'
require 'bigdecimal/util'

class InvoiceItem
  attr_reader :id,
              :item_id,
              :invoice_id,
              :quantity,
              :unit_price,
              :created_at,
              :updated_at,
              :repository

  def initialize(data, repository)
    @id         = data["id"]
    @item_id    = data["item_id"]
    @invoice_id = data["invoice_id"]
    @quantity   = data["quantity"]
    @unit_price = data["unit_price"]
    @created_at = data["created_at"]
    @updated_at = data["updated_at"]
    @repository = repository
  end

  def invoice
    repository.find_invoice(invoice_id)
  end

  def item
    repository.find_item(item_id)
  end

  def revenue
    @unit_price.to_i * @quantity.to_i
  end

  def successful?
    invoice.successful?
  end


end