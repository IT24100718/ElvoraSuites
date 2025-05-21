<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Elvora Suites - Luxury Retreat</title>
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

    .header {
      position: relative;
      height: 700px;
      background-size: cover;
      background-position: center;
      animation: slideshow 20s infinite;
      display: flex;
      align-items: center;
      justify-content: center;
      text-align: center;
      background-attachment: fixed;
    }

    @keyframes slideshow {
      0% { background-image: linear-gradient(rgba(0,0,0,0.7), rgba(0,0,0,0.7)), url('https://images.unsplash.com/photo-1542314831-068cd1dbfeeb?ixlib=rb-4.0.3&auto=format&fit=crop&w=1350&q=80'); }
      33% { background-image: linear-gradient(rgba(0,0,0,0.7), rgba(0,0,0,0.7)), url('https://images.unsplash.com/photo-1596394516093-501ba68a0ba6?ixlib=rb-4.0.3&auto=format&fit=crop&w=1350&q=80'); }
      66% { background-image: linear-gradient(rgba(0,0,0,0.7), rgba(0,0,0,0.7)), url('https://img.freepik.com/free-photo/type-entertainment-complex-popular-resort-with-pools-water-parks-turkey-with-more-than-5-million-visitors-year-amara-dolce-vita-luxury-hotel-resort-tekirova-kemer_146671-18728.jpg?ga=GA1.1.17822861.1741097572&semt=ais_hybrid&w=740'); }
      100% { background-image: linear-gradient(rgba(0,0,0,0.7), rgba(0,0,0,0.7)), url('https://images.unsplash.com/photo-1600585154340-be6161a56a0c?ixlib=rb-4.0.3&auto=format&fit=crop&w=1350&q=80'); }
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
      transition: color 0.3s, transform?) 0.3s;
    }

    .nav a:hover {
      color: var(--secondary);
      transform: scale(1.1);
    }

    .room-card {
      transition: transform 0.3s, box-shadow 0.3s;
      background: rgba(255,255,255,0.1);
      border-radius: 12px;
      overflow: hidden;
      backdrop-filter: blur(10px);
      border: 1px solid rgba(255,255,255,0.2);
    }

    .room-card:hover {
      transform: translateY(-10px);
      box-shadow: 0 15px 30px rgba(0,0,0,0.4), 0 0 10px var(--secondary);
    }

    .gallery-img {
      transition: transform 0.3s;
      border-radius: 12px;
    }

    .gallery-img:hover {
      transform: scale(1.05);
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
      padding: 10px 20px;
      border-radius: 50px;
      transition: all 0.3s;
      text-transform: uppercase;
    }

    .secondary-button:hover {
      background: var(--secondary);
      color: var(--primary);
    }

    .footer {
      background: var(--primary);
      color: var(--text);
      padding: 40px 0;
    }

    .section {
      display: none;
      animation: fadeIn 1s ease-in;
    }

    .section.active {
      display: block;
    }

    @keyframes fadeIn {
      from { opacity: 0; transform: translateY(20px); }
      to { opacity: 1; transform: translateY(0); }
    }

    .social-icons a {
      transition: color 0.3s, transform 0.3s;
      color: var(--text);
    }

    .social-icons a:hover {
      color: var(--secondary);
      transform: scale(1.2);
    }

    .back-to-top {
      position: fixed;
      bottom: 80px;
      right: 20px;
      background: var(--gradient);
      color: var(--text);
      width: 50px;
      height: 50px;
      border-radius: 50%;
      display: flex;
      align-items: center;
      justify-content: center;
      opacity: 0;
      transition: opacity 0.3s;
    }

    .back-to-top.show {
      opacity: 1;
    }

    .chat-bot {
      position: fixed;
      bottom: 20px;
      right: 20px;
      z-index: 1000;
    }

    .chat-button {
      background: var(--gradient);
      color: var(--text);
      width: 60px;
      height: 60px;
      border-radius: 50%;
      display: flex;
      align-items: center;
      justify-content: center;
      box-shadow: 0 5px 15px rgba(0,0,0,0.3);
      cursor: pointer;
    }

    .chat-window {
      display: none;
      position: absolute;
      bottom: 80px;
      right: 0;
      width: 300px;
      background: rgba(255,255,255,0.1);
      backdrop-filter: blur(10px);
      border: 1px solid rgba(255,255,255,0.2);
      border-radius: 12px;
      box-shadow: 0 10px 20px rgba(0,0,0,0.4);
      overflow: hidden;
    }

    .chat-window.active {
      display: block;
    }

    .chat-header {
      background: var(--primary);
      color: var(--text);
      padding: 10px;
      text-align: center;
      font-weight: 500;
    }

    .chat-body {
      padding: 10px;
      max-height: 300px;
      overflow-y: auto;
      color: var(--text);
    }

    .chat-message {
      margin-bottom: 10px;
      padding: 8px 12px;
      border-radius: 8px;
    }

    .chat-message.bot {
      background: var(--secondary);
      color: var(--primary);
      margin-left: 10%;
    }

    .chat-message.user {
      background: var(--primary);
      color: var(--text);
      margin-right: 10%;
      text-align: right;
    }

    .chat-input {
      display: flex;
      padding: 10px;
      background: var(--primary);
    }

    .chat-input input {
      flex: 1;
      padding: 8px;
      border: none;
      border-radius: 20px 0 0 20px;
      outline: none;
      background: var(--text);
      color: var(--primary);
    }

    .chat-input button {
      padding: 8px 12px;
      border: none;
      background: var(--secondary);
      color: var(--primary);
      border-radius: 0 20px 20px 0;
      cursor: pointer;
    }

    @media (max-width: 768px) {
      .header { height: 500px; }
      .nav { flex-direction: column; padding: 10px; }
      .nav ul { flex-direction: column; space-x-0; space-y-4; margin-top: 10px; }
      .nav-logo { margin-bottom: 10px; }
      .room-card { margin-bottom: 20px; }
      .chat-window { width: 90%; }
    }
  </style>
