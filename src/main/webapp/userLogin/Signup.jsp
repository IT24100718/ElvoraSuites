<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Elvora Suites - Sign Up</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css?v=1" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css?v=1" rel="stylesheet">
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

        h1, h2, h3 {
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
            padding: 10px 15px;
            text-transform: uppercase;
            font-size: 14px;
            transition: color 0.3s, transform 0.3s;
        }

        .nav a:hover {
            color: var(--secondary);
            transform: scale(1.1);
        }

        .form-container {
            background: rgba(255,255,255,0.1);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255,255,255,0.2);
            border-radius: 12px;
            padding: 2rem;
        }

        .form-container input {
            background: var(--primary);
            color: var(--text);
            border: 1px solid rgba(255,255,255,0.2);
            border-radius: 8px;
            padding: 0.75rem;
            width: 100%;
        }

        .form-container input:focus {
            border-color: var(--secondary);
            outline: none;
        }

        .button {
            background: var(--gradient);
            color: var(--text);
            padding: 12px 24px;
            border-radius: 50px;
            transition: transform 0.3s, box-shadow 0.3s;
            font-weight: 500;
            text-transform: uppercase;
            width: 100%;
            text-align: center;
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
            .nav {
                flex-direction: column;
                padding: 10px;
            }
            .nav ul {
                flex-direction: column;
                margin-top: 10px;
            }
            .nav ul li {
                margin: 5px 0;
            }
            .nav-logo {
                margin-bottom: 10px;
            }
            .form-container {
                padding: 1.5rem;
            }
        }
    </style>
</head>
<body>
<!-- Navigation -->
<nav class="nav">
    <div class="nav-logo">Elvora Suites</div>
    <ul class="flex space-x-10">
        <li><a href="${pageContext.request.contextPath}/index.jsp">Home</a></li>
        <li><a href="${pageContext.request.contextPath}/rooms">Rooms</a></li>
        <li><a href="${pageContext.request.contextPath}/userLogin/book.jsp">Book</a></li>
        <li><a href="${pageContext.request.contextPath}/userLogin/login.jsp">Login</a></li>
        <li><a href="${pageContext.request.contextPath}/userLogin/Signup.jsp">Sign Up</a></li>
    </ul>
</nav>

<!-- Sign Up Section -->
<div class="container mx-auto px-4 py-20">
    <h2 class="text-4xl text-center font-bold mb-12 text-[var(--secondary)]">Sign Up</h2>
    <form action="${pageContext.request.contextPath}/SignupServlet" method="post" class="max-w-md mx-auto form-container">
        <div class="mb-6">
            <label class="block text-[var(--text)] font-medium mb-2">Username</label>
            <input type="text" name="username" class="w-full" required>
        </div>
        <div class="mb-6">
            <label class="block text-[var(--text)] font-medium mb-2">Full Name</label>
            <input type="text" name="fullName" class="w-full" required>
        </div>
        <div class="mb-6">
            <label class="block text-[var(--text)] font-medium mb-2">Email</label>
            <input type="email" name="email" class="w-full" required>
        </div>
        <div class="mb-6">
            <label class="block text-[var(--text)] font-medium mb-2">Password</label>
            <input type="password" name="password" class="w-full" required>
        </div>
        <div class="mb-6">
            <label class="block text-[var(--text)] font-medium mb-2">Phone Number</label>
            <input type="text" name="phoneNumber" class="w-full">
        </div>
        <div class="mb-6">
            <label class="block text-[var(--text)] font-medium mb-2">Address</label>
            <input type="text" name="address" class="w-full">
        </div>
        <button type="submit" class="button">Sign Up</button>
        <p class="mt-4 text-center text-[var(--text)]">Already have an account? <a href="${pageContext.request.contextPath}/userLogin/login.jsp" class="text-[var(--secondary)] hover:underline">Login</a></p>
    </form>
</div>

<!-- Footer -->
<footer class="footer">
    <div class="container mx-auto px-4">
        <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
            <div>
                <h3 class="text-xl font-bold mb-4 text-[var(--secondary)]">Elvora Suites</h3>
                <p class="text-sm">Email: info@hotelrms.com</p>
                <p class="text-sm">Phone: +1 234 567 890</p>
                <p class="text-sm">Address: 123 Hotel St, City</p>
            </div>
            <div>
                <h3 class="text-xl font-bold mb-4 text-[var(--secondary)]">Quick Links</h3>
                <ul class="text-sm space-y-2">
                    <li><a href="${pageContext.request.contextPath}/index.jsp" class="hover:text-[var(--secondary)]">Home</a></li>
                    <li><a href="${pageContext.request.contextPath}/rooms" class="hover:text-[var(--secondary)]">Rooms</a></li>
                    <li><a href="${pageContext.request.contextPath}/userLogin/book.jsp" class="hover:text-[var(--secondary)]">Book</a></li>
                    <li><a href="${pageContext.request.contextPath}/userLogin/login.jsp" class="hover:text-[var(--secondary)]">Login</a></li>
                    <li><a href="${pageContext.request.contextPath}/userLogin/admin.jsp" class="hover:text-[var(--secondary)]">Admin</a></li>
                </ul>
            </div>
            <div>
                <h3 class="text-xl font-bold mb-4 text-[var(--secondary)]">Follow Us</h3>
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
</body>
</html>