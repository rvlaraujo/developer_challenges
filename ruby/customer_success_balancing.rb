require_relative 'models/customer_success'
require_relative 'models/customer'

class CustomerSuccessBalancing
  # receive two maps and 1 array
  def initialize(customer_success, customers, customer_success_away)
    @customer_success = customer_success
    @customers = customers
    @customer_success_away = customer_success_away
  end

  # Returns the id of the CustomerSuccess with the most customers
  def execute
    # Write your solution here
    # 1st Checking the condition t=n/2 rounded down. If not satisfied, return 0
    if @customer_success_away.size <= (@customer_success.size / 2).floor
      # 2nd Remove Away Success Customers from original list
      @available_customer_successes = []
      @customer_success.each do |cs|
        unless @customer_success_away.include?(cs[:id])
          @available_customer_successes.push(CustomerSuccess.new(id=cs[:id], score=cs[:score]))
        end
      end
      # 3rd Order CustomerSucces by score and Customer by size)
      # @available_customer_successes = @available_customer_successes.sort_by { |customer_succes| customer_succes[:score] }
      @available_customer_successes = @available_customer_successes.sort_by(&:score)
      @customers = @customers.sort_by { |customer| customer[:score] }
      # 4th Scroll through the customer hash by size, and assign the closest-score CustmomerSuccess.
      @customers.each do |customer|
        @available_customer_successes.each do |available_customer_success|
          # if customer[:score] <= available_customer_success.score ? next : available_customer_success.add_customer
          if customer[:score] <= available_customer_success.score
            next
          else
            available_customer_success.add_customer
          end
        end
      end

      # 5th Sort Customer Successes by the size of your Customer hash. If there is a tie between the first, return 0
      # @available_customer_successes = @available_customer_successes.sort_by { |customer_succes| customer_succes[:customers]}.reverse!
      @available_customer_successes.sort_by(&:customers).reverse!
      if @available_customer_successes.size == 0
        return 0
      elsif @available_customer_successes.size < 2
        return @available_customer_successes[0].id
      elsif @available_customer_successes[0].id == @available_customer_successes[1].id
        return 0
      else
        return @available_customer_successes[0].id
      end
    end
    return 0
  end
end
