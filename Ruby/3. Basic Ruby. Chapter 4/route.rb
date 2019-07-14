class Route
  def initialize(source, destination)
    @source = source
    @destination = destination
    @intermediates = []
  end

  def add(station)
    @intermediates << station
  end

  def remove(station)
    @intermediates.delete(station)
  end

  def show_stations
    [@source, *@intermediates, @destination].each {|r| puts r.name}
  end

  def stations
    [@source, *@intermediates, @destination]
  end
end
