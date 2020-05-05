class Route
  attr_reader :stations, :number

  def initialize(number, source, destination)
    @number = number.to_s
    @stations = [source, destination]
  end

  def add(station)
    if station.nil? || @stations.include?(station)
      return puts "Station in null or already exists!"
    end

    @stations.insert(-2, station)
  end

  def remove(station)
    if [@stations.first, @stations.last].include?(station)
      return puts "You can't delete first or last station!"
    end

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

  def station_invalid?(station)
    station.nil? || station.empty?
  end

  private

  def validate!
    raise RuntimeError.new("Number is not be a null!") if @number.empty?
    raise RuntimeError.new("Station is not be a null!") if @stations.any?(&:nil?)
  end
end
