require_relative 'manufacturer_company'

class Wagon
  include ManufacturerCompany
  attr_reader :type
  ALLOWED_TYPES = ["cargo", "passanger"].freeze

  def initialize(type)
    @type = type
    validate!
  end

  def valid?
    validate!
    true
  rescue
    false
  end

  private

  def validate!
    raise TypeError.new("Wagon type is not allowed!") unless ALLOWED_TYPES.include?(@type)
  end
end
