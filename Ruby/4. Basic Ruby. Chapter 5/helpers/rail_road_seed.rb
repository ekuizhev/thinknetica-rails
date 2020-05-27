module RailRoadSeed
  def seed
    run_seeds
  end

  private

  def run_seeds
    @stations << Station.new("foo")
    @stations << Station.new("bar")
    @stations << Station.new("baz")

    seed_routes
  end

  def seed_routes
    @routes << Route.new("foobar", @stations.first, @stations[1])
    @routes.first.add(@stations.last)

    seed_wagons_and_tarins
  end

  def seed_wagons_and_tarins
    cargo_train = CargoTrain.new("111")
    cargo_train.add_wagon(CargoWagon.new(1, 2000))
    c_wagon = CargoWagon.new(2, 2500)
    c_wagon.occupy_volume(800)
    cargo_train.add_wagon(c_wagon)
    passenger_train = PassengerTrain.new("222-dd")
    passenger_train.add_wagon(PassengerWagon.new(1, 45))
    p_wagon = PassengerWagon.new(2, 35)
    p_wagon.occupy_seat
    passenger_train.add_wagon(p_wagon)
    @trains.push(cargo_train, passenger_train)
    @trains.last.assign_route(@routes.last)
  end
end
