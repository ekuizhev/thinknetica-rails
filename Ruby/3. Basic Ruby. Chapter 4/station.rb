class Station
  attr_reader :trains, :name

  def initialize(name)
    @name = name
    @trains = []
  end

  def trains_by_type(type)
    @trains.select { |train| train.type == type }
  end

  def arrive_train(train)
    @trains << train
  end

  def depart_train(train)
    @trains.delete(train)
  end
end
