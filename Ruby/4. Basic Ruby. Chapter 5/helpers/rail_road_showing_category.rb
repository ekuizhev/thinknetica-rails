module RailRoadShowingCategory
  def handle_showing_category
    arguments = @config[:arguments]
    action = RailRoadInterfaceConstant::CATEGORY_ACTIONS[:showing][arguments[0]]

    begin
      send(action)
    rescue NoMethodError
      set_config_message(arguments.join(" "), :warning)
    end
  end

  def show_all_stations
    @config[:showed_data] = "\n------------- Станции -------------\n"
    @stations.each { |station| @config[:showed_data] += "#{station.name}\n" }
    @config[:showed_data] += "-----------------------------------\n\n"
  end

  def show_all_trains
    @config[:showed_data] =  "\n---------- Поезда ----------\n"
    @trains.each { |train| @config[:showed_data] += "#{train}\n" }
    @config[:showed_data] += "-----------------------------------\n\n"
  end

  def show_all_station_trains
    station = station_by_name(@config[:arguments][1])
    return set_config_message("Не удалось найти станцию!", :warning) if station.nil?

    @config[:showed_data] = "\n---- Поезда на станции: #{station.name} ----\n"
    station.each_train do |train|
      @config[:showed_data] += "#{train}\n"
    end
    @config[:showed_data] += "-----------------------------------\n\n"
  end

  def show_all_train_wagons
    train = train_by_number(@config[:arguments][1])
    return set_config_message("Не удалось найти поезд!", :warning) if train.nil?

    @config[:showed_data] = "\n------ Вагоны поезда: #{train.number} ------\n"
    train.each_wagon do |wagon|
      @config[:showed_data] += "#{wagon}\n"
    end
    @config[:showed_data] += "-----------------------------------\n\n"
  end
end
