module CustomerSuccessBalancingConditions
  ## Checking the condition t=n/2 rounded down
  def minimum_number_of_available_customer_successes
    @customer_successeseses_away.size <= (@customer_successes.size / 2).floor
  end

  def available_customer_successes_not_empty
    @available_customer_successes.size < 2 ? @available_customer_successes[0].id : tie_between_two_customer_successes
  end

  def tie_between_two_customer_successes
    @available_customer_successes[0].customers.count == @available_customer_successes[1].customers.count ? 0 : @available_customer_successes[0].id
  end
end