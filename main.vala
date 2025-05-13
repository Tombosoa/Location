public static int main(string[] args) {
    var objects = new SList<ObjectItem>();
    objects.prepend(new ObjectItem("Voiture"));
    objects.prepend(new ObjectItem("Maison"));
    objects.prepend(new ObjectItem("Assiette"));

    var controller = new ReservationController(objects);

    while (true) {
        print("\n--- Reservation System ---\n");
        print("1. View available objects\n");
        print("2. Make a reservation\n");
        print("3. View all reservations\n");
        print("0. Exit\n");
        stdout.printf("Choose an option: ");
        string? input = stdin.read_line();
        if (input == null) continue;
        input = input.chomp();

        switch (input) {
            case "1":
                print(controller.list_objects());
                break;
            case "2":
                print(controller.list_objects());
                stdout.printf("Select object number: ");
                string? index_input = stdin.read_line();
                if (index_input == null) {
                    print("Invalid input\n");
                    break;
                }
                index_input = index_input.chomp();
                int index = int.parse(index_input) - 1;

                stdout.printf("Enter start date (YYYY-MM-DD): ");
                string? start_str = stdin.read_line();
                if (start_str == null) {
                    print("Invalid input\n");
                    break;
                }
                start_str = start_str.chomp();

                stdout.printf("Enter end date (YYYY-MM-DD): ");
                string? end_str = stdin.read_line();
                if (end_str == null) {
                    print("Invalid input\n");
                    break;
                }
                end_str = end_str.chomp();

                string msg = controller.create_reservation(index, start_str, end_str);
                print("%s\n", msg);
                break;
            case "3":
                foreach (var line in controller.list_reservations()) {
                    print("%s\n", line);
                }
                break;
            case "0":
                print("Ciao!\n");
                return 0;
            default:
                print("Invalid choice.\n");
                break; 
        }
    }
}