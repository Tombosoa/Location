require_relative 'lib/models/object_item'
require_relative 'lib/models/reservation'
require_relative 'lib/controllers/reservation_controller'

class ReservationApp
  def initialize
    @controller = ReservationController.new([
      ObjectItem.new("Assiette"),
      ObjectItem.new("Maison"),
      ObjectItem.new("Voiture")
    ])
  end

  def run
    loop do
      puts "\n--- Reservation System ---"
      puts "1. View available objects"
      puts "2. Make a reservation"
      puts "3. View all reservations"
      puts "0. Exit"
      print "Choose an option: "
      case gets.chomp
      when "1"
        puts "\nAvailable objects:"
        puts @controller.list_objects
      when "2"
        puts @controller.list_objects
        print "Select object number: "
        index = gets.chomp.to_i - 1

        print "Enter start date (YYYY-MM-DD): "
        start_date = gets.chomp
        print "Enter end date (YYYY-MM-DD): "
        end_date = gets.chomp

        case @controller.create_reservation(index, start_date, end_date)
        when :success
          puts "Reservation successful."
        when :unavailable
          puts "Error: Object not available for these dates."
        else
          puts "Invalid dates."
        end
      when "3"
        puts "\nAll Reservations:"
        puts @controller.list_reservations
      when "0"
        puts "Ciao!"
        break
      else
        puts "Invalid choice. Try again."
      end
    end
  end
end

ReservationApp.new.run
