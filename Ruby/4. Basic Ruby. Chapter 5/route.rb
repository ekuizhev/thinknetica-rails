class Route
  attr_reader :stations, :number

  def initialize(number, source, destination)
    @number = number
    @stations = [source, destination]
  end

  def add(station)
    return if @stations.include?(station)
    @stations.insert(-2, station)
  end

  def remove(station)
    return if [@stations.first, @stations.last].include?(station)
    
    @stations.delete(station)
  end

  def show_stations
    @stations.each {|station| puts station.name}
  end
end
