class ReservationController
  def initialize(objects)
    @objects = objects
  end

  def list_objects
    @objects.each_with_index.map { |obj, i| "#{i + 1}. #{obj.name}" }.join("\n")
  end

  def create_reservation(index, start_str, end_str)
    object = @objects[index]
    start_date = Date.parse(start_str) rescue nil
    end_date = Date.parse(end_str) rescue nil

    return :invalid_dates unless start_date && end_date && start_date <= end_date
    return :success if Reservation.create(object, start_date, end_date)

    :unavailable
  end

  def list_reservations
    @objects.flat_map do |obj|
      obj.reservations.map do |res|
        "#{obj.name} - from #{res.start_date} to #{res.end_date}"
      end
    end
  end
end