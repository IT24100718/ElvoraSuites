package servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.annotation.WebServlet;
import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class ResetPasswordServlet extends HttpServlet {
    private static final String USERS_FILE = "/Users/sithijavithanage/Desktop/HotelRoomManagmentSystem 3/src/main/webapp/data/users.txt";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String newPassword = request.getParameter("password");

        // Validate input
        if (email == null || newPassword == null || email.isEmpty() || newPassword.isEmpty()) {
            String redirectUrl = request.getContextPath() + "/userLogin/login.jsp?error=Email+and+password+are+required";
            response.sendRedirect(redirectUrl);
            return;
        }

        // Get the path to users.txt
        String usersFilePath = getServletContext().getRealPath(USERS_FILE);
        if (usersFilePath == null) {
            String redirectUrl = request.getContextPath() + "/userLogin/login.jsp?error=User+data+file+not+found";
            response.sendRedirect(redirectUrl);
            return;
        }

        // Check if the file exists
        File file = new File(usersFilePath);
        if (!file.exists()) {
            String redirectUrl = request.getContextPath() + "/userLogin/login.jsp?error=User+data+file+not+found";
            response.sendRedirect(redirectUrl);
            return;
        }

        boolean userFound = false;
        List<String> fileLines = new ArrayList<>();
        StringBuilder userBlock = new StringBuilder();
        boolean inUserBlock = false;

        // Read the users.txt file
        try (BufferedReader reader = new BufferedReader(new FileReader(usersFilePath))) {
            String line;
            while ((line = reader.readLine()) != null) {
                if (line.startsWith("--- User Start:")) {
                    userBlock = new StringBuilder();
                    inUserBlock = true;
                    userBlock.append(line).append("\n");
                } else if (line.startsWith("--- User End ---")) {
                    userBlock.append(line).append("\n");
                    inUserBlock = false;

                    // Check if this user block matches the email
                    if (userBlock.toString().contains("email=" + email)) {
                        userFound = true;
                        // Replace the password line
                        String updatedBlock = userBlock.toString().replaceAll(
                                "password=.*?\n", "password=" + newPassword + "\n"
                        );
                        fileLines.add(updatedBlock);
                    } else {
                        fileLines.add(userBlock.toString());
                    }
                } else if (inUserBlock) {
                    userBlock.append(line).append("\n");
                } else {
                    fileLines.add(line + "\n");
                }
            }
        } catch (IOException e) {
            String redirectUrl = request.getContextPath() + "/userLogin/login.jsp?error=Error+reading+user+data";
            response.sendRedirect(redirectUrl);
            return;
        }

        // Check if user was found
        if (!userFound) {
            String redirectUrl = request.getContextPath() + "/userLogin/login.jsp?error=No+user+found+with+the+provided+email";
            response.sendRedirect(redirectUrl);
            return;
        }

        // Write the updated content back to users.txt
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(usersFilePath))) {
            for (String line : fileLines) {
                writer.write(line);
            }
        } catch (IOException e) {
            String redirectUrl = request.getContextPath() + "/userLogin/login.jsp?error=Error+updating+user+data";
            response.sendRedirect(redirectUrl);
            return;
        }

        // Redirect to login page with success message
        String redirectUrl = request.getContextPath() + "/userLogin/login.jsp?message=Password+reset+successfully.+Please+log+in";
        response.sendRedirect(redirectUrl);
    }
}