module RailRoadInterfaceConstant
  MENU = {
    main: %(
      Введите 1, чтобы создать станцию, поезд, вагон или маршрут
      Введите 2, чтобы произвести операции с созданными объектами
      Введите 3, чтобы вывести текущие данные о объектах
      Введите exit, чтобы выйти\n\n
    ).gsub(/[[:blank:]]{2,}/, ""),
    creation: %(
      Введете 1 <имя станции>, чтобы создать станцию
      Введете 2 <номер поезда>, чтобы создать грузовой поезд
      Введете 3 <номер поезда>, чтобы создать пассажирский поезд
      Введите 4 <номер маршрута> <станция отправления> <станция назначения>, \
      чтобы создать маршрут
      Введите 0, чтобы выйти в главное меню
      Введите exit, чтобы выйти\n\n
    ).gsub(/[[:blank:]]{2,}/, ""),
    modification: %(
      Введите 1 <номер маршрута> <станция>, чтобы добавить станцию в маршрут
      Введите 2 <номер маршрута> <станция>, чтобы удалить станцию из маршрута
      Введите 3 <номер маршрута> <номер поезда>, чтобы назначить маршрут поезду
      Введите 4 <номер поезда> <номер вагона> <количество мест или вместимый \
      объем (зависит от типа поезда)>, чтобы добавить вагон к поезду
      Введите 5 <номер поезда>, чтобы отцепить вагон от поезда
      Введите 6 <номер поезда>, чтобы отправиться к следующей станции
      Введите 7 <номер поезда>, чтобы вернуться по маршруту к предыдущей станции
      ВВедите 8 <номер поезда> <ноер вагона> <кол-во запоняемого объема или \
      оставьте пустым>, чтобы  заполнить вагон или занять место
      Введите 0, чтобы выйти в главное меню
      Введите 0, чтобы выйти\n\n
    ).gsub(/[[:blank:]]{2,}/, ""),
    showing: %(
      Введите 1, чтобы просмотреть список станций
      Введите 2, чтобы посмотреть список всех поездов
      Введите 3 <имя станции>, чтобы просмотреть список поездов на станции
      Введите 4 <номер поезда>, чтобы посмотреть список вагонов поезда
      Введите 0, чтобы выйти в главное меню
      Введите exit, чтобы выйти\n\n
    ).gsub(/[[:blank:]]{2,}/, "")
  }.freeze

  ALLOWED_CATEGORIES = {
    0 => :main,
    1 => :creation,
    2 => :modification,
    3 => :showing
  }.freeze

  CATEGORY_ACTIONS = {
    creation: {
      "1" => :create_station,
      "2" => :create_cargo_train,
      "3" => :create_passenger_train,
      "4" => :create_route
    },
    modification: {
      "1" => :add_station_to_route,
      "2" => :remove_station_from_route,
      "3" => :assign_route_to_train,
      "4" => :add_wagon_to_train,
      "5" => :remove_wagon_from_train,
      "6" => :go_to_next_station,
      "7" => :go_to_prev_station,
      "8" => :occupy_seat_or_volume
    },
    showing: {
      "1" => :show_all_stations,
      "2" => :show_all_trains,
      "3" => :show_all_station_trains,
      "4" => :show_all_train_wagons
    }
  }.freeze
end