class Reservation
  attr_reader :object_item, :start_date, :end_date

  def initialize(object_item, start_date, end_date)
    @object_item = object_item
    @start_date = start_date
    @end_date = end_date
  end

  def self.create(object_item, start_date, end_date)
    return false unless start_date && end_date && start_date <= end_date

    if object_item.available?(start_date, end_date)
      reservation = new(object_item, start_date, end_date)
      object_item.add_reservation(reservation)
      true
    else
      false
    end
  end
end