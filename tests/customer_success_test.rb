require 'minitest/autorun'
require_relative '../models/customer_success'

class CustomerSuccessTests < Minitest::Test
  def test_that_customer_success_id_cannot_be_negative
    assert_raises ArgumentError do
      @customer_success = CustomerSuccess.new(id: -1)
    end
  end

  def test_that_customer_success_id_must_be_less_than_to_thousand
    assert_raises ArgumentError do
      @customer_success = CustomerSuccess.new(id: 1_000)
    end
  end

  def test_that_customer_success_score_cannot_be_negative
    assert_raises ArgumentError do
      @customer_success = CustomerSuccess.new(score: -1)
    end
  end

  def test_that_customer_success_score_must_be_less_than_to_ten_thousand
    assert_raises ArgumentError do
      @customer_success = CustomerSuccess.new(score: 100_000)
    end
  end
end

Minitest.run
