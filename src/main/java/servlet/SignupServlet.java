package servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.*;
import java.util.Random;

public class SignupServlet extends HttpServlet {

    private static final String USERS_FILE_PATH = "C:\\Users\\PN Tech\\Desktop\\HotelRoomManagmentSystem 3\\src\\main\\webapp\\data\\users.txt";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("SignupServlet doPost invoked");

        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String fullName = request.getParameter("fullName");
        String phoneNumber = request.getParameter("phoneNumber") != null ? request.getParameter("phoneNumber") : "N/A";
        String address = request.getParameter("address") != null ? request.getParameter("address") : "N/A";

        System.out.println("Form parameters - username: " + username + ", email: " + email + ", password: " + (password != null ? "[REDACTED]" : "null"));

        if (username == null || email == null || password == null || fullName == null ||
                username.trim().isEmpty() || email.trim().isEmpty() || password.trim().isEmpty() || fullName.trim().isEmpty()) {
            System.out.println("Validation failed: Missing required fields");
            response.sendRedirect(request.getContextPath() + "/userLogin/Signup.jsp?error=All fields are required");
            return;
        }

        String userNumber = "US" + String.format("%010d", new Random().nextInt(1_000_000_000));

        String userEntry = String.format(
                "--- User Start: %s ---\n" +
                        "username=%s\n" +
                        "password=%s\n" +
                        "userNumber=%s\n" +
                        "fullName=%s\n" +
                        "email=%s\n" +
                        "phoneNumber=%s\n" +
                        "address=\"%s\"\n" +
                        "--- User End ---\n",
                userNumber, username, password, userNumber, fullName, email, phoneNumber, address
        );


        File file = new File(USERS_FILE_PATH);

        System.out.println("Attempting to write to: " + file.getAbsolutePath());

        try {
            file.getParentFile().mkdirs();
            System.out.println("Parent directory exists: " + file.getParentFile().exists());



            try (FileWriter fw = new FileWriter(file, true);
                 BufferedWriter bw = new BufferedWriter(fw)) {
                bw.write(userEntry);
                bw.flush();
                System.out.println("Successfully wrote: " + userEntry);
            }



            response.sendRedirect(request.getContextPath() + "/userLogin/success.jsp?type=signup");
        } catch (IOException e) {
            e.printStackTrace();
            System.out.println("IOException occurred: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/userLogin/Signup.jsp?error=Failed to save user data");
        }
    }
}