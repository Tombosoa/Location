public class Reservation : Object {
    public string object_name { get; construct; }
    public DateTime start_date { get; construct; }
    public DateTime end_date { get; construct; }

    public Reservation(string name, DateTime start_date, DateTime end_date) {
        Object(
            object_name: name,
            start_date: start_date,
            end_date: end_date
        );
    }

    public static bool create(ObjectItem obj, DateTime start, DateTime end) {
        if (start.compare(end) > 0) return false;

        if (obj.available(start, end)) {
            var res = new Reservation(obj.name, start, end);
            obj.add_reservation(res);
            return true;
        }
        return false;
    }
}