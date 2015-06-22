require 'csv'
require_relative 'merchant'
require_relative '../lib/invoice'
require 'bigdecimal'
require 'bigdecimal/util'


class MerchantRepository
  attr_reader :merchants, :sales_engine

  def initialize(sales_engine, data)
    @merchants = data.map {|entry| Merchant.new(entry, self) }
    @sales_engine = sales_engine
    @revenue = []
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

  def find_items(id)
    sales_engine.find_items_by_merchant_id(id)
  end

  def find_invoices(id)
    sales_engine.find_invoices_by_merchant_id(id)
  end

  def revenue
    @revenue
  end

  def all
    @merchants
  end

  def random
    @merchants.shuffle.first
  end

  def find_by_id(id)
    @merchants.find { |merchant| merchant.id == "#{id}" }
  end

  def find_by_name(name)
    @merchants.find {|merchant| merchant.name == "#{name}"}
  end

  def find_by_created_at(date)
    @merchants.find {|merchant| merchant.created_at == "#{date}"}
  end

  def find_by_updated_at(date)
    @merchants.find {|merchant| merchant.updated_at == "#{date}"}
  end

  def find_all_by_name(name)
    @merchants.find_all {|merchant| merchant.name == "#{name}"}
  end

  def find_all_by_created_at(date)
    @merchants.find_all {|merchant| merchant.created_at == "#{date}"}
  end

  def find_all_by_updated_at(date)
    @merchants.find_all {|merchant| merchant.updated_at == "#{date}"}
  end


  #
  # def find_successful_invoices(merchant_id)
  #   find_invoices(merchant_id).select do |i|
  #     i if sales_engine.invoice_ids_for_successful_transactions.include?(i.id)
  #   end
  # end

  # def most_revenue(x)
  #   invoices = @merchants.map do |merchant|
  #     merchant_id = merchant.id
  #     find_invoices(merchant_id)
  #   end
  #
  #   merchants = []
  #
  #   # hash.values.map {|x| x.reduce(0) {|sum, number| sum + number}}
  #
  #   successful_invoices = invoices.map do |invoice|
  #     if invoice.successful?
  #       merchants << invoice.merchant
  #       invoice
  #     end
  #   end
  #
  #   invoice_items = successful_invoices.compact.map do |invoice|
  #     invoice.invoice_items
  #   end
  #
  #   revenue_arrays = invoice_items.map {|x| x.map{|y| y.quantity.to_i * y.unit_price.to_i}}
  #
  #   total_revenue_by_invoice = revenue_arrays.map do |array|
  #     array.reduce(0) do |sum, number|
  #       sum + number
  #     end
  #   end
  #
  #   stuff = merchants.zip(total_revenue_by_invoice)
  #
  #   sorted_arrays = stuff.sort_by do |element|
  #     element[-1]
  #   end
  #
  #   sorted = sorted_arrays.reverse
  #
  #   # @merchants << sorted
  #
  #   top_merchants = sorted[0...x]
  #
  #   top_merchant_names = top_merchants.map do |merchant|
  #     merchant[0]
  #   end
  # end
end
