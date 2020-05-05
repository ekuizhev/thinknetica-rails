require_relative 'train'

class PassengerTrain < Train
  def initialize(number, wagons = [])
    @number = number
    @type = "passenger"
    @wagons = wagons
    @speed = 0
    @route = nil
    validate!
  end
end
