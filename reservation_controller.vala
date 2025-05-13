public class ReservationController : Object {
    public unowned SList<ObjectItem> objects { get; construct; }

    public ReservationController(SList<ObjectItem> objects) {
        Object(objects: objects);
    }

    public string list_objects() {
        string result = "";
        int i = 1;
        for (unowned var node = objects; node != null; node = node.next) {
            result += "%d. %s\n".printf(i++, node.data.name);
        }
        return result;
    }

    public string[] list_reservations() {
        var all = new string[0];
        for (unowned var obj_node = objects; obj_node != null; obj_node = obj_node.next) {
            var obj = obj_node.data;
            for (unowned var res_node = obj.reservations; res_node != null; res_node = res_node.next) {
                var res = res_node.data;
                all += "%s - from %s to %s".printf(
                    obj.name,
                    res.start_date.format("%F"),
                    res.end_date.format("%F")
                );
            }
        }
        return all;
    }

    public string create_reservation(int index, string start_str, string end_str) {
        var obj = get_object_at(index);
        if (obj == null) return "Invalid object index.";
    
        DateTime start = null;
        DateTime end = null;
        
        try {
            var start_parts = start_str.split("-");
            var end_parts = end_str.split("-");
            
            if (start_parts.length != 3 || end_parts.length != 3) {
                return "Invalid date format. Use YYYY-MM-DD.";
            }
            
            start = new DateTime.utc(
                int.parse(start_parts[0]),
                int.parse(start_parts[1]),
                int.parse(start_parts[2]),
                0, 0, 0
            );
            
            end = new DateTime.utc(
                int.parse(end_parts[0]),
                int.parse(end_parts[1]),
                int.parse(end_parts[2]),
                0, 0, 0
            );
        } catch (Error e) {
            return "Invalid date format. Use YYYY-MM-DD.";
        }
    
        if (start.compare(end) > 0) {
            return "End date must be after start date.";
        }
    
        if (Reservation.create(obj, start, end)) {
            return "Reservation successful.";
        }
        return "Object unavailable for the selected dates.";
    }

    private ObjectItem? get_object_at(int index) {
        int i = 0;
        for (unowned var node = objects; node != null; node = node.next) {
            if (i == index) return node.data;
            i++;
        }
        return null;
    }
}