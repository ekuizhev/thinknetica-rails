require_relative 'manufacturer_company'

class Wagon
  include ManufacturerCompany
  attr_reader :type, :number

  def initialize
    raise "You have to create only cargo or passenger class instance!"
  end

  def to_s
    "номер вагона: #{@number}; тип вагона: #{@type};"
  end

  protected

  def validate!
    raise "Number is not be a null!" if @number.empty?
  end

  def passenger?
    @type == "passenger"
  end

  def cargo?
    @type == "cargo"
  end
end
