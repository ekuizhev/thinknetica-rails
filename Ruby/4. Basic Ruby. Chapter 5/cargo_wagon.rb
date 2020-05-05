require_relative 'wagon'

class CargoWagon < Wagon
  attr_reader :total_volume, :occupied_volume

  DEFAULT_TOTAL_VOLUME = 1500.freeze
  MAX_TOTAL_VOLUME = 3000.freeze

  def initialize(number, total_volume = DEFAULT_TOTAL_VOLUME)
    @number = number.to_s
    @type = "cargo"
    @total_volume = total_volume.to_i
    @occupied_volume = 0
    validate!
  end

  def to_s
    "#{super} общий объем: #{@total_volume}; заполнен на #{@occupied_volume};"
  end

  def free_volume
    @total_volume - @occupied_volume
  end

  def occupy_volume(volume)
    if volume > free_volume
      puts "In the train is not enough volume!"
    else
      @occupied_volume += volume
    end
  end

  def valid?
    validate!
    true
  rescue
    false
  end

  private

  def validate!
    super
    err_volume_message = "Total volume is not valid! Max volume is #{MAX_TOTAL_VOLUME}"
    raise RuntimeError.new(err_volume_message) if @total_volume.zero? || @total_volume > MAX_TOTAL_VOLUME
  end
end
