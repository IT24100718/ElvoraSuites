package servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Room;
import model.Booking;

import java.io.File;
import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeParseException;
import java.util.ArrayList;
import java.util.List;

import utility.BookingJsonHandler;

public class BookServlet extends HttpServlet {
    private List<Room> rooms;
    private List<Booking> bookings;

    @Override
    public void init() throws ServletException {
        // Simulate room data
        rooms = new ArrayList<>();
        bookings = new ArrayList<>();
        rooms.add(new Room(101, "Luxury Suite", "A luxurious room with a king-sized bed, ocean view.", 250.00));
        rooms.add(new Room(102, "Premier Room", "Spacious room with a queen-sized bed and a balcony.", 180.00));
        rooms.add(new Room(103, "Classic Room", "A large suite for families with a living area and kitchenette.", 120.00));
        System.out.println("BookServlet initialized with " + rooms.size() + " rooms.");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userEmail = getUserEmailOrRedirect(request, response);
        if (userEmail == null) return;

        String roomIdStr = request.getParameter("roomId");
        String checkinStr = request.getParameter("checkin");
        String checkoutStr = request.getParameter("checkout");

        String idParam = request.getParameter("id");
        if (idParam != null) {
            try {
                int roomId = Integer.parseInt(idParam);
                Room selectedRoom = rooms.stream()
                        .filter(r -> r.getId() == roomId)
                        .findFirst()
                        .orElse(null);
                request.setAttribute("rooms", rooms);
                if (selectedRoom != null) {
                    request.setAttribute("selectedRoom", selectedRoom);
                    request.setAttribute("roomType", selectedRoom.getName());
                } else {
                    request.setAttribute("error", "Room not found.");
                }
            } catch (NumberFormatException e) {
                request.setAttribute("error", "Invalid room ID.");
            }
            request.getRequestDispatcher("/userLogin/book.jsp").forward(request, response);
            return;
        }

        if (roomIdStr != null && checkinStr != null && checkoutStr != null) {
            try {
                Integer roomId = parseRoomId(roomIdStr);
                if (roomId == null) {
                    request.setAttribute("error", "Invalid room ID.");
                    request.getRequestDispatcher("/userLogin/book.jsp").forward(request, response);
                    return;
                }

                LocalDate checkin = LocalDate.parse(checkinStr);
                LocalDate checkout = LocalDate.parse(checkoutStr);

                if (!checkout.isAfter(checkin)) {
                    request.setAttribute("error", "Checkout date must be after checkin date.");
                    request.getRequestDispatcher("/userLogin/book.jsp").forward(request, response);
                    return;
                }

                boolean available = bookings.stream().noneMatch(b ->
                        roomId.equals(b.getRoomId()) &&
                                (checkin.isBefore(b.getCheckout()) && checkout.isAfter(b.getCheckin()))
                );

                if (!available) {
                    request.setAttribute("error", "Selected room is not available for the chosen dates.");
                    request.getRequestDispatcher("/userLogin/book.jsp").forward(request, response);
                    return;
                }

                // Room is available, forward to checkout.jsp
                request.setAttribute("roomId", roomId);
                request.setAttribute("checkin", checkinStr);
                request.setAttribute("checkout", checkoutStr);

                // Find room details and set as attribute (optional)
                Room selectedRoom = rooms.stream()
                        .filter(r -> roomId.equals(r.getId()))
                        .findFirst()
                        .orElse(null);
                request.setAttribute("room", selectedRoom);

                request.getRequestDispatcher("/userLogin/checkout.jsp").forward(request, response);

            } catch (DateTimeParseException dtpe) {
                request.setAttribute("error", "Invalid date format. Please use YYYY-MM-DD.");
                request.getRequestDispatcher("/userLogin/book.jsp").forward(request, response);
            } catch (Exception e) {
                request.setAttribute("error", "An unexpected error occurred.");
                request.getRequestDispatcher("/userLogin/book.jsp").forward(request, response);
            }
        } else {
            // No parameters, just show booking form
            request.getRequestDispatcher("/userLogin/book.jsp").forward(request, response);
        }
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userEmail = (String) request.getSession().getAttribute("email");
        if (userEmail == null) {
            response.sendRedirect(request.getContextPath() + "/userLogin/login.jsp?error=Please+login+to+book");
            return;
        }

        String roomIdStr = request.getParameter("roomId");
        String checkinStr = request.getParameter("checkin");
        String checkoutStr = request.getParameter("checkout");
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");

        System.out.println("==== Booking Process Started ====");
        System.out.println("roomId: " + roomIdStr);
        System.out.println("checkin: " + checkinStr);
        System.out.println("checkout: " + checkoutStr);
        System.out.println("fullName: " + fullName);
        System.out.println("email: " + email);
        System.out.println("phone: " + phone);
        System.out.println("User session email: " + userEmail);

        // Basic validation (expand as needed)
        if (roomIdStr == null || checkinStr == null || checkoutStr == null ||
                fullName == null || email == null || phone == null ||
                roomIdStr.isEmpty() || checkinStr.isEmpty() || checkoutStr.isEmpty() ||
                fullName.isEmpty() || email.isEmpty() || phone.isEmpty()) {
            request.setAttribute("error", "Please fill all required fields.");
            request.getRequestDispatcher("/userLogin/book.jsp").forward(request, response);
            return;
        }

        try {
            int roomId = Integer.parseInt(roomIdStr);
            LocalDate checkin = LocalDate.parse(checkinStr);
            LocalDate checkout = LocalDate.parse(checkoutStr);

            if (!checkin.isBefore(checkout)) {
                request.setAttribute("error", "Check-in date must be before check-out date.");
                request.getRequestDispatcher("/userLogin/book.jsp").forward(request, response);
                return;
            }

            String rootPath = System.getProperty("user.dir");
            String filePath = rootPath + File.separator + "data" + File.separator + "bookings.txt";
            String idFilePath = rootPath + File.separator + "data" + File.separator + "booking_id.txt";
            List<Booking> bookings = BookingJsonHandler.loadBookings(filePath);

            System.out.println("Accessing file at: " + filePath);

            // Double-check availability before booking
            boolean available = bookings.stream().noneMatch(b ->
                    b.getRoomId() == roomId &&
                            (checkin.isBefore(b.getCheckout()) && checkout.isAfter(b.getCheckin()))
            );

            if (!available) {
                request.setAttribute("error", "Room no longer available.");
                request.getRequestDispatcher("/userLogin/book.jsp").forward(request, response);
                return;
            }


            int bookingId = BookingJsonHandler.getNextBookingId(idFilePath);

            // Save booking
            Booking newBooking = new Booking(bookingId, userEmail, roomId, checkin, checkout);

            System.out.println("Booking successfully saved.");

            // Add the new booking and save back to JSON file
            bookings.add(newBooking);
            BookingJsonHandler.saveBookings(bookings, filePath);


            response.sendRedirect(request.getContextPath() + "/userLogin/success.jsp?type=bookCheck");

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Invalid booking details.");
            request.getRequestDispatcher("/userLogin/book.jsp").forward(request, response);
        }
    }

    private String getUserEmailOrRedirect(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String email = (String) request.getSession().getAttribute("email");
        if (email == null) {
            response.sendRedirect(request.getContextPath() + "/userLogin/login.jsp?error=Please+login+to+book");
            return null;
        }
        return email;
    }

    private Integer parseRoomId(String roomIdStr) {
        try {
            return Integer.parseInt(roomIdStr);
        } catch (NumberFormatException e) {
            return null;
        }
    }

}
