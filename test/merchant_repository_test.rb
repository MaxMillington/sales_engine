require 'minitest/pride'
require 'minitest/autorun'
require_relative '../lib/merchant_repository'

class MerchantRepositoryTest < Minitest::Test
  def test_it_loads_merchants
    skip
    merc = MerchantRepository.new
    merc.load
    assert_equal "blah ", merc.merchants
  end

  def test_all_returns_an_array_of_all_merchants
    skip
    merc = MerchantRepository.new
    merc.load
    assert merc.all
  end

  def test_merchant_person_has_a_name
    merc = MerchantRepository.new
    merc.load
    name = merc.merchants.first.name

    assert_equal "Schroeder-Jerde", name

  end

  def test_random_returns_one_random_merchant_obj
    skip
    merc = MerchantRepository.new
    merc.load
    refute merc.random, merc.random
  end

  def test_find_a_merchant_by_id
    skip
    merc = MerchantRepository.new
    merc.load
    assert_equal "Williamson Group", merc.find_by_id(5)
  end

  def test_find_a_merchant_by_name
    skip
    merc = MerchantRepository.new
    merc.load
    assert_equal "Crona LLC", merc.find_by_name("Crona LLC").name
  end

  def test_it_can_find_by_created_at
    skip
    merc = MerchantRepository.new
    merc.load

  end

  def test_it_can_find_by_updated_at
    skip
    merc = MerchantRepository.new
    merc.load
  end

  def test_find_all_merchants_by_name
    skip
    merc = MerchantRepository.new
    merc.load
    assert_equal 2, merc.find_all_by_name("Williamson Group").size
  end

  def test_it_can_find_all_by_created_at
    skip
    merc = MerchantRepository.new
    merc.load

  end

  def test_it_can_find_all_by_updated_at
    skip
    merc = MerchantRepository.new
    merc.load

  end

end