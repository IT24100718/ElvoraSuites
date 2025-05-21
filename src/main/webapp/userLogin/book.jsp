<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.format.DateTimeParseException" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Room" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%
  if (session == null || session.getAttribute("email") == null) {
    // User not logged in, redirect to login page
    response.sendRedirect(request.getContextPath() + "/userLogin/login.jsp?error=Please+login+first");
    return; // Stop processing further in this JSP
  }
%>

<%
  // Simulated rooms list (replace with DB or servlet attribute)
  List<Room> rooms = new ArrayList<>();
  rooms.add(new Room(101, "Luxury Suite", "A luxurious room with a king-sized bed, ocean view.", 250.00));
  rooms.add(new Room(102, "Premier Room", "Spacious room with a queen-sized bed and a balcony.", 180.00));
  rooms.add(new Room(103, "Classic Room", "A large suite for families with a living area and kitchenette.", 120.00));

  // Read parameters
  String action = request.getParameter("action"); // can be "check" or "book"
  String roomType = request.getParameter("room");
  String checkinStr = request.getParameter("checkin");
  String checkoutStr = request.getParameter("checkout");

  String message = null;
  boolean showSummaryForm = false;

  double price = 0.0;
  Room selectedRoom = null;

  if ("check".equals(action) && roomType != null && checkinStr != null && checkoutStr != null) {
    try {
      LocalDate checkin = LocalDate.parse(checkinStr);
      LocalDate checkout = LocalDate.parse(checkoutStr);

      // Find room by name
      for (Room r : rooms) {
        if (r.getName().equals(roomType)) {
          selectedRoom = r;
          price = r.getPrice();
          break;
        }
      }

      if (selectedRoom == null) {
        message = "Selected room not found.";
      } else if (!checkout.isAfter(checkin)) {
        message = "Check-out date must be after check-in date.";
      } else {
        // TODO: Add availability check here
        // For demo, assume always available
        message = "Room is available!";
        showSummaryForm = true;
      }
    } catch (DateTimeParseException e) {
      message = "Invalid date format.";
    }
  }

  if ("book".equals(action)) {
    // Handle booking submission
    // You can call your servlet or business logic here
    message = "Booking completed successfully!";
    showSummaryForm = false; // hide form after booking
  }
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Elvora Suites - Book & Checkout</title>
  <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;700&family=Roboto:wght@300;400;500&display=swap" rel="stylesheet">
  <style>
    :root {
      --primary: #0A1C3D; /* Navy Blue */
      --secondary: #B89700; /* Royal Gold */
      --background: #1A2533; /* Dark Gray */
      --text: #F5F5F5; /* Light Ivory */
      --gradient: linear-gradient(45deg, #0A1C3D, #B89700);
    }

    body {
      background-color: var(--background);
      color: var(--text);
      font-family: 'Roboto', sans-serif;
      scroll-behavior: smooth;
    }

    h1, h2, h3, h4 {
      font-family: 'Playfair Display', serif;
    }

    .button {
      background: var(--gradient);
      color: var(--text);
      padding: 12px 24px;
      border-radius: 50px;
      transition: transform 0.3s, box-shadow 0.3s;
      font-weight: 500;
      text-transform: uppercase;
    }

    .button:hover {
      transform: translateY(-3px);
      box-shadow: 0 5px 15px rgba(184,151,0,0.5);
    }
  </style>
</head>
<body class="bg-gray-900 text-white">

<!-- Navigation -->
<nav class="nav bg-primary fixed w-full top-0 z-10 shadow-lg">
  <div class="nav-logo text-secondary text-xl py-4 px-6">Elvora Suites</div>
  <ul class="flex justify-center flex-grow space-x-10 py-4">
    <li><a href="../index.jsp" class="text-white hover:text-secondary">HOME</a></li>
    <li><a href="<%= request.getContextPath() %>/rooms" class="text-white hover:text-secondary">ROOMS</a></li>
    <li><a href="${pageContext.request.contextPath}/userLogin/book.jsp" class="text-white hover:text-secondary">BOOK</a></li>
    <%
      String email = (String) session.getAttribute("email");
      if (email == null) {
    %>
    <!-- Show Login if user is NOT logged in -->
    <li><a href="${pageContext.request.contextPath}/userLogin/login.jsp" class="uppercase text-sm tracking-wide">Login</a></li>
    <%
    } else {
    %>
    <!-- Show Logout if user IS logged in -->
    <li><a href="${pageContext.request.contextPath}/LogoutServlet" class="px-4 py-2 text-red-400">Logout</a></li>
    <%
      }
    %>
  </ul>
</nav>

<!-- Book & Checkout Section -->
<div class="container mx-auto px-4 py-20 text-center">
  <h1 class="text-5xl mt-20 font-bold mb-6 font-['Playfair_Display']">Book Your Stay</h1>

  <% if (message != null) { %>
  <p class="mb-6 text-yellow-400"><%= message %></p>
  <% } %>

  <!-- Booking Search Form -->
  <form method="GET" action="<%= request.getRequestURI() %>" class="space-y-6">
    <input type="hidden" name="action" value="check" />
    <div class="flex justify-center">
      <label for="room" class="mr-4">Room Type</label>
      <select name="room" id="room" class="bg-gray-800 text-white py-2 px-4 rounded-md" required>
        <% for (Room r : rooms) { %>
        <option value="<%= r.getName() %>" <%= r.getName().equals(roomType) ? "selected" : "" %>><%= r.getName() %></option>
        <% } %>
      </select>
    </div>

    <div class="flex justify-center">
      <label for="checkin" class="mr-4">Check-in Date</label>
      <input type="date" name="checkin" id="checkin" value="<%= checkinStr != null ? checkinStr : "" %>" class="bg-gray-800 text-white py-2 px-4 rounded-md" required/>
    </div>

    <div class="flex justify-center">
      <label for="checkout" class="mr-4">Check-out Date</label>
      <input type="date" name="checkout" id="checkout" value="<%= checkoutStr != null ? checkoutStr : "" %>" class="bg-gray-800 text-white py-2 px-4 rounded-md" required/>
    </div>

    <div class="flex justify-center space-x-4">
      <button type="submit" class="button">Check Availability</button>
    </div>
  </form>

  <% if (showSummaryForm && selectedRoom != null) { %>
  <!-- Booking Summary and User Details Form -->
  <div class="booking-summary mt-10 p-6 bg-gray-800 rounded-lg text-left max-w-xl mx-auto">
    <h2 class="text-3xl font-semibold mb-6">Booking Summary</h2>
    <p><strong>Room Type:</strong> <%= selectedRoom.getName() %></p>
    <p><strong>Check-in Date:</strong> <%= checkinStr %></p>
    <p><strong>Check-out Date:</strong> <%= checkoutStr %></p>
    <p><strong>Total Price:</strong> $<%= String.format("%.2f", price) %></p>

    <form method="POST" action="${pageContext.request.contextPath}/BookServlet" class="space-y-6 mt-6">
      <input type="hidden" name="roomId" value="<%= selectedRoom.getId() %>" />
      <input type="hidden" name="checkin" value="<%= checkinStr %>" />
      <input type="hidden" name="checkout" value="<%= checkoutStr %>" />

      <div>
        <label for="fullName" class="block mb-1 font-semibold">Full Name</label>
        <input type="text" name="fullName" id="fullName" class="w-full bg-gray-800 text-white py-2 px-4 rounded-md" required />
      </div>

      <div>
        <label for="email" class="block mb-1 font-semibold">Email Address</label>
        <input type="email" name="email" id="email" class="w-full bg-gray-800 text-white py-2 px-4 rounded-md" required />
      </div>

      <div>
        <label for="phone" class="block mb-1 font-semibold">Phone Number</label>
        <input type="tel" name="phone" id="phone" class="w-full bg-gray-800 text-white py-2 px-4 rounded-md" required />
      </div>

      <div>
        <label for="address" class="block mb-1 font-semibold">Address (Optional)</label>
        <textarea name="address" id="address" class="w-full bg-gray-800 text-white py-2 px-4 rounded-md"></textarea>
      </div>

      <div>
        <label for="paymentMethod" class="block mb-1 font-semibold">Payment Method</label>
        <select name="paymentMethod" id="paymentMethod" class="w-full bg-gray-800 text-white py-2 px-4 rounded-md" required>
          <option value="Credit Card">Credit Card</option>
          <option value="Visa">Visa</option>
          <option value="Debit Card">Debit Card</option>
          <option value="PayPal">PayPal</option>
          <option value="Bank Transfer">Bank Transfer</option>
        </select>
      </div>

      <div class="flex justify-center space-x-6 mt-8">
        <button type="submit" class="button">Complete Booking</button>
        <button type="button" class="secondary-button" onclick="alert('Save Booking feature coming soon!')">Save Booking</button>
      </div>
    </form>
  </div>
  <% } %>

</div>

<!-- Footer -->
<footer class="bg-primary text-white py-12">
  <div class="container mx-auto text-center">
    <p>&copy; 2025 Elvora Suites. All rights reserved.</p>
  </div>
</footer>

</body>
</html>
