package servlet;

import model.Booking;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import utility.BookingJsonHandler;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;


public class DeleteBookingServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int bookingId = Integer.parseInt(request.getParameter("bookingId"));

        ServletContext context = getServletContext();

        @SuppressWarnings("unchecked")
        List<Booking> bookings = (List<Booking>) context.getAttribute("bookings");
        if (bookings == null) {
            bookings = new ArrayList<>();
            context.setAttribute("bookings", bookings);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Bookings list not initialized");
            return;
        }

        bookings.removeIf(booking -> booking.getBookingId() == bookingId);


        String bookingsFilePath = (String) context.getAttribute("bookingsFilePath");
        if (bookingsFilePath != null) {
            try {
                // Save updated bookings back to JSON file
                String rootPath = System.getProperty("user.dir");
                String filePath = rootPath + File.separator + "data" + File.separator + "bookings.txt";
                BookingJsonHandler.saveBookings(bookings, filePath);
            } catch (IOException e) {
                e.printStackTrace();
                // Optionally, send an error or set a request attribute for error handling
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error saving bookings to file");
                return;
            }
        } else {
            // If file path is missing, log error or handle accordingly
            System.err.println("Booking file path is not set in ServletContext");
        }


        response.sendRedirect(request.getContextPath() + "/admin");
    }
}
