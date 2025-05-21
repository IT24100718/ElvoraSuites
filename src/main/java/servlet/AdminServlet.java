package servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Room;
import model.Booking;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.time.LocalDate;
import java.time.format.DateTimeParseException;

import utility.BookingJsonHandler;
import java.nio.file.Paths;
import java.nio.file.Path;


public class AdminServlet extends HttpServlet {

    private String bookingsFilePath;

    @Override
    public void init() throws ServletException {
        System.out.println("AdminServlet init called.");
        // Initialize the room list (this is a shared list, better handled with a database)
        List<Room> rooms = getRoomsFromContext();
        if (rooms == null) {
            rooms = new ArrayList<>();
            rooms.add(new Room(101, "Luxury Suite", "A luxurious room with a king-sized bed, ocean view.", 250.00));
            rooms.add(new Room(102, "Premier Room", "Spacious room with a queen-sized bed and a balcony.", 180.00));
            rooms.add(new Room(103, "Classic Room", "A large suite for families with a living area and kitchenette.", 120.00));
            getServletContext().setAttribute("rooms", rooms);
        }

        // Bookings initialization
        String rootPath = System.getProperty("user.dir");
        bookingsFilePath = rootPath + File.separator + "data" + File.separator + "bookings.txt";

        getServletContext().setAttribute("bookingsFilePath", bookingsFilePath);

        try {
            List<Booking> bookings = BookingJsonHandler.loadBookings(bookingsFilePath);

            if (bookings == null) {
                bookings = new ArrayList<>();
            }
            getServletContext().setAttribute("bookings", bookings);
            System.out.println("Bookings loaded from Text file: " + bookings.size());
        } catch (IOException e) {
            e.printStackTrace();
            getServletContext().setAttribute("bookings", new ArrayList<Booking>());
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("AdminServlet doGet called.");

        List<Room> rooms = getRoomsFromContext();

        if (rooms == null) {
            rooms = new ArrayList<>();
            getServletContext().setAttribute("rooms", rooms);
        }
        System.out.println("Rooms list size: " + rooms.size());
        request.setAttribute("rooms", rooms);

        // Load bookings from bookings.json file
        String rootPath = System.getProperty("user.dir");
        String filePath = rootPath + File.separator + "data" + File.separator + "bookings.txt";
        List<Booking> bookings = BookingJsonHandler.loadBookings(filePath);

        if (bookings == null) {
            bookings = new ArrayList<>();
        } else {
            bookings.sort(Comparator.comparing(Booking::getCheckin));
        }

        // Save loaded bookings into servlet context so that POST can access and modify if needed
        getServletContext().setAttribute("bookings", bookings);
        request.setAttribute("bookings", bookings);

        System.out.println("Bookings list size: " + bookings.size());

        request.getRequestDispatcher("/userLogin/admin.jsp").forward(request, response);
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String actionType = request.getParameter("actionType");

        if ("addRoom".equals(actionType)) {
            // Existing addRoom code unchanged
            String roomName = request.getParameter("name");
            String roomDescription = request.getParameter("description");
            String roomPriceStr = request.getParameter("price");
            String roomIdStr = request.getParameter("id");

            if (roomName != null && roomDescription != null && roomPriceStr != null && roomIdStr != null) {
                try {
                    int roomId = Integer.parseInt(roomIdStr);
                    double roomPrice = Double.parseDouble(roomPriceStr);

                    Room newRoom = new Room(roomId, roomName, roomDescription, roomPrice);

                    @SuppressWarnings("unchecked")
                    List<Room> rooms = getRoomsFromContext();
                    if (rooms == null) {
                        rooms = new ArrayList<>();
                        getServletContext().setAttribute("rooms", rooms);
                    }
                    rooms.add(newRoom);

                    response.sendRedirect(request.getContextPath() + "/admin");
                    return;
                } catch (NumberFormatException e) {
                    request.setAttribute("error", "Invalid room ID or price format.");
                    request.getRequestDispatcher("/userLogin/admin.jsp").forward(request, response);
                    return;
                }
            } else {
                request.setAttribute("error", "All fields are required to add a room.");
                request.getRequestDispatcher("/userLogin/admin.jsp").forward(request, response);
                return;
            }
        }

        else if ("addBooking".equals(actionType)) {
            String bookingIdStr = request.getParameter("bookingId");
            String userEmail = request.getParameter("userEmail");
            String roomIdStr = request.getParameter("roomId");
            String checkin = request.getParameter("checkin");
            String checkout = request.getParameter("checkout");

            if (bookingIdStr != null && userEmail != null && roomIdStr != null && checkin != null && checkout != null) {
                try {
                    int bookingId = Integer.parseInt(bookingIdStr);
                    int roomId = Integer.parseInt(roomIdStr);
                    LocalDate checkInDate = LocalDate.parse(checkin);
                    LocalDate checkOutDate = LocalDate.parse(checkout);

                    Booking newBooking = new Booking(bookingId, userEmail, roomId, checkInDate, checkOutDate);

                    @SuppressWarnings("unchecked")
                    List<Booking> bookings = getBookingsFromContext();
                    if (bookings == null) {
                        bookings = new ArrayList<>();
                    }

                    bookings.add(newBooking);

                    // Save updated bookings list back to bookings.json
                    String rootPath = System.getProperty("user.dir");
                    String filePath = rootPath + File.separator + "data" + File.separator + "bookings.txt";
                    BookingJsonHandler.saveBookings(bookings, filePath);

                    if (bookings == null) {
                        bookings = new ArrayList<>();
                    }

                    // Update servlet context with latest bookings
                    getServletContext().setAttribute("bookings", bookings);

                    response.sendRedirect(request.getContextPath() + "/admin");
                    return;
                } catch (NumberFormatException e) {
                    request.setAttribute("error", "Invalid booking ID or room ID format.");
                    request.getRequestDispatcher("/userLogin/admin.jsp").forward(request, response);
                    return;
                } catch (DateTimeParseException e) {
                    request.setAttribute("error", "Invalid date format. Use yyyy-MM-dd.");
                    request.getRequestDispatcher("/userLogin/admin.jsp").forward(request, response);
                    return;
                } catch (IOException e) {
                    request.setAttribute("error", "Failed to save booking data.");
                    request.getRequestDispatcher("/userLogin/admin.jsp").forward(request, response);
                    return;
                }
            } else {
                request.setAttribute("error", "All fields are required to add a booking.");
                request.getRequestDispatcher("/userLogin/admin.jsp").forward(request, response);
                return;
            }
        }

        else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action.");
        }
    }


    @SuppressWarnings("unchecked")
    private List<Room> getRoomsFromContext() {
        return (List<Room>) getServletContext().getAttribute("rooms");
    }

    @SuppressWarnings("unchecked")
    private List<Booking> getBookingsFromContext() {
        return (List<Booking>) getServletContext().getAttribute("bookings");
    }
}