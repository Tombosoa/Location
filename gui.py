import tkinter as tk
from tkinter import messagebox
from tkcalendar import Calendar
from datetime import date
from typing import List, Optional


class Reservation:
    def __init__(self, item, start_date: date, end_date: date):
        self.item = item
        self.start_date = start_date
        self.end_date = end_date

    def __str__(self):
        return f"{self.item.name} from {self.start_date} to {self.end_date}"

    @staticmethod
    def can_reserve(item, start_date: date, end_date: date) -> bool:
        for reservation in item.reservations:
            if not (end_date < reservation.start_date or start_date > reservation.end_date):
                return False 
        return True 


class Item:
    def __init__(self, name: str):
        self.name = name
        self.reservations: List[Reservation] = []

    def add_reservation(self, reservation: Reservation):
        self.reservations.append(reservation)

    def __str__(self):
        return self.name


class ReservationService:
    def __init__(self, items: List[Item]):
        self.items = items

    def reserve_item(self, item_name: str, start_date: date, end_date: date) -> bool:
        for item in self.items:
            if item.name == item_name:
                if Reservation.can_reserve(item, start_date, end_date):
                    reservation = Reservation(item, start_date, end_date)
                    item.add_reservation(reservation)
                    return True
        return False


class ReservationGUI:
    def __init__(self, reservation_service: ReservationService):
        self.reservation_service = reservation_service

        self.window = tk.Tk()
        self.window.title("Reservation System")

        self.item_label = tk.Label(self.window, text="Item:")
        self.item_label.grid(row=0, column=0, padx=10, pady=10)

        self.start_date_label = tk.Label(self.window, text="Start Date:")
        self.start_date_label.grid(row=1, column=0, padx=10, pady=10)

        self.end_date_label = tk.Label(self.window, text="End Date:")
        self.end_date_label.grid(row=2, column=0, padx=10, pady=10)

        self.item_combo = tk.StringVar(self.window)
        self.item_combo.set(self.reservation_service.items[0].name) 
        self.item_menu = tk.OptionMenu(self.window, self.item_combo, *[item.name for item in self.reservation_service.items])
        self.item_menu.grid(row=0, column=1, padx=10, pady=10)

        self.start_date_calendar = Calendar(self.window, selectmode='day', date_pattern='yyyy-mm-dd')
        self.start_date_calendar.grid(row=1, column=1, padx=10, pady=10)

        self.end_date_calendar = Calendar(self.window, selectmode='day', date_pattern='yyyy-mm-dd')
        self.end_date_calendar.grid(row=2, column=1, padx=10, pady=10)

        self.reserve_button = tk.Button(self.window, text="Reserve", command=self.reserve)
        self.reserve_button.grid(row=3, column=0, columnspan=2, padx=10, pady=20)

        self.reservation_listbox = tk.Listbox(self.window, height=10, width=50)
        self.reservation_listbox.grid(row=4, column=0, columnspan=2, padx=10, pady=10)

        self.update_reservation_list()

    def reserve(self):
        item_name = self.item_combo.get()
        try:
            start_date_str = self.start_date_calendar.get_date()
            end_date_str = self.end_date_calendar.get_date()

            start_date = self.parse_date(start_date_str)
            end_date = self.parse_date(end_date_str)

            if start_date and end_date and not end_date < start_date:
                success = self.reservation_service.reserve_item(item_name, start_date, end_date)
                if success:
                    self.update_reservation_list()
                    messagebox.showinfo("Success", f"Reservation successful for {item_name} from {start_date} to {end_date}")
                else:
                    messagebox.showerror("Error", "The item is not available for the selected dates.")
            else:
                messagebox.showerror("Error", "Invalid dates or end date is before start date.")
        except ValueError:
            messagebox.showerror("Error", "Invalid date format.")

    def update_reservation_list(self):
        self.reservation_listbox.delete(0, tk.END)
        for item in self.reservation_service.items:
            for reservation in item.reservations:
                self.reservation_listbox.insert(tk.END, str(reservation))

    def parse_date(self, date_str: str) -> Optional[date]:
        try:
            return date.fromisoformat(date_str)
        except ValueError:
            return None

    def run(self):
        self.window.mainloop()



def main():
    plate = Item("Assiette")
    house = Item("Maison")
    car = Item("Voiture")

    reservation_service = ReservationService([plate, house, car])
    
    gui = ReservationGUI(reservation_service)
    gui.run()


if __name__ == "__main__":
    main()
