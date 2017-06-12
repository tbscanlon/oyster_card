class OysterCard
  attr_reader :balance, :status
  MAXIMUM_BALANCE = 90

  def initialize(balance = 0, status = :not_in_use)
    @balance = balance
    @status = status
  end

  def top_up(amount)
    raise "Can't top up beyond #{MAXIMUM_BALANCE} pounds" if @balance + amount > MAXIMUM_BALANCE
    @balance += amount
  end

  def deduct(fare)
    @balance -= fare
  end

  def touch_in
    @status = :in_use
  end

  def touch_out
    @status = :not_in_use
  end

  def in_journey?
    @status == :in_use
  end
end
