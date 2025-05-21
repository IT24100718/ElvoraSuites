        package servlet;

        import jakarta.servlet.ServletException;
        import jakarta.servlet.http.HttpServlet;
        import jakarta.servlet.http.HttpServletRequest;
        import jakarta.servlet.http.HttpServletResponse;
        import model.room;
        import model.Booking;
        import utility.BookingJsonHandler;

        import java.io.File;
        import java.io.IOException;
        import java.time.LocalDate;
        import java.util.*;

        public class RoomsServlet extends HttpServlet {

            // Example data for rooms (you can retrieve this from a database in a real application)
            private List<room> rooms;
            private List<Booking> bookings;

            @Override
            public void init() throws ServletException {
                rooms = new ArrayList<>();
                rooms.add(new room(101, "Luxury Suite", "A luxurious room with a king-sized bed, ocean view.", 250.00));
                rooms.add(new room(102, "Premier Room", "Spacious room with a queen-sized bed and a balcony.", 180.00));
                rooms.add(new room(103, "Classic Room", "A large suite for families with a living area and kitchenette.", 120.00));

                try {
                    // Use your JSON handler here
                    String rootPath = System.getProperty("user.dir");
                    String filePath = rootPath + File.separator + "data" + File.separator + "bookings.json";
                    bookings = BookingJsonHandler.loadBookings(filePath);
                } catch (IOException e) {
                    e.printStackTrace();
                    bookings = new ArrayList<>(); // Fallback if JSON loading fails
                }

                quickSortBookings(bookings, 0, bookings.size() - 1);

                System.out.println("Rooms initialized: " + rooms.size());
                System.out.println("Bookings loaded and sorted: " + bookings.size());
            }



            private void quickSortBookings(List<Booking> list, int low, int high) {
                if (low < high) {
                    int pi = partition(list, low, high);
                    quickSortBookings(list, low, pi - 1);
                    quickSortBookings(list, pi + 1, high);
                }
            }


            private int partition(List<Booking> list, int low, int high) {
                LocalDate pivot = list.get(high).getCheckin();
                int i = low - 1;
                for (int j = low; j < high; j++) {
                    if (list.get(j).getCheckin().isBefore(pivot) || list.get(j).getCheckin().isEqual(pivot)) {
                        i++;
                        Collections.swap(list, i, j);
                    }
                }
                Collections.swap(list, i + 1, high);
                return i + 1;
            }




            @Override
            protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


                Map<Integer, Boolean> availability = new HashMap<>();
                LocalDate today = LocalDate.now();


                System.out.println("RoomsServlet is processing the request.");
                // Create a simple map from roomId to availability (you can create a real Map if you want)
                for (room room : rooms) {
                    boolean isAvailable = true;
                    for (Booking booking : bookings) {
                        if (booking.getRoomId() == room.getId() &&
                                !today.isBefore(booking.getCheckin()) &&
                                !today.isAfter(booking.getCheckout())) {
                            isAvailable = false;
                            break;
                        }
                    }
                    availability.put(room.getId(), isAvailable);
                    System.out.println("Room ID: " + room.getId() + " Availability: " + isAvailable);
                }

                // Add rooms list to the request attribute
                request.setAttribute("rooms", rooms);
                request.setAttribute("availability", availability);


                System.out.println("Rooms attribute size: " + rooms.size());

                // Forward to the rooms.jsp in the correct location
                request.getRequestDispatcher("/userLogin/rooms.jsp").forward(request, response);
            }

        }