</head>
<body>
<!-- Navigation -->
<div class="nav py-4">
  <div class="nav-logo">Hotel Room Management System</div>
  <ul class="flex space-x-10">
    <li><a href="index.jsp" class="uppercase text-sm tracking-wide">Home</a></li>
    <li><a href="rooms.jsp" class="uppercase text-sm tracking-wide">Rooms</a></li>
    <li><a href="book.jsp" class="uppercase text-sm tracking-wide">Book</a></li>
    <li><a href="login.jsp" class="uppercase text-sm tracking-wide">Login</a></li>
    <li><a href="signup.jsp" class="uppercase text-sm tracking-wide">Sign Up</a></li>
    <li><a href="admin.jsp" class="uppercase text-sm tracking-wide">Admin</a></li>
  </ul>
</div>

<!-- Forgot Password Section -->
<!-- Forgot Password Section -->
<div class="container mx-auto px-4 py-20">
  <h2 class="text-4xl text-center font-bold mb-12">Forgot Password</h2>
  <form action="${pageContext.request.contextPath}/ForgotPasswordServlet" method="post" class="max-w-md mx-auto bg-white bg-opacity-10 p-8 rounded-lg shadow-lg" onsubmit="return validateForm()">
    <div class="mb-6">
      <label class="block text-gray-200 font-medium mb-2">Email Address</label>
      <input type="email" name="email" class="w-full p-3 border rounded-lg focus:outline-none focus:ring-2 focus:ring-amber-500 bg-gray-800 text-gray-200" placeholder="johndoe@example.com" required>

      <label class="block text-gray-200 font-medium mb-2 mt-4">New Password</label>
      <input type="password" name="password" id="password" class="w-full p-3 border rounded-lg focus:outline-none focus:ring-2 focus:ring-amber-500 bg-gray-800 text-gray-200" placeholder="New Password" required>

      <label class="block text-gray-200 font-medium mb-2 mt-4">Confirm Password</label>
      <input type="password" name="confirmPassword" id="confirmPassword" class="w-full p-3 border rounded-lg focus:outline-none focus:ring-2 focus:ring-amber-500 bg-gray-800 text-gray-200" placeholder="Confirm Password" required>
    </div>
    <p id="errorMessage" class="text-red-500 text-center hidden">Passwords do not match!</p>
    <button type="submit" class="button w-full mt-4">Confirm</button>
    <p class="mt-4 text-center text-gray-400">Back to <a href="login.jsp" class="text-amber-500 hover:underline">Log in</a></p>
    <%
      String error = (String) request.getAttribute("error");
      if (error != null) {
    %>
    <p class="text-red-500 text-center mt-4"><%= error %></p>
    <%
      }
    %>
  </form>
</div>

<script>
  function validateForm() {
    const password = document.getElementById('password').value;
    const confirmPassword = document.getElementById('confirmPassword').value;
    const errorMessage = document.getElementById('errorMessage');

    if (password !== confirmPassword) {
      errorMessage.classList.remove('hidden');
      return false;
    }
    errorMessage.classList.add('hidden');
    return true;
  }
</script>

<!-- Footer -->
<div class="footer">
  <div class="container mx-auto px-4">
    <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
      <div>
        <h3 class="text-xl font-bold mb-4 nav-logo">Hotel Room Management System</h3>
        <p class="text-sm">Email: info@hotelrms.com</p>
        <p class="text-sm">Phone: +1 234 567 890</p>
        <p class="text-sm">Address: 123 Hotel St, City</p>
      </div>
      <div>
        <h3 class="text-xl font-bold mb-4">Quick Links</h3>
        <ul class="text-sm space-y-2">
          <li><a href="index.jsp" class="hover:text-amber-500">Home</a></li>
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
      <p>© <%= new java.util.Date().getYear() + 1900 %> Hotel Room Management System. All rights reserved.</p>
    </div>
  </div>
</div>

<!-- Font Awesome -->
<script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
</body>
</html>