class Journey
  attr_reader :entry_station, :exit_station

  def initialize
    @entry_station = nil
    @exit_station  = nil
    @in_journey    = nil
  end

  def record_end(station)
    @in_journey   = false
    @exit_station = station.name
  end

  def record_start(station)
    @in_journey    = true
    @entry_station = station.name
  end

  def view_journey
    "Start: #{@entry_station}\n Destination: #{@exit_station}"
  end

  def travelling?
    @in_journey
  end
end
