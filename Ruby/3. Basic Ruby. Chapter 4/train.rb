class Train
  attr_reader :speed, :wagon_count, :type
  MAX_SPEED = 220

  def initialize(number, type, wagons_count)
    @number = number
    @type = type
    @wagon_count = wagons_count
    @speed = 0
  end

  def stop
    @speed = 0
  end

  def change_speed(speed)
    return if @speed + speed > MAX_SPEED

    @speed += speed
    @speed = 0 if speed.negative?
  end

  def add_wagon
    @wagon_count += 1 if @speed.zero?
  end

  def remove_wagon
    @wagon_count -= 1 if @wagon_count.positive? && @speed.zero?
  end

  def current_station
    @route.stations[@current_station_index]
  end

  def previous_station
    return unless @current_station_index.positive?

    @route.stations[@current_station_index - 1]
  end

  def next_station
    @route.stations[@current_station_index + 1]
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
end
