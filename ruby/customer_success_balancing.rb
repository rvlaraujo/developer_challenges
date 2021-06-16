require_relative 'models/customer_success'
require_relative 'models/customer'
require_relative 'modules/recover_models_as_array'
require_relative 'modules/customer_success_balancing_conditions'

class CustomerSuccessBalancing
  include RecoverModelsAsArray
  include CustomerSuccessBalancingConditions

  attr_accessor :customers, :customer_successes, :customer_successes_away, :available_customer_successes

  def initialize(customer_success, customers, customer_successes_away)
    @customer_successes = customer_success
    @customers = customers
    @customer_successeseses_away = customer_successes_away
    @available_customer_successes = []
  end

  def execute
    # Write your solution here
    if minimum_number_of_available_customer_successes
      @available_customer_successes = recover_available_customer_successes_sorted_by_score
      @customers = recover_customers_sorted_by_score
      @available_customer_successes = matching_customers_to_customer_successes.sort_by(&:number_of_customers).reverse!
      return winning_cutomer_success_id
    end
    0
  end

  private

  def matching_customers_to_customer_successes
    @customers.each do |customer|
      @available_customer_successes.each do |available_customer_success|
        if customer.score > available_customer_success.score
          next
        end
        customer.customer_success.nil? ? available_customer_success.add_customer(customer) : next
      end
    end
    @available_customer_successes
  end

  def winning_cutomer_success_id
    @available_customer_successes.size.zero? ? 0 : available_customer_successes_not_empty
  end
end
