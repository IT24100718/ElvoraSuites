<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="servlet.RoomsServlet" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Elvora Suites - Checkout</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;700&family=Roboto:wght@300;400;500&display=swap" rel="stylesheet" />
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

        .secondary-button {
            background: transparent;
            border: 2px solid var(--secondary);
            color: var(--secondary);
            padding: 12px 24px;
            border-radius: 50px;
            font-weight: 500;
            text-transform: uppercase;
            transition: all 0.3s ease;
        }

        .secondary-button:hover {
            background: var(--secondary);
            color: var(--text);
        }
    </style>
</head>
<body class="bg-gray-900 text-white">

<nav class="nav bg-primary fixed w-full top-0 z-10 shadow-lg">
    <div class="nav-logo text-secondary text-xl py-4 px-6">Elvora Suites</div>
    <ul class="flex justify-center flex-grow space-x-10 py-4">
        <li><a href="index.jsp" class="text-white hover:text-secondary">Home</a></li>
        <li><a href="rooms.jsp" class="text-white hover:text-secondary">Rooms</a></li>
        <li><a href="book.jsp" class="text-white hover:text-secondary">Book</a></li>
        <li><a href="login.jsp" class="text-white hover:text-secondary">Login</a></li>
        <li><a href="Signup.jsp" class="text-white hover:text-secondary">Sign Up</a></li>
    </ul>
</nav>

<div class="container mx-auto px-4 py-20 max-w-xl">
    <h1 class="text-5xl font-bold mb-10 font-['Playfair_Display'] text-center">Checkout</h1>

    <%
        String roomType = "";
        String checkin = "";
        String checkout = "";
        double price = 0;

        if (request.getAttribute("room") != null) {
            // Assuming the "room" attribute is a RoomsServlet.Room object
            RoomsServlet.Room room = (RoomsServlet.Room) request.getAttribute("room");
            if (room != null) {
                roomType = room.getName();
                // For price, use the room price
                price = room.getPrice();
            }
        }
        if (request.getAttribute("checkin") != null) {
            checkin = (String) request.getAttribute("checkin");
        }
        if (request.getAttribute("checkout") != null) {
            checkout = (String) request.getAttribute("checkout");
        }

        DecimalFormat df = new DecimalFormat("#.00");
    %>

    <div class="booking-summary bg-gray-800 p-6 rounded-lg mb-12">
        <h2 class="text-3xl font-semibold mb-6">Booking Summary</h2>
        <p><strong>Room Type:</strong> <%= roomType %></p>
        <p><strong>Check-in Date:</strong> <%= checkin %></p>
        <p><strong>Check-out Date:</strong> <%= checkout %></p>
        <p><strong>Total Price:</strong> $<%= df.format(price) %></p>
    </div>

    <form action="${pageContext.request.contextPath}/BookServlet" method="POST" class="space-y-6">
        <input type="hidden" name="roomId" value="<%= request.getAttribute("room") != null ? ((RoomsServlet.Room)request.getAttribute("room")).getId() : "" %>"/>
        <input type="hidden" name="checkin" value="<%= checkin %>" />
        <input type="hidden" name="checkout" value="<%= checkout %>" />

        <div>
            <label for="fullName" class="block text-left mb-1 font-semibold">Full Name</label>
            <input type="text" id="fullName" name="fullName" class="w-full bg-gray-800 text-white py-2 px-4 rounded-md" required />
        </div>

        <div>
            <label for="email" class="block text-left mb-1 font-semibold">Email Address</label>
            <input type="email" id="email" name="email" class="w-full bg-gray-800 text-white py-2 px-4 rounded-md" required />
        </div>

        <div>
            <label for="phone" class="block text-left mb-1 font-semibold">Phone Number</label>
            <input type="tel" id="phone" name="phone" class="w-full bg-gray-800 text-white py-2 px-4 rounded-md" required />
        </div>

        <div>
            <label for="address" class="block text-left mb-1 font-semibold">Address (Optional)</label>
            <textarea id="address" name="address" class="w-full bg-gray-800 text-white py-2 px-4 rounded-md"></textarea>
        </div>

        <div>
            <label for="paymentMethod" class="block text-left mb-1 font-semibold">Payment Method</label>
            <select id="paymentMethod" name="paymentMethod" class="w-full bg-gray-800 text-white py-2 px-4 rounded-md" required>
                <option value="Credit Card">Credit Card</option>
                <option value="Visa">Visa</option>
                <option value="Debit Card">Debit Card</option>
                <option value="PayPal">PayPal</option>
                <option value="Bank Transfer">Bank Transfer</option>
            </select>
        </div>

        <div class="flex justify-center space-x-6 mt-8">
            <button type="submit" class="button">Complete Booking</button>
            <button type="button" class="secondary-button" onclick="alert('Save Booking functionality not implemented yet.')">Save Booking</button>
        </div>
    </form>
</div>

<footer class="bg-primary text-white py-12 mt-20">
    <div class="container mx-auto text-center">
        <p>&copy; 2025 Elvora Suites. All rights reserved.</p>
    </div>
</footer>

</body>
</html>
