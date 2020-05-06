class RailRoad
  attr_reader :stations, :trains, :routes, :wagons
  MENU = [
    # ------ Основное меню ------
    %{Введите 1, чтобы создать станцию, поезд, вагон или маршрут
      Введите 2, чтобы произвести операции с созданными объектами
      Введите 3, чтобы вывести текущие данные о объектах
      Введите 0, чтобы выйти\n\n}.gsub(/[[:blank:]]{2,}/, ""),
    # ------ Создание ------
    # 1 Создать станции
    # 2 Создать поезда
    # 3 Создать маршруты
    %{Введете 1 <имя станции>, чтобы создать станцию
      Введете 2 <номер поезда>, чтобы создать грузовой поезд
      Введете 3 <номер поезда>, чтобы создать пассажирский поезд
      Введите 4 <номер маршрута> <имя станции отправления> <имя станции назначения>, чтобы создать маршрут
      Введите menu, чтобы выйти в главное меню
      Введите 0, чтобы выйти\n\n}.gsub(/[[:blank:]]{2,}/, ""),
    # ------ Манипуляции ------
    # 1,2 Дабавить или удалить станцию в маршруте
    # 3 Назначить маршрут поезду
    # 4 Добавить вагон к поезду
    # 5 Отцепить вагон от поезда
    # 6,7 Перемещать поезд по маршруту вперед и назад
    %{Введите 1 <номер маршрута> <имя станции>, чтобы добавить станцию в маршрут
      Введите 2 <номер маршрута> <имя станции>, чтобы удалить станцию из маршрута
      Введите 3 <номер маршрута> <номер поезда>, чтобы назначить маршрут поезду
      Введите 4 <номер поезда> <номер вагона> <количество мест или вместимый объем (зависит от типа поезда)>, чтобы добавить вагон к поезду
      Введите 5 <номер поезда>, чтобы отцепить вагон от поезда
      Введите 6 <номер поезда>, чтобы отправиться по маршруту к следующей станции
      Введите 7 <номер поезда>, чтобы вернуться по маршруту к предыдущей станции
      ВВедите 8 <номер поезда> <ноер вагона> <кол-во запоняемого объема или оставьте пустым>, чтобы  заполнить вагон или занять место
      Введите menu, чтобы выйти в главное меню
      Введите 0, чтобы выйти\n\n}.gsub(/[[:blank:]]{2,}/, ""),
    # ------ Отображение ------
    # Просматривать список станций и список поездов на станции
    %{Введите 1, чтобы просмотреть список станций
      Введите 2, чтобы посмотреть список всех поездов
      Введите 3 <имя станции>, чтобы просмотреть список поездов на станции
      Введите 4 <номер поезда>, чтобы посмотреть список вагонов поезда
      Введите menu, чтобы выйти в главное меню
      Введите 0, чтобы выйти\n\n}.gsub(/[[:blank:]]{2,}/, "")
  ].freeze
  ALLOWED_SUB_CATEGORIES = [1, 2, 3].freeze

  def initialize(stations = [], trains = [], routes = [], wagons = [])
    @stations = stations
    @trains = trains
    @routes = routes
    @wagons = wagons
  end

  def seed
    @stations << Station.new("foo")
    @stations << Station.new("bar")
    @routes << Route.new("foobar", @stations.first, @stations.last)
    @stations << Station.new("baz")
    @routes.first.add(@stations.last)
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
    @trains += [cargo_train, passenger_train]
    @trains.last.set_route(@routes.last)
  end

  def menu
    options = {
      main_menu: true,
      sub_menu_number: nil,
      message: nil,
      is_exit: false,
      showed_data: nil
    }

    loop do            
      # работа с подкатегориями
      until options[:main_menu] do
        clear_console
        print_notification(options)

        handle_sub_menu(options)
        break if options[:is_exit]
      end

      # показать главное меню
      if options[:main_menu]
        clear_console
        print_notification(options)

        handle_main_menu(options)
      end

      break if options[:is_exit]  
    end
  end

  private

  def clear_console
    system("clear") || system("cls")
  end

  def print_notification(options)
    # сообщение о проделанной операции или ошибке
    puts options[:message] unless options[:message].nil?
    options[:message] = nil
    # вывод содержимого
    puts options[:showed_data] unless options[:showed_data].nil?
    options[:showed_data] = nil
  end

  def handle_main_menu(options)
    puts MENU[0]
    user_input = gets.chomp
    
    if user_input == "0"
      options[:is_exit] = true and return
    end
    
    begin
      user_input = Integer(user_input)
      raise ArgumentError unless ALLOWED_SUB_CATEGORIES.include?(user_input)
      
      options[:sub_menu_number] = user_input
      options[:main_menu] = false
    rescue ArgumentError
      options[:message] = warning_command_message(user_input)
    end
  end

  def handle_sub_menu(options)
    puts MENU[options[:sub_menu_number]]

    begin
      user_input = gets.chomp
      
      if user_input == "menu"
        options[:main_menu] = true and return
      end
      
      if user_input == "0"
        options[:is_exit] = true and return
      end
      
      has_error = false
      sub_menu_number = options[:sub_menu_number]
      commands = user_input.split(" ")

    
      # если создание
      if sub_menu_number == 1
        command_valid = create(options, commands)
      # если модификация
      elsif sub_menu_number == 2
        command_valid = modificate(options, commands)
      # иначе отображение sub_menu_number == 3
      else
        command_valid = show(options, commands)
      end
    rescue StandardError => e  
      puts warning_message(e.message).chomp
      puts info_message("Try again")
      retry
    end
    
    options[:message] = warning_command_message(user_input) unless command_valid
  end

  def create(options, commands)
    command_valid = true
    # Создание станции
    if commands[0] == "1" && !commands[1].nil?
      name = commands[1]
      @stations << Station.new(name)
      options[:message] = info_message("Станция \"#{name}\" была успешно создана!")
    # Создание грузового поезда
    elsif commands[0] == "2" && !commands[1].nil?
      number = commands[1]
      total_volume = commands[2]
      @trains << CargoTrain.new(number, total_volume)
      
      options[:message] = info_message("Поезд \"#{number}\" был успешно создан!")
    # Создание пассажирского поезда
    elsif  commands[0] == "3" && !commands[1].nil?
      number = commands[1]
      seats_number = commands[2]
      @trains << PassengerTrain.new(number, seats_number)

      options[:message] = info_message("Поезд \"#{number}\" был успешно создан!")
    # Создание маршрута
    elsif commands[0] == "4" && !commands[1].nil? && !commands[2].nil? && !commands[3].nil?
      route_number = commands[1]
      sourse_station = commands[2]
      destination_station = commands[3]
      @routes << Route.new(route_number, sourse_station, destination_station)
      options[:message] = info_message("Маршрут \"#{route_number}\" был успешно создан!")
    else
      command_valid = false
    end

    command_valid
  end

  def modificate(options, commands)
    command_valid = true
    # Добавить станцию в маршрут
    if commands[0] == "1" && !commands[1].nil? && !commands[2].nil?
      route_number = commands[1]
      station_name = commands[2]
      route = @routes.detect { |route| route.number == route_number }
      station = @stations.detect { |station| station.name == station_name }

      if route.nil? || station.nil?
        failure_message = "Не удалось найти станцию или маршрут!"\
        " Или вы пытаетесь добавить станцию, которая уже существует!"
        options[:message] = warning_message(failure_message)
        return false
      end

      result = route.add(station)
      success_message = "Станция успешно добавлена в маршрут!"
      failure_message = "Не удалось добавить станцию в маршрут!"
      options[:message] = info_message(success_message) unless result.nil?
      options[:message] = warning_message(failure_message) if result.nil?
    # Удалить станцию из маршрута
    elsif commands[0] == "2" && !commands[1].nil? && !commands[2].nil?
      route_number = commands[1]
      station_name = commands[2]
      route = @routes.detect { |route| route.number == route_number }
      station = @stations.detect { |station| station.name == station_name }

      if route.nil? || station.nil?
        failure_message = "Не удалось найти станцию или маршрут!"
        options[:message] = warning_message(failure_message)
        return false
      end

      result = route.remove(station)
      success_message = "Станция успешно удалена из маршрута!"
      failure_message = "Не удалось удалить станцию из маршрута!"
      options[:message] = info_message(success_message) unless result.nil?
      options[:message] = warning_message(failure_message) if result.nil?
    # Назначить маршрут поезду
    elsif commands[0] == "3" && !commands[1].nil? && !commands[2].nil?
      route_number = commands[1]
      train_number = commands[2]
      route = @routes.detect { |route| route.number == route_number }
      train = @trains.detect { |train| train.number == train_number }

      if route.nil? || train.nil?
        failure_message = "Не удалось найти поезд \"#{train_number}\" или маршрут \"#{route_number}\"!"
        options[:message] = warning_message(failure_message)
        return false
      end

      train.set_route(route)
      success_message = "Маршрут успешно установлен для поезда \"#{train_number}\"!"
      options[:message] = info_message(success_message)
    # Добавить вагон к поезду
    elsif commands[0] == "4" && !commands[1].nil?
      train_number = commands[1]
      train = @trains.detect { |train| train.number == train_number }

      if train.nil?
        failure_message = "Не удалось найти поезд!"
        options[:message] = warning_message(failure_message)
        return false
      end

      wagon_number = commands[2]
      wagon_parametr2 = commands[3]

      wagon = CargoWagon.new(wagon_number, wagon_parametr2) if train.type == "cargo"
      wagon = PassengerWagon.new(wagon_number, wagon_parametr2) if train.type == "passenger"
      train.add_wagon(wagon)
      success_message = "Вагон успешно добавлен к поезду \"#{train_number}\"!"
      options[:message] = info_message(success_message)
    # Отцепить вагон от поезду
    elsif commands[0] == "5" && !commands[1].nil?
      train_number = commands[1]
      train = @trains.detect { |train| train.number == train_number }

      if train.nil?
        failure_message = "Не удалось найти поезд \"#{train_number}\"!"
        options[:message] = warning_message(failure_message)
        return false
      end

      train.remove_last_wagon
      success_message = "Вагон успешно отцеплен от поезда \"#{train_number}\"!"
      options[:message] = info_message(success_message)
    # Отправить поезд по маршруту к следующей станции
    elsif commands[0] == "6" && !commands[1].nil?
      train_number = commands[1]
      train = @trains.detect { |train| train.number == train_number }
      
      if train.nil?
        failure_message = "Не удалось найти поезд \"#{train_number}\"!"
        options[:message] = warning_message(failure_message)
        return false
      end

      result = train.go_to_next_station
      success_message = "Поезд отправился на следующую станцию по маршруту!"
      failure_message = "Поезд не смог отправиться к следующий станции,"\
        " возможно маршрут не задан или поезд уже находится на конечной станции!"
      options[:message] = info_message(success_message) unless result.nil?
      options[:message] = warning_message(failure_message) if result.nil?
    # Отправить поезд по маршруту к следующей станции
    elsif commands[0] == "7" && !commands[1].nil?
      train_number = commands[1]
      train = @trains.detect { |train| train.number == train_number }
      
      if train.nil?
        failure_message = "Не удалось найти поезд \"#{train_number}\"!"
        options[:message] = warning_message(failure_message)
        return false
      end

      result = train.go_to_prev_station
      success_message = "Поезд отправился на предыдущую станцию по маршруту!"
      failure_message = "Поезд не смог отправиться к предыдущей станции,"\
        " возможно маршрут не задан или поезд уже находится на начальной станции!"
      options[:message] = info_message(success_message) unless result.nil?
      options[:message] = warning_message(failure_message) if result.nil?
    # Запонить объем в вагоне или занять место
    elsif commands[0] == "8" && !commands[1].nil?  && !commands[2].nil?
      train_number = commands[1]
      train = @trains.detect { |train| train.number == train_number }
      wagon_number = commands[2]
      wagon = train.wagons.detect { |wagon| wagon.number == wagon_number } unless train.nil?

      if train.nil? || wagon.nil?
        failure_message = "Не удалось найти вагон \"#{wagon_number}\"!"
        options[:message] = warning_message(failure_message)
        return false
      end

      result = wagon.occupy_seat if wagon.type == "passenger"
      result = wagon.occupy_volume(commands[3].to_i) if wagon.type == "cargo"
      success_message = "Для вагона #{wagon_number} было успешно занято место или заполнен объем!"
      failure_message = "Для вагона #{wagon_number} не получилось выполнить действие!"
      options[:message] = info_message(success_message) unless result.nil?
      options[:message] = warning_message(failure_message) if result.nil?
    else
      command_valid = false
    end

    command_valid
  end

  def show(options, commands)
    command_valid = true
    # Вывод всех станций
    if commands[0] == "1"
      options[:showed_data] = "\n------------- Станции -------------\n"
      @stations.each { |station| options[:showed_data] += "#{station.name}\n" }
      options[:showed_data] += "-----------------------------------\n\n"
    # Вывод всех поездов
    elsif commands[0] == "2"
      options[:showed_data] =  "\n---------- Поезда ----------\n"
      @trains.each { |train| options[:showed_data] += "#{train.to_s}\n" }
      options[:showed_data] += "-----------------------------------\n\n"
    # Вывод всех поездов на станции
    elsif commands[0] == "3" && !commands[1].nil?
      station_name = commands[1]
      station = @stations.detect { |station| station.name == station_name }

      if station.nil?
        failure_message = "Не удалось найти станцию \"#{station_name}\"!"
        options[:message] = warning_message(failure_message)
        return false
      end

      options[:showed_data] =  "\n------ Поезда на станции: #{station_name} ------\n"
      station.each_train do |train|
        options[:showed_data] += "#{train.to_s}\n"
      end
      options[:showed_data] += "-----------------------------------\n\n"
    # Вывод всех вагонов поезда
    elsif commands[0] == "4" && !commands[1].nil?
      train_number = commands[1]
      train = @trains.detect { |train| train.number == train_number }

      if train.nil?
        failure_message = "Не удалось найти поезд \"#{train_number}\"!"
        options[:message] = warning_message(failure_message)
        return false
      end

      options[:showed_data] =  "\n------ Вагоны поезда: #{train_number} ------\n"
      train.each_wagon do |wagon|
        options[:showed_data] += "#{wagon.to_s}\n"
      end
      options[:showed_data] += "-----------------------------------\n\n"
    else
      command_valid = false
    end

    command_valid
  end

  def warning_command_message(command)
    "\n#{red("[WARNNING]")}  Не удалось распознать команду: \"#{command}\"\n\n"
  end

  def warning_message(text)
    "\n#{red("[WARNNING]")}  #{text}\n\n"
  end

  def info_message(text)
    "\n#{green("[INFO]")}  #{text}\n\n"
  end

  def green(allert_type)
    "\033[0;32;40m#{allert_type}\033[0m"
  end

  def red(allert_type)
    "\033[0;31;40m#{allert_type}\033[0m"
  end
end
