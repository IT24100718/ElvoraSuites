<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.*, model.Room, model.Booking" %>

<%
    String userRole = (String) session.getAttribute("userRole");
    if (userRole == null || !userRole.equalsIgnoreCase("admin")) {
        response.sendRedirect(request.getContextPath() + "/unauthorized.jsp");
        return;
    }

    List<model.Room> rooms = (List<model.Room>) request.getAttribute("rooms");
    List<Booking> bookings = (List<Booking>) request.getAttribute("bookings");

    if (bookings == null) {
        bookings = new ArrayList<>();
    }
    String error = (String) request.getAttribute("error");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Admin Panel - Manage Rooms</title>

    <style>
        /* Paste your home page styles here */
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
            margin: 0;
            padding: 0;
            scroll-behavior: smooth;
        }

        h1, h2, h3, h4 {
            font-family: 'Playfair Display', serif;
        }

        /* Nav styling omitted since no nav in Admin Panel */

        /* Container */
        .container {
            max-width: 900px;
            margin: 40px auto;
            padding: 20px;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 12px;
            box-shadow: 0 15px 30px rgba(0,0,0,0.4), 0 0 10px var(--secondary);
            backdrop-filter: blur(10px);
        }

        .title {
            font-size: 2.5rem;
            margin-bottom: 20px;
            color: var(--secondary);
            text-align: center;
        }

        .subtitle {
            font-size: 1.75rem;
            margin-top: 30px;
            margin-bottom: 15px;
            color: var(--secondary);
            border-bottom: 2px solid var(--secondary);
            padding-bottom: 5px;
        }

        .error {
            background-color: #b22222;
            color: #fff;
            padding: 10px 15px;
            margin-bottom: 20px;
            border-radius: 8px;
            text-align: center;
            font-weight: 600;
        }

        table.rooms-table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 30px;
        }

        table.rooms-table th, table.rooms-table td {
            border: 1px solid rgba(255,255,255,0.3);
            padding: 12px 15px;
            text-align: left;
        }

        table.rooms-table th {
            background: var(--primary);
            color: var(--secondary);
        }

        table.rooms-table tbody tr:nth-child(even) {
            background: rgba(255, 255, 255, 0.05);
        }

        form.add-room-form {
            display: flex;
            flex-direction: column;
            gap: 15px;
        }

        form.add-room-form label {
            font-weight: 600;
            color: var(--secondary);
        }

        form.add-room-form input[type="text"],
        form.add-room-form textarea {
            padding: 10px 12px;
            border-radius: 8px;
            border: 1px solid rgba(255,255,255,0.3);
            background: rgba(255,255,255,0.1);
            color: var(--text);
            font-size: 1rem;
            font-family: 'Roboto', sans-serif;
            resize: vertical;
            transition: border-color 0.3s;
        }

        form.add-room-form input[type="text"]:focus,
        form.add-room-form textarea:focus {
            outline: none;
            border-color: var(--secondary);
            background: rgba(255,255,255,0.15);
        }

        form.add-room-form button {
            width: 150px;
            padding: 12px;
            border: none;
            border-radius: 50px;
            background: var(--gradient);
            color: var(--text);
            font-weight: 600;
            font-size: 1rem;
            cursor: pointer;
            transition: transform 0.3s, box-shadow 0.3s;
            align-self: flex-start;
        }

        form.add-room-form button:hover {
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(184,151,0,0.5);
        }

        /* Responsive */
        @media (max-width: 600px) {
            .container {
                margin: 20px 15px;
                padding: 15px;
            }

            .title {
                font-size: 2rem;
            }

            .subtitle {
                font-size: 1.5rem;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <h1 class="title">Admin Panel - Manage Rooms</h1>

    <% if (error != null) { %>
    <div class="error"><%= error %></div>
    <% } %>

    <h2 class="subtitle">Current Rooms</h2>

    <% if (rooms != null && !rooms.isEmpty()) { %>
    <table class="rooms-table">
        <thead>
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Description</th>
            <th>Price</th>
        </tr>
        </thead>
        <tbody>
        <% for (model.Room room : rooms) { %>
        <tr>
            <td><%= room.getId() %></td>
            <td><%= room.getName() %></td>
            <td><%= room.getDescription() %></td>
            <td>$<%= String.format("%.2f", room.getPrice()) %></td>
        </tr>
        <% } %>
        </tbody>
    </table>

    <!-- Optional alternative display for smaller screens -->
    <div>
        <% for (model.Room room : rooms) { %>
        <p><strong><%= room.getId() %></strong> - <%= room.getName() %> - $<%= String.format("%.2f", room.getPrice()) %></p>
        <% } %>
    </div>

    <% } else { %>
    <p>No rooms available.</p>
    <% } %>




    <h2 class="subtitle">User Bookings</h2>

    <c:if test="${empty bookings}">
        <p>No bookings found.</p>
    </c:if>

    <c:if test="${not empty bookings}">
        <table class="rooms-table"> <!-- Reuse your rooms-table styling -->
            <thead>
            <tr>
                <th>Booking ID</th>
                <th>Room ID</th>
                <th>User</th>
                <th>Check-in</th>
                <th>Check-out</th>
                <th>Action</th>
            </tr>
            </thead>
            <tbody>
            <% for(Booking b : bookings) { %>
            <tr>
                <td><%= b.getBookingId() %></td>
                <td><%= b.getRoomId() %></td>
                <td><%= b.getUserEmail() %></td>
                <td><%= b.getCheckin() %></td>
                <td><%= b.getCheckout() %></td>
                <td>
                    <a href="<%= request.getContextPath() %>/userLogin/editBooking.jsp?bookingId=<%= b.getBookingId() %>">Edit</a>
                    <form action="deleteBooking" method="post" style="display:inline;">
                        <input type="hidden" name="bookingId" value="<%= b.getBookingId() %>" />
                        <button type="submit" onclick="return confirm('Are you sure you want to delete this booking?');">Delete</button>
                    </form>
                </td>
            </tr>
            <% } %>
            </tbody>
        </table>
    </c:if>
</div>
</body>
</html>