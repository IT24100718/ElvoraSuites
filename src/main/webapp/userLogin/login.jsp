<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Elvora Suites - Login</title>
  <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;700&family=Roboto:wght@300;400;500&display=swap" rel="stylesheet">
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
      scroll-behavior: smooth;
    }
    h1, h2, h3, h4 {
      font-family: 'Playfair Display', serif;
    }
    .nav {
      background: var(--primary);
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
      color: var(--secondary);
      position: relative;
    }
    .nav-logo::after {
      content: '';
      position: absolute;
      bottom: -2px;
      left: 0;
      width: 50%;
      height: 2px;
      background: var(--text);
    }
    .nav ul {
      display: flex;
      justify-content: center;
      flex-grow: 1;
    }
    .nav a {
      color: var(--text);
      transition: color 0.3s, transform 0.3s;
    }
    .nav a:hover {
      color: var(--secondary);
      transform: scale(1.1);
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
    .footer {
      background: var(--primary);
      color: var(--text);
      padding: 40px 0;
    }
    .social-icons a {
      transition: color 0.3s, transform 0.3s;
      color: var(--text);
    }
    .social-icons a:hover {
      color: var(--secondary);
      transform: scale(1.2);
    }
    @media (max-width: 768px) {
      .nav { flex-direction: column; padding: 10px; }
      .nav ul { flex-direction: column;  margin-top: 10px; }
      .nav-logo { margin-bottom: 10px; }
    }
  </style>
</head>
<body>
<!-- Navigation -->
<div class="nav py-4">
  <div class="nav-logo">Elvora Suites</div>
  <ul class="flex space-x-10">
    <li><a href="../index.jsp" class="uppercase text-sm tracking-wide">Home</a></li>
    <li><a href="<%= request.getContextPath() %>/rooms" class="uppercase text-sm tracking-wide">Rooms</a></li>
    <li><a href="${pageContext.request.contextPath}/userLogin/book.jsp" class="uppercase text-sm tracking-wide">Book</a></li>
    <li><a href="${pageContext.request.contextPath}/userLogin/login.jsp" class="uppercase text-sm tracking-wide">Login</a></li>
    <li><a href="${pageContext.request.contextPath}/userLogin/Signup.jsp" class="uppercase text-sm tracking-wide">Sign Up</a></li>
  </ul>
</div>

<!-- Login Section -->
<div class="container mx-auto px-4 py-20">
  <h2 class="text-4xl text-center font-bold mb-12">Login</h2>
  <% String error = request.getParameter("error"); %>
  <% if (error != null) { %>
  <div class="max-w-md mx-auto mb-6 p-4 bg-red-600 bg-opacity-75 text-white rounded-lg">
    <%= error %>
  </div>
  <% } %>
  <form action="${pageContext.request.contextPath}/LoginServlet" method="post" class="max-w-md mx-auto bg-white bg-opacity-10 p-8 rounded-lg shadow-lg">
    <div class="mb-6">
      <label class="block text-gray-200 font-medium mb-2">Email</label>
      <input type="email" name="email" class="w-full p-3 border rounded-lg focus:outline-none focus:ring-2 focus:ring-amber-500 bg-gray-800 text-gray-200" required>
    </div>
    <div class="mb-6">
      <label class="block text-gray-200 font-medium mb-2">Password</label>
      <input type="password" name="password" class="w-full p-3 border rounded-lg focus:outline-none focus:ring-2 focus:ring-amber-500 bg-gray-800 text-gray-200" required>
      <p class="mt-2 text-left text-gray-400">
        <a href="forgotPassword.jsp" class="text-amber-500 hover:underline">Forgot Password?</a>
      </p>
    </div>
    <button type="submit" class="button w-full">Login</button>
    <p class="mt-4 text-center text-gray-400">Don't have an account? <a href="Signup.jsp" class="text-amber-500 hover:underline">Sign Up</a></p>
  </form>
</div>

<!-- Footer -->
<div class="footer">
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
          <li><a href="../index.jsp" class="hover:text-amber-500">Home</a></li>
          <li><a href="rooms.jsp" class="hover:text-amber-500">Rooms</a></li>
          <li><a href="book.jsp" class="hover:text-amber-500">Book</a></li>
          <li><a href="login.jsp" class="hover:text-amber-500">Login</a></li>
          <li><a href="admin.jsp" class="hover:text-amber-500">Admin</a></li>
        </ul>
      </div>
      <div>
        <h3 class="text-xl font-bold mb-4">Follow Us</h3>
        <div class="social-icons flex space-x-4">
          <a href="#" class="text-xl"><i class="fab fa-facebook-f"></i></a>
          <a href="#" class="text-xl"><i class="fab fa-instagram"></i></a>
          <a href="#" class="text-xl"><i class="fab fa-twitter"></i></a>
        </div>
      </div>
    </div>
    <div class="mt-8 text-center text-sm">
      <p>© <%= new java.util.Date().getYear() + 1900 %> Elvora Suites. All rights reserved.</p>
    </div>
  </div>
</div>

<!-- Font Awesome -->
<script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
</body>
</html>