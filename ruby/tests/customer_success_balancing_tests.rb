require 'timeout'
require 'minitest/autorun'
require_relative '../customer_success_balancing'
require_relative '../modules/customer_success_balancing_utils'

class CustomerSuccessBalancingTests < Minitest::Test
  include CustomerSuccessBalancingUtils

  def setup
    @default_success_customers_array = array_to_map([100, 99, 88, 3, 4, 5])
    @default_customers_array = array_to_map([10, 10, 10, 20, 20, 30, 30, 30, 20, 60])
    @default_customers_success_away = []
    @default_balancer = CustomerSuccessBalancing.new(
      @default_success_customers_array, @default_customers_array, @default_customers_success_away
    )
  end

  def test_that_has_array_of_hashes_and_arrays
    customer_successes = [
      { id: 1, score: 60 }, { id: 2, score: 20 }, { id: 3, score: 95 }, { id: 4, score: 75 }
    ]
    customers = [
      { id: 1, score: 90 }, { id: 2, score: 20 }, { id: 3, score: 70 }, { id: 4, score: 40 }, { id: 5, score: 60 }, { id: 6, score: 10}
    ]
    customer_success_away = [2, 4]

    balancer = CustomerSuccessBalancing.new(customer_successes, customers, customer_success_away)
    assert_equal 1, balancer.execute
  end

  def test_that_is_a_tie_beteween_two_customer_successes
    @default_balancer.customer_successes = array_to_map([11, 21, 31, 3, 4, 5])
    assert_equal 0, @default_balancer.execute
  end

  def test_that_all_customer_has_the_same_score_and_the_customer_success_with_the_highest_score_is_unavailable
    customer_success = array_to_map((1..999).to_a)
    customers = array_to_map(Array.new(10_000, 998))
    customer_success_away = [999]

    balancer = CustomerSuccessBalancing.new(customer_success, customers, customer_success_away)
    result = Timeout.timeout(1.0) { balancer.execute }
    assert_equal 998, result
  end

  def test_that_where_no_customer_success_to_attend_the_customers
    @default_balancer.customer_successes = array_to_map((1..6).to_a)
    assert_equal 0, @default_balancer.execute
  end

  def test_that_the_first_customer_success_attend_all_customers
    @default_balancer.customer_successes = array_to_map([100, 2, 3, 3, 4, 5])
    assert_equal 1, @default_balancer.execute
  end

  def test_that_available_customer_successes_scores_is_lower_than_the_all_customers_scores
    customer_success = @default_success_customers_array
    customers = @default_customers_array
    customer_success_away = [1, 3, 2]

    balancer = CustomerSuccessBalancing.new(customer_success, customers, customer_success_away)
    assert_equal 0, balancer.execute
  end

  def test_that_score_of_available_customer_success_greater_than_score_of_all_customers_and_only_one_attend_then
    customer_success = @default_success_customers_array
    customers = @default_customers_array
    customer_success_away = [4, 5, 6]

    balancer = CustomerSuccessBalancing.new(customer_success, customers, customer_success_away)
    assert_equal 3, balancer.execute
  end

  def test_that_maximum_number_of_customer_successes_should_be_less_one_thousand
    @default_balancer.customer_successes = array_to_map((1..1000).to_a)
    assert_equal 0, @default_balancer.execute
  end

  def test_that_maximum_number_of_customers_should_be_less_one_million
    @default_balancer.customers = array_to_map((1..1_000_000).to_a)
    assert_equal 0, @default_balancer.execute
  end
end

Minitest.run
