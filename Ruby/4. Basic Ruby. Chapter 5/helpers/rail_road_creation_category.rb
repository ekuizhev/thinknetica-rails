module RailRoadCreationCategory
  private

  def handle_creation_category
    arguments = @config[:arguments]
    return set_config_message(arguments.join(" "), :warning) if arguments[1].nil?

    action = RailRoadInterfaceConstant::CATEGORY_ACTIONS[:creation][arguments[0]]

    begin
      send(action)
    rescue NoMethodError
      set_config_message(arguments.join(" "), :warning)
    end
  end

  def create_station
    name = @config[:arguments][1]
    @stations << Station.new(name)

    message = "Станция \"#{name}\" была успешно создана!"
    set_config_message(message)
  end

  def create_cargo_train
    number = @config[:arguments][1]
    @trains << CargoTrain.new(number)

    message = "Поезд \"#{number}\" был успешно создан!"
    set_config_message(message)
  end

  def create_passenger_train
    number = @config[:arguments][1]
    @trains << PassengerTrain.new(number)

    message = "Поезд \"#{number}\" был успешно создан!"
    set_config_message(message)
  end

  def create_route
    route_number = @config[:arguments][1]
    sourse_station = @config[:arguments][2]
    destination_station = @config[:arguments][3]
    @routes << Route.new(route_number, sourse_station, destination_station)

    message = "Маршрут \"#{route_number}\" был успешно создан!"
    set_config_message(message)
  end
end
