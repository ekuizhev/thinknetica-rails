require_relative 'wagon'

class PassengerWagon < Wagon
  attr_reader :seats_number, :occupied_seats

  DEFAULT_SEATS_NUMBER = 30.freeze
  MAX_SEATS_NUMBER = 50.freeze

  def initialize(number, seats_number = DEFAULT_SEATS_NUMBER)
    @number = number.to_s
    @type = "passenger"
    @seats_number = seats_number.to_i
    @occupied_seats = 0
    validate!
  end

  def to_s
    "#{super} всего мест: #{@seats_number}; занято #{@occupied_seats};"
  end

  def occupy_seat
    if free_seats > 0
      @occupied_seats += 1
    else
      puts "You can't to occupy seat, wagon is full"
    end
  end

  def free_seats
    @seats_number - @occupied_seats
  end

  private

  def validate!
    super
    err_seats_message = "Seats number is not valid! Max seats number is #{MAX_SEATS_NUMBER}"
    raise RuntimeError.new(err_seats_message) if @seats_number.zero? || @seats_number > MAX_SEATS_NUMBER
  end
end
