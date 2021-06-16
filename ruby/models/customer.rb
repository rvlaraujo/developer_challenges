require_relative 'customer_success'

class Customer
  attr_accessor :id, :score, :customer_success

  def initialize(id: 0, score: 0)
    @id = id
    @score = score
    @customer_success = nil
  end

  def add_customer_success(customer_success)
    @customer_success = customer_success
  end

  def to_hash
    instance_variables.map do |attribute|
      [attribute[1..-1].to_sym, instance_variable_get(attribute)]
    end.to_h
  end
end