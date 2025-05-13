package com.prog5.service;

import com.prog5.Item;
import com.prog5.Reservation;

import java.time.LocalDate;
import java.util.List;

public record ReservationService(List<Item> items) {

    public boolean reserveItem(String itemName, LocalDate startDate, LocalDate endDate) {
        for (Item item : items) {
            if (item.getName().equals(itemName)) {
                return Reservation.reserveItem(item, startDate, endDate);
            }
        }
        return false;
    }
}
