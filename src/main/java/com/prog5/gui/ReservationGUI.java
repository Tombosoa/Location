package com.prog5.gui;

import com.prog5.Item;
import com.prog5.service.ReservationService;

import javax.swing.*;
import java.awt.*;
import java.time.LocalDate;
import java.util.Arrays;

public class ReservationGUI {

    private final ReservationService reservationService;
    private final DefaultListModel<String> reservationListModel = new DefaultListModel<>();
    private final JComboBox<String> itemCombo = new JComboBox<>();
    private final JSpinner startDateSpinner = new JSpinner(new SpinnerDateModel());
    private final JSpinner endDateSpinner = new JSpinner(new SpinnerDateModel());
    private final JLabel resultLabel = new JLabel("");

    public ReservationGUI() {
        reservationService = new ReservationService(Arrays.asList(
                new Item("Assiette"),
                new Item("Maison"),
                new Item("Voiture")
        ));

        for (Item item : reservationService.items()) {
            itemCombo.addItem(item.getName());
        }

        JSpinner.DateEditor startDateEditor = new JSpinner.DateEditor(startDateSpinner, "dd/MM/yyyy");
        startDateSpinner.setEditor(startDateEditor);
        JSpinner.DateEditor endDateEditor = new JSpinner.DateEditor(endDateSpinner, "dd/MM/yyyy");
        endDateSpinner.setEditor(endDateEditor);
    }

    public void display() {
        JFrame frame = new JFrame("Reservation System");
        frame.setSize(500, 300);
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);

        JButton reserveButton = new JButton("Reserve");
        reserveButton.addActionListener(e -> reserve());

        JList<String> reservationList = new JList<>(reservationListModel);
        JScrollPane scrollPane = new JScrollPane(reservationList);
        scrollPane.setPreferredSize(new Dimension(300, 100));

        JPanel inputPanel = new JPanel();
        inputPanel.setLayout(new GridLayout(3, 2, 10, 10));
        inputPanel.add(new JLabel("Item:"));
        inputPanel.add(itemCombo);
        inputPanel.add(new JLabel("Start Date:"));
        inputPanel.add(startDateSpinner);
        inputPanel.add(new JLabel("End Date:"));
        inputPanel.add(endDateSpinner);

        JPanel mainPanel = new JPanel(new BorderLayout());
        mainPanel.add(inputPanel, BorderLayout.NORTH);
        mainPanel.add(resultLabel, BorderLayout.CENTER);
        mainPanel.add(scrollPane, BorderLayout.SOUTH);

        JPanel buttonPanel = new JPanel();
        buttonPanel.add(reserveButton);
        mainPanel.add(buttonPanel, BorderLayout.SOUTH);

        frame.add(mainPanel);
        frame.setVisible(true);
    }

    private void reserve() {
        String itemName = (String) itemCombo.getSelectedItem();

        LocalDate startDate = convertToLocalDate((java.util.Date) startDateSpinner.getValue());
        LocalDate endDate = convertToLocalDate((java.util.Date) endDateSpinner.getValue());

        if (startDate != null && endDate != null && !endDate.isBefore(startDate)) {
            if (reservationService.reserveItem(itemName, startDate, endDate)) {
                reservationListModel.addElement(itemName + " - From " + startDate + " to " + endDate);
                resultLabel.setText("Reservation successful!");
            } else {
                resultLabel.setText("Item unavailable!");
            }
        } else {
            resultLabel.setText("Invalid dates!");
        }
    }

    private LocalDate convertToLocalDate(java.util.Date date) {
        if (date != null) {
            return new java.sql.Date(date.getTime()).toLocalDate();
        }
        return null;
    }

    public static void main(String[] args) {
        SwingUtilities.invokeLater(() -> new ReservationGUI().display());
    }
}
