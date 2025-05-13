public class ObjectItem : Object {
    public string name { get; construct; }
    public SList<Reservation> reservations = null;

    public ObjectItem(string name) {
        Object(name: name);
    }

    public bool available(DateTime start, DateTime end) {
        for (unowned var node = reservations; node != null; node = node.next) {
            var res = node.data;
            if (!(end.compare(res.start_date) < 0 || start.compare(res.end_date) > 0)) {
                return false;
            }
        }
        return true;
    }

    public void add_reservation(Reservation res) {
        reservations.prepend(res);
    }
}