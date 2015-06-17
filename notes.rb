class Item

  attr_reader :id, :name, :description, :unit_price, :merchant_id, :created_at, :updated_at, :repository

  def initialize(data, repository)
    @id          = data[:id]
    @name        = data[:name]
    @description = data[:description]
    @unit_price  = data[:unit_price]
    @merchant_id = data[:merchant_id]
    @created_at  = data[:created_at]
    @updated_at  = data[:updated_at]
    @repository  = repository

  end

  def merchant
    repository.find_merchant(merchant_id)
  end

end


class ItemRepository

  attr_reader :sales_engine

  def initialize(rows, sales_engine)
    @sales_engine = sales_engine
  end

  def method_name
    rows.map do |row|
      Item.new(row, self)
    end
  end

  def find_merchant(merchant_id)
    sales_engine.find_merchant(merchant_id)
  end

end


class SalesEngine
  def method_name
    @item_repository = ItemRepository.new(rows, self)
    @customer_repository = CustomerRepository.new(rows, self)
  end

  def find_merchant(merchant_id)
    merchant_repository.find_by_id(merchant_id)
  end


end