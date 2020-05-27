module RailRoadModificateCategory
  def handle_modification_category
    arguments = @config[:arguments]
    return set_config_message(arguments.join(" "), :warning) if arguments[1].nil?

    action = RailRoadInterfaceConstant::CATEGORY_ACTIONS[:modification][arguments[0]]

    begin
      send(action)
    rescue NoMethodError
      set_config_message(arguments.join(" "), :warning)
    end
  end

  def add_station_to_route
    route, station = find_route_and_station
    return if route.nil? || station.nil?

    is_ok = route.add(station)

    return set_config_message("Станция успешно добавлена в маршрут!") if is_ok

    set_config_message("Станция не заданна или уже существует!", :warning)
  end

  def remove_station_from_route
    route, station = find_route_and_station
    return if route.nil? || station.nil?

    is_ok = route.remove(station)

    return set_config_message("Станция успешно удалена из маршрута!") if is_ok

    message = "Не удалось удалить станцию из маршрута, "
    message += "возможно, вы пытаетесь удались начальную или конечную!"
    set_config_message(message, :warning)
  end

  def assign_route_to_train
    _, route_number, train_number = @config[:arguments]

    route = route_by_number(route_number)
    train = train_by_number(train_number)

    if route.nil? || train.nil?
      return set_config_message("Не удалось найти поезд или маршрут!", :warning)
    end

    train.assign_route(route)
    set_config_message("Маршрут успешно установлен!")
  end

  def add_wagon_to_train
    train = train_by_number(@config[:arguments][1])
    return set_config_message("Не удалось найти поезд!", :warning) if train.nil?

    _, _, number, param = @config[:arguments]
    wagon = CargoWagon.new(number, param) if train.cargo?
    wagon = PassengerWagon.new(number, param) if train.passenger?

    train.add_wagon(wagon)
    set_config_message("Вагон успешно добавлен к поезду!")
  end

  def remove_wagon_from_train
    train = train_by_number(@config[:arguments][1])
    return set_config_message("Не удалось найти поезд!", :warning) if train.nil?

    train.remove_last_wagon
    set_config_message("Вагон успешно отцеплен от поезда!")
  end

  def go_to_next_station
    train = train_by_number(@config[:arguments][1])
    return set_config_message("Не удалось найти поезд!", :warning) if train.nil?

    is_ok = train.go_to_next_station
    return set_config_message("Поезд отправился на следующую станцию!") if is_ok

    set_config_message("Маршрут не задан или поезд уже находится на конечной станции!", :warning)
  end

  def go_to_prev_station
    train = train_by_number(@config[:arguments][1])
    return set_config_message("Не удалось найти поезд!", :warning) if train.nil?

    is_ok = train.go_to_prev_station
    return set_config_message("Поезд отправился на предыдущую станцию!") if is_ok

    set_config_message("Маршрут не задан или поезд уже находится на начальной станции!", :warning)
  end

  def occupy_seat_or_volume
    _, train_number, wagon_number = @config[:arguments]

    train = train_by_number(train_number)
    wagon = train_wagon_by_number(train, wagon_number)

    if train.nil? || wagon.nil?
      return set_config_message("Не удалось найти поезд или вагон!", :warning)
    end

    is_ok = wagon.occupy_seat if wagon.passenger?
    is_ok = wagon.occupy_volume(@config[:arguments][3].to_i) if wagon.cargo?
    return set_config_message("Место занято или объем заполнен!") if is_ok

    set_config_message("Не получилось выполнить действие!", :warning)
  end

  def find_route_and_station
    _, route_number, station_name = @config[:arguments]

    route = route_by_number(route_number)
    station = station_by_name(station_name)

    if route.nil? || station.nil?
      set_config_message("Не удалось найти станцию или маршрут!", :warning)
    end

    [route, station]
  end
end
