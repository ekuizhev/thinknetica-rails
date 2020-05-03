require_relative 'manufacturer_company'
require_relative 'instance_counter'

class Train
  include ManufacturerCompany
  include InstanceCounter
  attr_reader :number, :speed, :wagons, :type

  MAX_SPEED = 220.freeze
  ALLOWED_TYPES = ["cargo", "passanger"].freeze
  NUMBER_FORMAT = /^[\da-z]{3}(-[\da-z]{2})?$/i

  def initialize(number, type, wagons = [])
    @number = number
    @type = type
    @wagons = wagons
    @speed = 0
    @route = nil
    validate!
    
    register
  end

  def stop
    @speed = 0
  end

  def change_speed(speed)
    return if @speed + speed > MAX_SPEED
    @speed += speed
    @speed = 0 if speed.negative?
  end

  def add_wagon(wagon)
    @wagons << wagon
  end

  def remove_last_wagon
    @wagons.pop
  end

  def current_station
    @route.stations[@current_station_index] unless @route.nil?
  end

  def previous_station
    return if @route.nil? || @current_station_index < 1
    @route.stations[@current_station_index - 1]
  end
  
  def next_station
    @route.stations[@current_station_index + 1] unless @route.nil?
  end

  def set_route(route)
    @route = route
    @current_station_index = 0
    current_station.arrive_train(self)
  end

  def go_to_next_station
    return if @route.nil? || next_station.nil?

    current_station.depart_train(self)
    next_station.arrive_train(self)
    @current_station_index += 1
  end

  def go_to_prev_station
    return if @route.nil? || previous_station.nil?

    current_station.depart_train(self)
    previous_station.arrive_train(self)
    @current_station_index -= 1
  end

  def self.find(number)
    self.instances.find { |train| train.number == number }
  end

  def valid?
    validate!
    true
  rescue
    false
  end

  protected

  def validate!
    raise TypeError.new("Train type is not allowed!") unless ALLOWED_TYPES.include?(@type)
    raise RuntimeError.new("Number format is not allowed!") if @number !~ NUMBER_FORMAT
  end
end
