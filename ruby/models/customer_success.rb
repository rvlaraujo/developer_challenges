class CustomerSuccess
  attr_accessor :id, :score, :customers

  def initialize(id, score, customers=0)
    @id = id
    @score = score
    @customers = 0
  end

  def add_customer
    @customers += 1
  end

  def to_hash
    instance_variables.map do |attribute|
      [attribute[1..-1].to_sym, instance_variable_get(attribute)]
    end.to_h
  end
end
