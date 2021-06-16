require_relative 'models/customer_success'
require_relative 'models/customer'

class CustomerSuccessBalancing
  attr_accessor :customers, :customer_successes, :customer_successes_away, :available_customer_successes, :customers_objects

  def initialize(customer_success, customers, customer_successes_away)
    @customer_successes = customer_success
    @customers = customers
    @customer_successeseses_away = customer_successes_away
    @available_customer_successes = []
    @customers_objects = []
  end

  def execute
    # Write your solution here
    if minimum_number_of_available_customer_successes
      @available_customer_successes = recover_available_customer_successes
      @customers = recover_customers_objects
      @available_customer_successes = adding_customers_to_their_respectives_customer_successes
      return winning_cutomer_success_id
    end
    0
  end

  private

  ## Checking the condition t=n/2 rounded down
  def minimum_number_of_available_customer_successes
    @customer_successeseses_away.size <= (@customer_successes.size / 2).floor
  end

  def recover_available_customer_successes
    @customer_successes.each do |cs|
      unless @customer_successeseses_away.include?(cs[:id])
        @available_customer_successes.push(CustomerSuccess.new(id: cs[:id], score: cs[:score]))
      end
    end
    @available_customer_successes.sort_by(&:score)
  end

  def recover_customers_objects
    @customers.each do |customer|
      @customers_objects.push(Customer.new(id: customer[:id], score: customer[:score]))
    end
    @customers_objects.sort_by(&:score)
  end

  def adding_customers_to_their_respectives_customer_successes
    @customers.each do |customer|
      @available_customer_successes.each do |available_customer_success|
        if customer.score > available_customer_success.score
          next
        end
        customer.customer_success.nil? ? available_customer_success.add_customer(customer) : next
      end
    end
    @available_customer_successes.sort_by(&:customers_size).reverse!
  end

  def winning_cutomer_success_id
    @available_customer_successes.size.zero? ? 0 : available_customer_successes_not_empty
  end

  def available_customer_successes_not_empty
    @available_customer_successes.size < 2 ? @available_customer_successes[0].id : tie_between_two_customer_successes
  end

  def tie_between_two_customer_successes
    @available_customer_successes[0].customers.count == @available_customer_successes[1].customers.count ? 0 : @available_customer_successes[0].id
  end
end
