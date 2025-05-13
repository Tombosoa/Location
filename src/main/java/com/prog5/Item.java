package com.prog5;

import lombok.Getter;

import java.util.ArrayList;
import java.util.List;

@Getter
public class Item {
    private final String name;
    private final List<Reservation> reservations;

    public Item(String name) {
        this.name = name;
        this.reservations = new ArrayList<>();
    }

    public void addReservation(Reservation reservation) {
        reservations.add(reservation);
    }
}
