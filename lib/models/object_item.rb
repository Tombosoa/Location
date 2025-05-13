require 'date'

class ObjectItem
  attr_reader :name, :reservations

  def initialize(name)
    @name = name
    @reservations = []
  end

  def available?(start_date, end_date)
    @reservations.none? do |res|
      !(end_date < res.start_date || start_date > res.end_date)
    end
  end

  def add_reservation(reservation)
    @reservations << reservation
  end
end