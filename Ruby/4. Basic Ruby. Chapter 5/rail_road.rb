require_relative 'helpers/rail_road_helpers'
require_relative 'helpers/rail_road_seed'
require_relative 'helpers/rail_road_interface_constant'
require_relative 'helpers/rail_road_creation_category'
require_relative 'helpers/rail_road_modificate_category'
require_relative 'helpers/rail_road_showing_category'

class RailRoad
  include RailRoadHelpers
  include RailRoadSeed
  include RailRoadInterfaceConstant
  include RailRoadCreationCategory
  include RailRoadModificateCategory
  include RailRoadShowingCategory

  attr_reader :stations, :trains, :routes, :wagons

  def initialize(ops = {})
    @stations = ops[:stations] || []
    @trains = ops[:trains] || []
    @routes = ops[:routes] || []
    @wagons = ops[:wagons] || []

    @config = {
      menu: :main,
      message: nil,
      exit: false,
      showed_data: nil,
      arguments: nil
    }
  end

  def menu
    loop do
      clear_console
      show_notification

      break if @config[:exit]

      handle_sub_menu if @config[:menu] != :main
      handle_main_menu if @config[:menu] == :main
    end
  end

  private

  def handle_main_menu
    puts MENU[:main]
    user_input = gets.chomp

    return @config[:exit] = true if user_input == "exit"

    begin
      menu_type = Integer(user_input)
      category = ALLOWED_CATEGORIES[menu_type]
      raise ArgumentError if category.nil?

      @config[:menu] = category
    rescue ArgumentError
      @config[:message] = warning_command_message(user_input)
    end
  end

  def handle_sub_menu
    puts MENU[@config[:menu]]

    begin
      user_input = gets.chomp

      return @config[:exit] = true if user_input == "exit"
      return @config[:menu] = :main if user_input == "0"

      @config[:arguments] = user_input.split(" ")

      handle_user_command
    rescue StandardError => e
      puts warning_message(e.message).chomp
      puts info_message("Try again")
      retry
    end
  end

  def handle_user_command
    send("handle_#{@config[:menu]}_category")
  end

  def clear_console
    system("clear") || system("cls")
  end

  def show_notification
    # puts warning message
    puts @config[:message] unless @config[:message].nil?
    @config[:message] = nil
    # puts data
    puts @config[:showed_data] unless @config[:showed_data].nil?
    @config[:showed_data] = nil
  end

  def set_config_message(message, type = :info)
    return @config[:message] = warning_message(message) if type == :warning

    @config[:message] = info_message(message)
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

  def route_by_number(number)
    @routes.detect { |route| route.number == number }
  end

  def station_by_name(name)
    @stations.detect { |station| station.name == name }
  end

  def train_by_number(number)
    @trains.detect { |train| train.number == number }
  end

  def train_wagon_by_number(train, number)
    return if train.nil?

    train.wagons.detect { |wagon| wagon.number == number }
  end
end
