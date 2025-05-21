package model;
import java.time.LocalDate;

public class Booking {
    private int bookingId;
    private int roomId;
    private String userEmail; // or userId
    private LocalDate checkInDate;
    private LocalDate checkOutDate;

    public Booking() {
    }

    public Booking(int bookingId, String email, int roomId, LocalDate checkInDate, LocalDate checkOutDate) {
        this.bookingId = bookingId;
        this.roomId = roomId;
        this.userEmail = email;
        this.checkInDate = checkInDate;
        this.checkOutDate = checkOutDate;
    }

    public String getUserEmail() {
        return userEmail;
    }

    public void setUserEmail(String userEmail) { this.userEmail = userEmail; }

    public int getBookingId() {
        return bookingId;
    }

    public void setBookingId(int bookingId) {
        this.bookingId = bookingId;
    }

    public int getRoomId() {
        return roomId;
    }

    public void setRoomId(int roomId) { this.roomId = roomId; }

    public LocalDate getCheckin() {
        return checkInDate;
    }

    public void setCheckin(LocalDate checkInDate) {
        this.checkInDate = checkInDate;
    }

    public LocalDate getCheckout() {
        return checkOutDate;
    }

    public void setCheckout(LocalDate checkOutDate) {
        this.checkOutDate = checkOutDate;
    }

    public String toString() {
        return"Booking ="+ bookingId + ", Room=" + roomId + ", User=" + userEmail + ", Checkin=" + checkInDate + ", Checkout=" + checkOutDate;
    }
}
