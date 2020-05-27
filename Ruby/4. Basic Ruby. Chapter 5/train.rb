require_relative 'manufacturer_company'
require_relative 'instance_counter'

class Train
  include InstanceCounter
  include ManufacturerCompany
  attr_reader :number, :speed, :wagons, :type

  MAX_SPEED = 220
  ALLOWED_TYPES = %w[cargo passenger].freeze
  NUMBER_FORMAT = /^[\da-z]{3}(-[\da-z]{2})?$/i.freeze

  def initialize
    raise "You have to create only cargo or passenger class instance!"
  end

  def to_s
    "Номер поезда: #{@number}, тип: #{@type}, кол-во вагонов: \
    #{@wagons.count}; станция: #{current_station&.name};"
  end

  def stop
    @speed = 0
  end

  def change_speed(speed)
    return if @speed + speed > MAX_SPEED

    @speed += speed
    @speed = 0 if speed.negative?
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

  def assign_route(route)
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
    instances.find { |train| train.number == number }
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  def add_wagon(wagon)
    return if @wagons.include?(wagon) || @type != wagon.type

    @wagons << wagon
  end

  def remove_wagon(wagon)
    @wagons.delete(wagon) unless @type == wagon.type
  end

  def each_wagon
    raise "Block not given" unless block_given?

    @wagons.each { |wagon| yield(wagon) }
  end

  protected

  def validate!
    raise TypeError.new("Train type is not allowed!", @type) if type_invalid?
    raise "Number format is not allowed!" if @number !~ NUMBER_FORMAT
  end

  def type_invalid?
    !ALLOWED_TYPES.include?(@type)
  end

  def passenger?
    @type == "passenger"
  end

  def cargo?
    @type == "cargo"
  end
end
