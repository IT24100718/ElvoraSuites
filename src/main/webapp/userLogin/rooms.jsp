<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="model.Room" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Elvora Suites - Available Rooms</title>
  <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css?v=1" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;700&family=Roboto:wght@300;400;500&display=swap" rel="stylesheet">
  <style>
    body {
      background-color: #1A2533;
      color: #F5F5F5;
      font-family: 'Roboto', sans-serif;
      scroll-behavior: smooth;
    }

    h1, h2, h3, h4 {
      font-family: 'Playfair Display', serif;
    }

    .nav {
      background: #0A1C3D;
      position: fixed;
      width: 100%;
      top: 0;
      z-index: 1000;
      box-shadow: 0 2px 5px rgba(0,0,0,0.3);
      display: flex;
      align-items: center;
      justify-content: space-between;
      padding: 0 20px;
    }

    .nav-logo {
      font-family: 'Playfair Display', serif;
      font-size: 24px;
      color: #B89700;
      position: relative;
    }

    .nav-logo::after {
      content: '';
      position: absolute;
      bottom: -2px;
      left: 0;
      width: 50%;
      height: 2px;
      background: #F5F5F5;
    }

    .nav a {
      color: #F5F5F5;
      transition: color 0.3s, transform 0.3s;
    }

    .nav a:hover {
      color: #B89700;
      transform: scale(1.1);
    }

    .room-card {
      transition: transform 0.3s, box-shadow 0.3s;
      background: rgba(255,255,255,0.1);
      border-radius: 12px;
      border: 1px solid rgba(255,255,255,0.2);
      padding: 20px;
      margin-bottom: 20px;
      box-shadow: 0 10px 20px rgba(0,0,0,0.4);
    }

    .room-card:hover {
      transform: translateY(-10px);
      box-shadow: 0 15px 30px rgba(0,0,0,0.4);
    }

    .button {
      background: linear-gradient(45deg, #0A1C3D, #B89700);
      color: #F5F5F5;
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

    .footer {
      background: #0A1C3D;
      color: #F5F5F5;
      padding: 40px 0;
    }

    .social-icons a {
      transition: color 0.3s, transform 0.3s;
      color: #F5F5F5;
    }

    .social-icons a:hover {
      color: #B89700;
      transform: scale(1.2);
    }

    @media (max-width: 768px) {
      .nav {
        flex-direction: column;
        padding: 10px;
      }
      .nav ul {
        flex-direction: column;
        margin-top: 10px;
      }
      .nav li {
        margin: 8px 0;
      }
      .nav-logo {
        margin-bottom: 10px;
      }
      .room-card {
        padding: 15px;
      }
    }
  </style>
</head>
<body>
<!-- Navigation -->
<nav class="nav py-4">
  <div class="nav-logo">Elvora Suites</div>
  <ul class="flex space-x-10">
    <li><a href="index.jsp" class="uppercase text-sm tracking-wide">Home</a></li>
    <li><a href="<%= request.getContextPath() %>/rooms" class="uppercase text-sm tracking-wide">Rooms</a></li>
    <li><a href="${pageContext.request.contextPath}/userLogin/book.jsp" class="uppercase text-sm tracking-wide">Book</a></li>
    <%
      String email = (String) session.getAttribute("email");
      if (email == null) {
    %>
    <li><a href="${pageContext.request.contextPath}/userLogin/login.jsp" class="uppercase text-sm tracking-wide">Login</a></li>
    <%
    } else {
    %>
    <li><a href="${pageContext.request.contextPath}/LogoutServlet" class="uppercase text-sm tracking-wide text-red-400">Logout</a></li>
    <%
      }
    %>
  </ul>
</nav>

<!-- Available Rooms Section -->
<div class="container mx-auto px-4 py-20 text-center">
  <h1 class="text-5xl font-bold mb-6 mt-20">Gallery & Rooms</h1>
  <h2 class="text-3xl font-bold mb-6 mt-10">Our Rooms</h2>

  <%
    List<Room> rooms = (List<Room>) request.getAttribute("rooms");
    Map<Integer, Boolean> availability = (Map<Integer, Boolean>) request.getAttribute("availability");

    if (rooms == null || rooms.isEmpty()) {
  %>
  <p>No rooms available at the moment.</p>
  <%
  } else {
  %>
  <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
    <% for (Room room : rooms) {
      String imgSrc = request.getContextPath() + "/userLogin/images/room-default.png";
      switch(room.getId()) {
        case 101: imgSrc = request.getContextPath() + "/userLogin/images/luxury-suite.png"; break;
        case 102: imgSrc = request.getContextPath() + "/userLogin/images/premier-room.png"; break;
        case 103: imgSrc = request.getContextPath() + "/userLogin/images/classic-room.png"; break;
      }

      boolean isAvailable = availability.getOrDefault(room.getId(), true);
    %>
    <div class="room-card">
      <img src="<%= imgSrc %>" alt="<%= room.getName() %>"
           class="mx-auto mb-4 rounded-lg object-cover h-48 w-full" />
      <h2 class="text-2xl font-bold mb-4"><%= room.getName() %></h2>
      <p class="mb-4"><%= room.getDescription() %></p>
      <p class="text-yellow-400 font-bold mb-2">$<%= String.format("%.2f", room.getPrice()) %> / night</p>
      <p class="<%= isAvailable ? "text-green-400" : "text-red-400" %> font-semibold mb-4">
        <%= isAvailable ? "Available for Booking" : "Currently Booked" %>
      </p>

      <% if (isAvailable) { %>
      <a href="<%= request.getContextPath() %>/BookServlet?id=<%= room.getId() %>" class="button">
        Book Now
      </a>
      <% } else { %>
      <button disabled class="bg-gray-600 text-white font-semibold py-2 px-4 rounded opacity-50 cursor-not-allowed">
        Not Available
      </button>
      <% } %>
    </div>
    <% } %>
  </div>
  <%
    }
  %>
</div>

<!-- Gallery Section -->
<div class="container mx-auto px-4 py-12 text-center">
  <h2 class="text-4xl font-bold mb-8">Gallery</h2>
  <div class="grid grid-cols-2 md:grid-cols-4 gap-6">
    <img src="<%= request.getContextPath() %>/userLogin/images/gallery1.png" alt="Gallery Image 1" class="rounded-lg object-cover w-full h-48" />
    <img src="<%= request.getContextPath() %>/userLogin/images/gallery2.png" alt="Gallery Image 2" class="rounded-lg object-cover w-full h-48" />
    <img src="<%= request.getContextPath() %>/userLogin/images/gallery3.png" alt="Gallery Image 3" class="rounded-lg object-cover w-full h-48" />
    <img src="<%= request.getContextPath() %>/userLogin/images/gallery4.png" alt="Gallery Image 4" class="rounded-lg object-cover w-full h-48" />
  </div>
</div>

<!-- Footer -->
<footer class="footer">
  <div class="container mx-auto px-4">
    <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
      <div>
        <h3 class="text-xl font-bold mb-4 nav-logo">Elvora Suites</h3>
        <p class="text-sm">Email: info@hotelrms.com</p>
        <p class="text-sm">Phone: +1 234 567 890</p>
        <p class="text-sm">Address: 123 Hotel St, City</p>
      </div>
      <div>
        <h3 class="text-xl font-bold mb-4">Quick Links</h3>
        <ul class="text-sm space-y-2">
          <li><a href="index.jsp" class="hover:text-amber-500">Home</a></li>
          <li><a href="${pageContext.request.contextPath}/userLogin/rooms.jsp" class="hover:text-amber-500">Rooms</a></li>
          <li><a href="${pageContext.request.contextPath}/userLogin/book.jsp" class="hover:text-amber-500">Book</a></li>
          <li><a href="${pageContext.request.contextPath}/userLogin/login.jsp" class="hover:text-amber-500">Login</a></li>
          <li><a href="${pageContext.request.contextPath}/userLogin/admin.jsp" class="hover:text-amber-500">Admin</a></li>
        </ul>
      </div>
      <div>
        <h3 class="text-xl font-bold mb-4">Follow Us</h3>
        <div class="flex space-x-4 social-icons">
          <a href="https://facebook.com/hotelrms" class="text-xl"><i class="fa-brands fa-facebook-f"></i></a>
          <a href="https://instagram.com/hotelrms" class="text-xl"><i class="fa-brands fa-instagram"></i></a>
          <a href="https://twitter.com/hotelrms" class="text-xl"><i class="fa-brands fa-twitter"></i></a>
        </div>
      </div>
    </div>
    <div class="mt-8 text-center text-sm">
      <p>© <%= new java.util.Date().getYear() + 1900 %> Elvora Suites. All rights reserved.</p>
    </div>
  </div>
</footer>

<!-- Font Awesome -->
<script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
</body>
</html>