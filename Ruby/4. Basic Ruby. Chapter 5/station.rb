require_relative 'instance_counter'

class Station
  include InstanceCounter
  attr_reader :trains, :name

  def initialize(name)
    @name = name
    @trains = []
    register_instance
  end

  def trains_by_type(type)
    @trains.select { |train| train.type == type }
  end

  def arrive_train(train)
    @trains << train unless @trains.include?(train)
  end

  def depart_train(train)
    @trains.delete(train)
  end

  def self.all
    self.instances
  end
end
