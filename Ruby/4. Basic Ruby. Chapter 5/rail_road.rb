class RailRoad
  attr_reader :stattions, :trains, :routes, :wagons
  @@menu = [
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
      Введете 2 <номер поезда> <тип поезда>, чтобы создать поезд
      Введите 3 <номер маршрута> <имя станции отправления> <имя станции назначения>, чтобы создать маршрут
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
      Введите 4 <номер поезда>, чтобы добавить вагон к поезду
      Введите 5 <номер поезда>, чтобы отцепить вагон от поезда
      Введите 6 <номер поезда>, чтобы отправиться по маршруту к следующей станции
      Введите 7 <номер поезда>, чтобы вернуться по маршруту к предыдущей станции
      Введите menu, чтобы выйти в главное меню
      Введите 0, чтобы выйти\n\n}.gsub(/[[:blank:]]{2,}/, ""),
    # ------ Отображение ------
    # Просматривать список станций и список поездов на станции
    %{Введите 1, чтобы просмотреть список станций
      Введите 2 <имя станции>, чтобы просмотреть список поездов на станции
      Введите menu, чтобы выйти в главное меню
      Введите 0, чтобы выйти\n\n}.gsub(/[[:blank:]]{2,}/, "")
  ]

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
    @trains << Train.new("111", "cargo")
    @trains.last.set_route(@routes.last)
  end

  def menu
    allowed_categories = [1, 2, 3]
    is_main_menu = true
    sub_menu_number = nil
    message = nil

    loop do
      # очистка консоли
      # system("clear") || system("cls")
      puts message unless message.nil?
      message = nil
      
      # если запрос был из главного меню
      if is_main_menu
        puts @@menu[0]

        user_input = gets.chomp!
        break if user_input == "0"
        
        begin
          user_input = Integer(user_input)
          raise ArgumentError unless allowed_categories.include?(user_input)
          
          sub_menu_number = user_input
          is_main_menu = false
        rescue ArgumentError
          message = warning_command_message(user_input)
        end

        next
      end
      
      # если запрос был не из гланвого меню
      puts @@menu[sub_menu_number]

      user_input = gets.chomp!

      if user_input == "menu"
        is_main_menu = true
        next
      end
      break if user_input == "0"

      commands = user_input.split(" ")
      # Создание станции
      if sub_menu_number == 1 && commands[0] == "1" && !commands[1].nil?
        name = commands[1]
        @stations << Station.new(name)
        message = info_message("Станция была успешно создана!")
      # Создание поезда
      elsif sub_menu_number == 1 && commands[0] == "2" && !commands[1].nil? && Train.allowed_types.include?(commands[2])
        number = commands[1]
        type = commands[2]
        @trains << Train.new(number, type)
        message = info_message("Поезд был успешно создан!")
      # Создание маршрута
      elsif sub_menu_number == 1 && commands[0] == "3" && !commands[1].nil? && !commands[2].nil? && !commands[3].nil?
        route_number = commands[1]
        sourse_station = commands[2]
        destination_station = commands[3]
        @routes << Route.new(route_number, sourse_station, destination_station)
        message = info_message("Маршрут был успешно создан!")
      # Добавить станцию в маршрут
      elsif sub_menu_number == 2 && commands[0] == "1" && !commands[1].nil? && !commands[2].nil?
        route_number = commands[1]
        station_name = commands[2]
        route = @routes.detect { |route| route.number == route_number }
        station = @stations.detect { |station| station.name == station_name }

        if !route.nil? && !station.nil?
          result = route.add(station)
          message = info_message("Станция успешно добавлена в маршрут!") unless result.nil?
          message = warning_message("Не удалось добавить станцию в маршрут!") if result.nil?
        else
          text = "Не удалось найти станцию или маршрут! Или вы пытаетесь добавить станцию, которая уже существует!"
          message = warning_message(text)
        end
      # Удалить станцию из маршрута
      elsif sub_menu_number == 2 && commands[0] == "2" && !commands[1].nil? && !commands[2].nil?
        route_number = commands[1]
        station_name = commands[2]
        route = @routes.detect { |route| route.number == route_number }
        station = @stations.detect { |station| station.name == station_name }

        if !route.nil? && !station.nil?
          result = route.remove(station)
          message = info_message("Станция успешно удалена из маршрута!") unless result.nil?
          message = warning_message("Не удалось удалить станцию из маршрута!") if result.nil?
        else
          text = "Не удалось найти станцию или маршрут!"
          message = warning_message(text)
        end
      # Назначить маршрут поезду
      elsif sub_menu_number == 2 && commands[0] == "3" && !commands[1].nil? && !commands[2].nil?
        route_number = commands[1]
        train_number = commands[2]
        route = @routes.detect { |route| route.number == route_number }
        train = @trains.detect { |train| train.number == train_number }

        if !route.nil? && !train.nil?
          train.set_route(route)
          message = info_message("Маршрут успешно установлен для поезда!")
        else
          text = "Не удалось найти поезд или маршрут!"
          message = warning_message(text)
        end
      # Добавить вагон к поезду
      elsif sub_menu_number == 2 && commands[0] == "4" && !commands[1].nil?
        train_number = commands[1]
        train = @trains.detect { |train| train.number == train_number }

        unless train.nil?
          wagon = Wagon.new(train.type)
          train.add_wagon(wagon)
          message = info_message("Вагон успешно добавлен к поезду!")
        else
          text = "Не удалось найти поезд!"
          message = warning_message(text)
        end
      # Отцепить вагон от поезду
      elsif sub_menu_number == 2 && commands[0] == "5" && !commands[1].nil?
        train_number = commands[1]
        train = @trains.detect { |train| train.number == train_number }

        unless train.nil?
          train.remove_last_wagon
          message = info_message("Вагон успешно отцеплен от поезда!")
        else
          text = "Не удалось найти поезд!"
          message = warning_message(text)
        end
      # Отправить поезд по маршруту к следующей станции
      elsif sub_menu_number == 2 && commands[0] == "6" && !commands[1].nil?
        train_number = commands[1]
        train = @trains.detect { |train| train.number == train_number }
        
        unless train.nil?
          result = train.go_to_next_station
          message = info_message("Поезд отправился на следующую станцию по маршруту!") unless result.nil?
          message = warning_message("Поезд не смог отправиться к следующий станции,"\
            " возможно маршрут не задан или поезд уже находится на конечной станции!") if result.nil?
        else
          text = "Не удалось найти поезд!"
          message = warning_message(text)
        end
      # Отправить поезд по маршруту к следующей станции
      elsif sub_menu_number == 2 && commands[0] == "7" && !commands[1].nil?
        train_number = commands[1]
        train = @trains.detect { |train| train.number == train_number }
        
        unless train.nil?
          result = train.go_to_prev_station
          message = info_message("Поезд отправился на предыдущую станцию по маршруту!") unless result.nil?
          message = warning_message("Поезд не смог отправиться к предыдущей станции,"\
            " возможно маршрут не задан или поезд уже находится на начальной станции!") if result.nil?
        else
          text = "Не удалось найти поезд!"
          message = warning_message(text)
        end
      # Вывод всех станций
      elsif sub_menu_number == 3 && commands[0] == "1"
        puts "\n------------- Станции -------------"
        @stations.each { |station| puts station.name }
        puts "-----------------------------------\n\n"
      # Вывод всех станций
      elsif sub_menu_number == 3 && commands[0] == "2" && !commands[1].nil?
        station_name = commands[1]
        station = @stations.detect { |station| station.name == station_name }

        unless station.nil?
          puts "------ Поезда на станции: #{station_name} ------"
          station.trains.each { |train| puts train.number }
          puts "-----------------------------------\n\n"
        else
          text = "Не удалось найти станцию!"
          message = warning_message(text)
        end
      else
        message = warning_command_message(user_input)
      end
    end
  end

  private
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