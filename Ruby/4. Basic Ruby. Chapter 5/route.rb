class Route
  attr_reader :stations, :number

  def initialize(number, source, destination)
    @number = number.to_s
    @stations = [source, destination]
  end

  def add(station)
    return false if station.nil? || @stations.include?(station)

    @stations.insert(-2, station)

    true
  end

  def remove(station)
    return false if [@stations.first, @stations.last].include?(station)

    @stations.delete(station)

    true
  end

  def show_stations
    @stations.each { |station| puts station.name }
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  def station_invalid?(station)
    station.nil? || station.empty?
  end

  private

  def validate!
    raise "Number is not be a null!" if @number.empty?
    raise "Station is not be a null!" if @stations.any?(&:nil?)
  end
end
