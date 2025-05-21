package utility;

import model.Booking;

import java.io.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class BookingJsonHandler {

    public static List<Booking> loadBookings(String filePath) throws IOException {
        File file = new File(filePath);
        List<Booking> bookings = new ArrayList<>();

        if (!file.exists()) {
            file.getParentFile().mkdirs();
            file.createNewFile();
            return bookings;
        }

        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;

            while ((line = reader.readLine()) != null) {
                String[] parts = line.split("\\|");
                if (parts.length == 5) {
                    int id = Integer.parseInt(parts[0]);
                    String userEmail = parts[1];
                    int roomId = Integer.parseInt(parts[2]);
                    LocalDate checkin = LocalDate.parse(parts[3]);
                    LocalDate checkout = LocalDate.parse(parts[4]);

                    bookings.add(new Booking(id, userEmail, roomId, checkin, checkout));
                }
            }
        }

        return bookings;
    }

    public static void saveBookings(List<Booking> bookings, String filePath) throws IOException {
        File file = new File(filePath);
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(file))) {
            for (Booking booking : bookings) {
                writer.write(String.format("%d|%s|%d|%s|%s",
                        booking.getBookingId(),
                        booking.getUserEmail(),
                        booking.getRoomId(),
                        booking.getCheckin().toString(),
                        booking.getCheckout().toString()));
                writer.newLine();
            }
        }
    }

    public static int getNextBookingId(String idFilePath) throws IOException {
        File idFile = new File(idFilePath);
        int lastId = 0;

        if (idFile.exists()) {
            try (BufferedReader reader = new BufferedReader(new FileReader(idFile))) {
                String line = reader.readLine();
                if (line != null) {
                    lastId = Integer.parseInt(line.trim());
                }
            }
        }

        lastId++; // Increment to get the next ID

        try (BufferedWriter writer = new BufferedWriter(new FileWriter(idFile))) {
            writer.write(String.valueOf(lastId));
        }

        return lastId;
    }

}
