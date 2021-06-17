require 'timeout'
require 'minitest/autorun'
require_relative '../customer_success_balancing'
require_relative '../modules/customer_success_balancing_utils'

class CustomerSuccessBalancingTests < Minitest::Test
  include CustomerSuccessBalancingUtils
  
  def setup
    @default_customers_array = [10, 10, 10, 20, 20, 30, 30, 30, 20, 60]
    @default_success_customers_array = [100, 99, 88, 3, 4, 5]
    @default_customers_success_away = []
  end

  # Scenario where all parameters are tightly controlled
  def test_scenario_one
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

  # Scenario where there is a tie between two CustomerSuccesses
  def test_scenario_two
    customer_successes = array_to_map([11, 21, 31, 3, 4, 5])
    customers = array_to_map(@default_customers_array)
    customer_success_away = @default_customers_success_away

    balancer = CustomerSuccessBalancing.new(customer_successes, customers, customer_success_away)
    assert_equal 0, balancer.execute
  end

  # All Customers has the same score and the CustomerSuccess with the highest score is unavailable.
  def test_scenario_three
    customer_success = array_to_map((1..999).to_a)
    customers = array_to_map(Array.new(10_000, 998))
    customer_success_away = [999]

    balancer = CustomerSuccessBalancing.new(customer_success, customers, customer_success_away)
    result = Timeout.timeout(1.0) { balancer.execute }
    assert_equal 998, result
  end

  # Scenario where has tie between Customer Balancing
  def test_scenario_four
    customer_success = array_to_map((1..6).to_a)
    customers = array_to_map(@default_customers_array)
    customer_success_away = @default_customers_success_away

    balancer = CustomerSuccessBalancing.new(customer_success, customers, customer_success_away)
    assert_equal 0, balancer.execute
  end

  # Scenario where the first CustomerSucces has all customers
  def test_scenario_five
    customer_success = array_to_map([100, 2, 3, 3, 4, 5])
    customers = array_to_map(@default_customers_array)
    customer_success_away = @default_customers_success_away

    balancer = CustomerSuccessBalancing.new(customer_success, customers, customer_success_away)
    assert_equal 1, balancer.execute
  end

  # Scenario where the score of available CustomerSuccess is lower than the score of all Customer
  def test_scenario_six
    customer_success = array_to_map(@default_success_customers_array)
    customers = array_to_map(@default_customers_array)
    customer_success_away = [1, 3, 2]

    balancer = CustomerSuccessBalancing.new(customer_success, customers, customer_success_away)
    assert_equal 0, balancer.execute
  end

  # Scenario where the score of available CustomerSuccess is greater than the score of all Customer and only one CustomerSucces attend all Customers
  def test_scenario_seven
    customer_success = array_to_map(@default_success_customers_array)
    customers = array_to_map(@default_customers_array)
    customer_success_away = [4, 5, 6]
    
    balancer = CustomerSuccessBalancing.new(customer_success, customers, customer_success_away)
    assert_equal 3, balancer.execute
  end
end

Minitest.run
