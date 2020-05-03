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

  def valid?
    validate!
    true
  rescue
    false
  end

  private

  def validate!
    raise RuntimeError.new("Number is not be a null!") if @number.nil? || @number.empty?
    raise RuntimeError.new("Source is not be a null!") if @source.nil? || @source.empty?
    raise RuntimeError.new("Destination is not be a null!") if @destination.nil? || @destination.empty?
  end
end
