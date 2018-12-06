class Journey
  PENALTY_FARE = 6

  attr_reader :entry_station, :exit_station

  def initialize
    @complete = false
  end

  def start(entry_station = nil)
    @entry_station = entry_station
  end

  def finish(exit_station = nil)
    @exit_station = exit_station
    @complete = true
    self
  end

  def complete?
    @complete
  end

  def fare
    @entry_station.nil? || @exit_station.nil? ? PENALTY_FARE : 1
  end
end
