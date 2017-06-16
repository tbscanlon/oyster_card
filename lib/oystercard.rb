require_relative 'station'
require_relative 'journey'

class Oystercard
  attr_reader :balance, :journey_history, :journey

  DEFAULT_BALANCE = 0
  MAX_LIMIT       = 90
  MIN_FARE        = 1

  def initialize(balance = DEFAULT_BALANCE)
    @balance          = balance
    @journey_history  = []
  end

  def journey
    journey_history.last
  end

  def top_up(money)
    raise "Exceeded #{MAX_LIMIT} limit" if too_much? money
    @balance += money
  end

  def touch_in(station, journey = Journey.new)
    raise "Please top up at least £#{MIN_FARE}" if no_money?
    journey.record_start(station)
    @journey_history << journey
  end

  def touch_out(station)
    deduct(MIN_FARE)
    journey.record_end(station)
  end

  def previous_journeys
    @journey_history.each { |journey| puts journey.view_journey }
  end

  private
  def deduct(min_fare)
    @balance -= MIN_FARE
  end

  def too_much?(money)
   @balance + money >= MAX_LIMIT
  end

  def no_money?
    @balance < 1
  end
end
