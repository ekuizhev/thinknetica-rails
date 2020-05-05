require_relative 'manufacturer_company'

class Wagon
  include ManufacturerCompany
  attr_reader :type, :number

  def initialize
    error_messages = "You have to create only cargo or passenger class instance!"
    raise RuntimeError.new(error_messages)
  end

  def to_s
    "номер вагона: #{@number}; тип вагона: #{@type};"
  end

  protected

  def validate!
    raise RuntimeError.new("Number is not be a null!") if @number.empty?
  end
end
