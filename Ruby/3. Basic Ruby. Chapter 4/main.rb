require_relative "station"
require_relative "route"
require_relative "train"

slavyansk = Station.new("Slavyansk-on-Kuban")
taganrog = Station.new("Taganrog")
krasnodar = Station.new("Krasnodar")
rostov = Station.new("Rostov")
timashevsk = Station.new("Timashevsk")

route1 = Route.new(slavyansk, taganrog)
route1.add(krasnodar)
route1.add(timashevsk)
route1.add(rostov)
route1.remove(timashevsk)
# route1.show_stations

train1 = Train.new("11111", "cargo", 10)
train1.set_route(route1)
# puts "slavyansk trains: ", slavyansk.trains

train1.go_to_next_station
# puts "slavyansk trains: ", slavyansk.trains
# puts "krasnodar trains: ", krasnodar.trains

puts train1.current_station.name
puts train1.next_station.name
puts train1.previous_station.name


train2 = Train.new("22222", "passenger", 6)
