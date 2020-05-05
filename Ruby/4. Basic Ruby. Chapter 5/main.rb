require_relative "station"
require_relative "route"
require_relative "passenger_wagon"
require_relative "cargo_wagon"
require_relative "passenger_train"
require_relative "cargo_train"
require_relative "rail_road"

rail_road = RailRoad.new
rail_road.seed
rail_road.menu
