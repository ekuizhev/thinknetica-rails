require_relative 'train'

class CargoTrain < Train
  def initialize(number, wagons = [])
    @number = number
    @type = "cargo"
    @wagons = wagons
    @speed = 0
    @route = nil
    validate!
  end
end
