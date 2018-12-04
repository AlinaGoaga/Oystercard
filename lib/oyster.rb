class Oystercard
  attr_reader :balance
  attr_reader :journeys

  MAX_BALANCE = 90
  MIN_FARE = 1

  def initialize
    @balance = 0
    @journeys = {}
  end

  def top_up(amount)
    raise 'Max balance exceeded' if (amount + @balance) > MAX_BALANCE
    @balance += amount
  end

  def touch_in(entry_station = 'Aldgate East')
    raise 'Insufficient balance. GET RICH BRO!' if @balance < MIN_FARE
    raise 'User already in journey' if in_journey?
    @journeys[:entry_station] = entry_station
  end

  def touch_out(exit_station = 'Blackfriars')
    deduct
    @journeys[:exit_station] = exit_station
  end

  private

  def in_journey?
    @journeys[:entry_station] != nil
  end

  def deduct(amount = MIN_FARE)
    @balance -= amount
  end
end
