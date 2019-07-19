class Route
  attr_reader :stations

  def initialize(source, destination)
    @stations = [source, destination]
  end

  def add(station)
    @stations.insert(-2, station)
  end

  def remove(station)
    @stations.delete(station)
  end

  def show_stations
    @stations.each {|station| puts station.name}
  end
end
