require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/sales_engine'
require_relative '../lib/invoice'
require_relative '../lib/invoice_repository'
require 'pry'

class InvoiceTest < Minitest::Test
  def test_it_can_grab_its_repository
    invoice = Invoice.new('rows', 'repository')
    assert_equal 'repository', invoice.repository
  end


end