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
    raise "Block not given" unless block_given?

    @trains.each { |train| yield(train) }
  end

  def self.all
    instances
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  private

  def validate!
    raise ArgumentError.new("Name is required!", @name) if @name.nil?

    type_err_mess = "Name nust be a string!"
    raise TypeError.new(type_err_mess, @name) unless @name.is_a? String
  end
end
