class Oystercard
  attr_reader :balance
  attr_accessor :journey, :journeys

  MAX_BALANCE = 90
  MIN_FARE = 1

  def initialize
    @balance = 0
    @journey = {}
    @journeys = []
  end

  def top_up(amount)
    raise 'Max balance exceeded' if (amount + @balance) > MAX_BALANCE
    @balance += amount
  end

  def touch_in(entry_station = 'Aldgate East')
    raise 'Insufficient balance. GET RICH BRO!' if @balance < MIN_FARE
    raise 'User already in journey' if in_journey?
    @journey[:entry_station] = entry_station
  end

  def touch_out(exit_station = 'Blackfriars')
    deduct
    @journey[:exit_station] = exit_station
  end

  def save_journey
    @journeys << @journey
end

  private

  def in_journey?
    !@journey[:entry_station].nil? && @journey[:exit_station].nil?
  end

  def deduct(amount = MIN_FARE)
    @balance -= amount
  end
end
