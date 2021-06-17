require 'timeout'
require 'minitest/autorun'
require './customer_success_balancing'

class CustomerSuccessBalancingTests < Minitest::Test
  # Scenario where all parameters are tightly controlled
  def test_scenario_one
    customer_successes = [{ id: 1, score: 60 }, { id: 2, score: 20 }, { id: 3, score: 95 }, { id: 4, score: 75 }]
    customers = [{ id: 1, score: 90 }, { id: 2, score: 20 }, { id: 3, score: 70 }, { id: 4, score: 40 }, { id: 5, score: 60 }, { id: 6, score: 10}]
    customer_success_away = [2, 4]

    balancer = CustomerSuccessBalancing.new(customer_successes, customers, customer_success_away)
    assert_equal 1, balancer.execute
  end

  # Scenario where there is a tie between two CustomerSuccesses
  def test_scenario_two
    customer_successes = array_to_map([11, 21, 31, 3, 4, 5])
    customers = array_to_map([10, 10, 10, 20, 20, 30, 30, 30, 20, 60])
    balancer = CustomerSuccessBalancing.new(customer_successes, customers, [])
    assert_equal 0, balancer.execute
  end

  # All Sustomers has the same score and the CustomerSuccess with the highest score is unavailable.
  def test_scenario_three
    customer_success = (1..999).to_a
    customers = Array.new(10000, 998)

    balancer = CustomerSuccessBalancing.new(array_to_map(customer_success), array_to_map(customers), [999])

    result = Timeout.timeout(1.0) { balancer.execute }
    assert_equal 998, result
  end

  # Scenario where has tie between Customer Balancing
  def test_scenario_four
    balancer = CustomerSuccessBalancing.new(array_to_map([1, 2, 3, 4, 5, 6]), array_to_map([10, 10, 10, 20, 20, 30, 30, 30, 20, 60]), [])
    assert_equal 0, balancer.execute
  end

  # Scenario where the first CustomerSucces has all customers
  def test_scenario_five
    balancer = CustomerSuccessBalancing.new(array_to_map([100, 2, 3, 3, 4, 5]), array_to_map([10, 10, 10, 20, 20, 30, 30, 30, 20, 60]), [])
    assert_equal 1, balancer.execute
  end

  # Scenario where the score of available CustomerSuccess is lower than the score of all Customer
  def test_scenario_six
    balancer = CustomerSuccessBalancing.new(array_to_map([100, 99, 88, 3, 4, 5]), array_to_map([10, 10, 10, 20, 20, 30, 30, 30, 20, 60]), [1, 3, 2])
    assert_equal 0, balancer.execute
  end

  def test_scenario_seven
    balancer = CustomerSuccessBalancing.new(array_to_map([100, 99, 88, 3, 4, 5]), array_to_map([10, 10, 10, 20, 20, 30, 30, 30, 20, 60]), [4, 5, 6])
    assert_equal 3, balancer.execute
  end

  def array_to_map(arr)
    out = []
    arr.each_with_index { |score, index| out.push({ id: index + 1, score: score }) }
    out
  end
end

Minitest.run
