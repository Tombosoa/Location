from datetime import date
from typing import List

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
