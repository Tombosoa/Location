from datetime import date
from typing import List
from model import Item, Reservation


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
