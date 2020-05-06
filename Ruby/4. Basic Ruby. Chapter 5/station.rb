require_relative 'instance_counter'

class Station
  include InstanceCounter
  attr_reader :trains, :name

  def initialize(name)
    @name = name
    @trains = []

    register
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

  def each_train
    unless block_given?
      raise RuntimeError.new("Block not given")
    end

    @trains.each { |train| yield(train) }
  end

  def self.all
    self.instances
  end

  def valid?
    validate!
    true
  rescue
    false
  end

  private

  def validate!
    raise RuntimeError.new("Name is not be a null!") if @name.nil? || @name.empty?
  end
end
