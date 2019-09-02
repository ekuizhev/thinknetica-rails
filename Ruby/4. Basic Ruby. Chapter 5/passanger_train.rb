require_relative 'train'

class PassangerTrain < Train
  def add_wagon(wagon)
    unless @wagons.include?(wagon) && @type == wagon.type
      @wagons << wagon 
    end
  end

  def remove_wagon(wagon)
    @wagons.delete(wagon) unless @type == wagon.type
  end
end
