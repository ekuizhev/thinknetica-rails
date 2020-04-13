require_relative 'manufacturer_company'

class Wagon
  include ManufacturerCompany
  attr_reader :type
  ALLOWED_TYPES = ["cargo", "passanger"].freeze

  def initialize(type)
    unless ALLOWED_TYPES.include?(type)
      raise TypeError.new("Allowed types: #{ALLOWED_TYPES.join(', ')}")
    end

    @type = type
  end
end
