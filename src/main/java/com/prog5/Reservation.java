package com.prog5;

import java.time.LocalDate;

public record Reservation(Item item, LocalDate startDate, LocalDate endDate) {

    public static boolean canReserve(Item item, LocalDate startDate, LocalDate endDate) {
        for (Reservation reservation : item.getReservations()) {
            if (!(endDate.isBefore(reservation.startDate()) || startDate.isAfter(reservation.endDate()))) {
                return false;
            }
        }
        return true;
    }

    public static boolean reserveItem(Item item, LocalDate startDate, LocalDate endDate) {
        if (canReserve(item, startDate, endDate)) {
            Reservation reservation = new Reservation(item, startDate, endDate);
            item.addReservation(reservation);
            return true;
        }
        return false;
    }
}
