class Train
  attr_reader :speed, :wagon_count, :type

  def initialize(number, type, wagons_count)
    @number = number
    @type = type
    @wagon_count = wagons_count
    @speed = 0
    @route = nil
    @current_station = nil
  end

  def stop
    @speed = 0
  end

  def start
    @speed = 60
  end

  def add_wagon
    @wagon_count += 1 if @speed > 0
  end

  def remove_wagon
    @wagon_count -= 1 if @wagon_count > 0 && @speed > 0
  end

  def set_route(route)
    @route = route
    first_statin = @route.stations.first
    first_statin.arrive_train(self)
    @current_station = first_statin
  end

  def go_to_next_station
    return if @route.nil? || @current_station.nil?

    station_index = @route.stations.index(@current_station)
    next_station = @route.stations[station_index + 1]

    return if next_station.nil?
    @current_station.depart_train(self)
    @current_station = next_station
    @current_station.arrive_train(self)
  end

  def go_to_prev_station
    return if @route.nil? || @current_station.nil?
    
    station_index = @route.stations.index(@current_station)
    prev_station = @route.stations[station_index - 1]

    return if prev_station.nil?
    @current_station.depart_train(self)
    @current_station = prev_station
    @current_station.arrive_train(self)
  end

  def show_station
    return if @route.nil? || @current_station.nil?

    station_index = @route.stations.index(@current_station)
    next_station = @route.stations[station_index + 1]
    prev_station = @route.stations[station_index - 1]

    puts "Current station is #{@current_station.name}"
    puts "Next station is #{next_station.name}" unless next_station.nil?
    puts "Previous station is #{prev_station.name}" unless prev_station.nil?
  end
end
