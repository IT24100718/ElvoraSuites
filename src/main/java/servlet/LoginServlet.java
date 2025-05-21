package servlet;

import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import model.User;

public class LoginServlet extends HttpServlet {

//    private static final String USERS_FILE_PATH = "/Users/sithijavithanage/Desktop/HotelRoomManagmentSystem 2/src/main/webapp/data/users.txt";



    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws  IOException {
        System.out.println("LoginServlet doPost invoked");

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Validate required fields
        if (email == null || password == null || email.trim().isEmpty() || password.trim().isEmpty()) {
            System.out.println("Validation failed: Missing required fields");
            String redirectUrl = request.getContextPath() + "/userLogin/login.jsp?error=Email+and+password+are+required";
            System.out.println("Redirecting to: " + redirectUrl);
            response.sendRedirect(redirectUrl);
            return;
        }

        // Load users from the file
        Map<String, User> users = loadUsers(request);
        if (users == null) {
            System.out.println("Error loading user credentials");
            String redirectUrl = request.getContextPath() + "/userLogin/login.jsp?error=Error+loading+user+data";
            System.out.println("Redirecting to: " + redirectUrl);
            response.sendRedirect(redirectUrl);
            return;
        }

        User user = users.get(email);
        // Validate user credentials
        if (user != null && user.getPassword().equals(password)) {
            HttpSession session = request.getSession();
            request.getSession().setAttribute("email", email);
            session.setAttribute("userRole", user.getRole());


            if ("admin".equalsIgnoreCase(user.getRole())) {
                response.sendRedirect(request.getContextPath() + "/admin");
            } else {
                response.sendRedirect(request.getContextPath() + "/userLogin/success.jsp?type=login");
            }
        } else {
            // Login failed
            String redirectUrl = request.getContextPath() + "/userLogin/login.jsp?error=Invalid+email+or+password";
            System.out.println("Redirecting to: " + redirectUrl);
            response.sendRedirect(redirectUrl);
        }
    }

    private Map<String, User> loadUsers(HttpServletRequest request) {
        Map<String, User> users = new HashMap<>();
        String filePath = "/Users/sithijavithanage/Desktop/HotelRoomManagmentSystem 2/src/main/webapp/data/users.txt";
        System.out.println("File path is: " + filePath);
        System.out.println("Attempting to load users.txt from: " + filePath);
        File file = new File(filePath);
        if (!file.exists()) {
            System.out.println("User data file not found: " + filePath);
            return null;
        }

        try (BufferedReader br = new BufferedReader(new FileReader(file))) {
            String line;
            Map<String, String> userData = null;

            while ((line = br.readLine()) != null) {
                line = line.trim();
                if (line.startsWith("--- User Start:")) {
                    userData = new HashMap<>();
                } else if (line.startsWith("--- User End ---")) {
                    if (userData != null) {
                        // Get needed fields
                        String email = userData.get("email");
                        String password = userData.get("password");
                        String role = userData.getOrDefault("role", "user");  // default role "user" if missing

                        if (email != null && password != null) {
                            users.put(email, new User(email, password, role));
                        }
                        userData = null; // reset for next user
                    }
                } else if (userData != null && line.contains("=")) {
                    int idx = line.indexOf('=');
                    String key = line.substring(0, idx).trim();
                    String value = line.substring(idx + 1).trim();
                    userData.put(key, value);
                }
            }
            System.out.println("Loaded user credentials: " + users.keySet());
        } catch (IOException e) {
            e.printStackTrace();
            System.out.println("Error reading users file: " + e.getMessage());
            return null;
        }
        return users;
    }
}