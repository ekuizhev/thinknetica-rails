require_relative 'train'

class PassangerTrain < Train
  def initialize(number, wagons = [])
    @number = number
    @type = "passanger"
    @wagons = wagons
    @speed = 0
    @route = nil
  end

  def add_wagon(wagon)
    unless @wagons.include?(wagon) && @type == wagon.type
      @wagons << wagon 
    end
  end

  def remove_wagon(wagon)
    @wagons.delete(wagon) unless @type == wagon.type
  end
end