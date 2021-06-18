require 'minitest/autorun'
require_relative '../models/customer'

class CustomerTests < Minitest::Test
  def test_that_customer_id_cannot_be_negative
    assert_raises ArgumentError do
      @customer = Customer.new(id: -1)
    end
  end

  def test_that_customer_id_must_be_less_than_to_one_million
    assert_raises ArgumentError do
      @customer = Customer.new(id: 1_000_000)
    end
  end

  def test_that_customer_score_cannot_be_negative
    assert_raises ArgumentError do
      @customer = Customer.new(score: -1)
    end
  end

  def test_that_customer_score_must_be_less_than_to_hundred_thousand
    assert_raises ArgumentError do
      @customer = Customer.new(score: 100_001)
    end
  end
end

Minitest.run
