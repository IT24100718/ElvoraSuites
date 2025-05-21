<%@ page import="model.Booking" %>
<%@ page import="java.util.List" %>
<%
  int bookingId = Integer.parseInt(request.getParameter("bookingId"));
  List<Booking> bookings = (List<Booking>) application.getAttribute("bookings");

  Booking bookingToEdit = null;
  for (Booking b : bookings) {
    if (b.getBookingId() == bookingId) {
      bookingToEdit = b;
      break;
    }
  }

  if (bookingToEdit == null) {
    out.println("Booking not found!");
    return;
  }
%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Edit Booking</title>
  <style>
    :root {
      --primary: #0A1C3D;
      --secondary: #B89700;
      --background: #1A2533;
      --text: #F5F5F5;
      --gradient: linear-gradient(45deg, #0A1C3D, #B89700);
    }

    body {
      background-color: var(--background);
      color: var(--text);
      font-family: 'Roboto', sans-serif;
      margin: 0;
      padding: 0;
    }

    h1, h2 {
      font-family: 'Playfair Display', serif;
      color: var(--secondary);
      text-align: center;
    }

    .container {
      max-width: 600px;
      margin: 50px auto;
      padding: 30px;
      background: rgba(255, 255, 255, 0.08);
      border-radius: 12px;
      box-shadow: 0 15px 30px rgba(0,0,0,0.4), 0 0 10px var(--secondary);
      backdrop-filter: blur(10px);
    }

    form {
      display: flex;
      flex-direction: column;
      gap: 15px;
    }

    input[type="text"],
    input[type="email"],
    input[type="number"],
    input[type="date"] {
      padding: 10px 12px;
      border-radius: 8px;
      border: 1px solid rgba(255,255,255,0.3);
      background: rgba(255,255,255,0.1);
      color: var(--text);
      font-size: 1rem;
      font-family: 'Roboto', sans-serif;
    }

    input[type="submit"] {
      padding: 12px;
      border: none;
      border-radius: 50px;
      background: var(--gradient);
      color: var(--text);
      font-weight: 600;
      font-size: 1rem;
      cursor: pointer;
      transition: transform 0.3s, box-shadow 0.3s;
    }

    input[type="submit"]:hover {
      transform: translateY(-2px);
      box-shadow: 0 5px 15px rgba(184,151,0,0.5);
    }
  </style>
</head>
<body>
<div class="container">
  <h2>Edit Booking</h2>
  <form method="post" action="${pageContext.request.contextPath}/updateBooking">
    <input type="hidden" name="bookingId" value="<%= bookingToEdit.getBookingId() %>">

    <label>Email:</label>
    <input type="email" name="userEmail" value="<%= bookingToEdit.getUserEmail() %>" required>

    <label>Room ID:</label>
    <input type="number" name="roomId" value="<%= bookingToEdit.getRoomId() %>" required>

    <label>Check-in:</label>
    <input type="date" name="checkin" value="<%= bookingToEdit.getCheckin() %>" required>

    <label>Check-out:</label>
    <input type="date" name="checkout" value="<%= bookingToEdit.getCheckout() %>" required>

    <input type="submit" value="Update Booking">
  </form>
</div>
</body>
</html>
