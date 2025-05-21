package servlet;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import model.Booking;
import utility.BookingJsonHandler;

import java.io.File;
import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

public class UpdateBookingServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int bookingId = Integer.parseInt(request.getParameter("bookingId"));
        String email = request.getParameter("userEmail");
        int roomId = Integer.parseInt(request.getParameter("roomId"));
        LocalDate checkin = LocalDate.parse(request.getParameter("checkin"));
        LocalDate checkout = LocalDate.parse(request.getParameter("checkout"));

        ServletContext context = getServletContext();
        @SuppressWarnings("unchecked")
        List<Booking> bookings = (List<Booking>) context.getAttribute("bookings");

        for (Booking b : bookings) {
            if (b.getBookingId() == bookingId) {
                b.setUserEmail(email);
                b.setRoomId(roomId);
                b.setCheckin(checkin);
                b.setCheckout(checkout);
                break;
            }
        }

        // Save updated list
        String filePath = System.getProperty("user.dir") + File.separator + "data" + File.separator + "bookings.txt";
        BookingJsonHandler.saveBookings(bookings, filePath);

        response.sendRedirect(request.getContextPath() + "/admin");
    }
}
