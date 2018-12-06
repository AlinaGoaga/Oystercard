require_relative 'journey'

class Oystercard
  attr_reader :balance
  attr_accessor :journeys

  MAX_BALANCE = 90
  MIN_FARE = 1

  def initialize(journey = Journey.new)
    @balance = 0
    @journey = journey
    @journeys = []
  end

  def top_up(amount)
    raise 'Max balance exceeded' if (amount + @balance) > MAX_BALANCE
    @balance += amount
  end

  def touch_in(entry_station = nil)
    raise 'Insufficient balance. GET RICH BRO!' if @balance < MIN_FARE
    @journey.start(entry_station)
  end

  def touch_out(exit_station = nil)
    deduct
    @journey.finish(exit_station)
  end

  def save_journey
    @journeys << @journey
end

  private

  def deduct(amount = MIN_FARE)
    @balance -= amount
  end
end
