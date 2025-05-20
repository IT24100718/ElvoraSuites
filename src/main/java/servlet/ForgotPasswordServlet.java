package servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class ForgotPasswordServlet extends HttpServlet {

    private static final String USERS_FILE_PATH = "/Users/sithijavithanage/Desktop/HotelRoomManagmentSystem 3/src/main/webapp/data/users.txt";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("[ForgotPasswordServlet] doPost invoked");

        String email = request.getParameter("email");
        String newPassword = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        if (isNullOrEmpty(email)) {
            redirectWithError(response, request, "Email is required");
            return;
        }
        if (isNullOrEmpty(newPassword)) {
            redirectWithError(response, request, "Password is required");
            return;
        }
        if (!newPassword.equals(confirmPassword)) {
            redirectWithError(response, request, "Passwords do not match");
            return;
        }

        File userFile = new File(USERS_FILE_PATH);
        if (!userFile.exists()) {
            System.out.println("[Error] User file not found: " + USERS_FILE_PATH);
            redirectWithError(response, request, "User data file not found");
            return;
        }

        boolean userFound = false;
        List<String> updatedFileContent = new ArrayList<>();

        try (BufferedReader reader = new BufferedReader(new FileReader(userFile))) {
            String line;
            boolean insideUserBlock = false;
            StringBuilder userBlock = new StringBuilder();

            while ((line = reader.readLine()) != null) {
                if (line.startsWith("--- User Start:")) {
                    insideUserBlock = true;
                    userBlock = new StringBuilder();
                    userBlock.append(line).append("\n");
                } else if (line.startsWith("--- User End ---")) {
                    userBlock.append(line).append("\n");
                    insideUserBlock = false;

                    if (userBlock.toString().contains("email=" + email)) {
                        userFound = true;
                        String updatedUserBlock = userBlock.toString().replaceAll(
                                "password=.*?\\n", "password=" + newPassword + "\n"
                        );
                        updatedFileContent.add(updatedUserBlock);
                    } else {
                        updatedFileContent.add(userBlock.toString());
                    }
                } else if (insideUserBlock) {
                    userBlock.append(line).append("\n");
                } else {
                    updatedFileContent.add(line + "\n");
                }
            }

        } catch (IOException e) {
            e.printStackTrace();
            redirectWithError(response, request, "Error reading user data");
            return;
        }

        if (!userFound) {
            System.out.println("[Info] Email not found: " + email);
            redirectWithError(response, request, "Email not found");
            return;
        }

        try (BufferedWriter writer = new BufferedWriter(new FileWriter(userFile))) {
            for (String block : updatedFileContent) {
                writer.write(block);
            }
            System.out.println("[Success] Password updated for: " + email);
        } catch (IOException e) {
            e.printStackTrace();
            redirectWithError(response, request, "Error updating password");
            return;
        }

        response.sendRedirect(request.getContextPath() + "/userLogin/login.jsp?success=Password reset successfully");
    }

    private boolean isNullOrEmpty(String str) {
        return str == null || str.trim().isEmpty();
    }

    private void redirectWithError(HttpServletResponse response, HttpServletRequest request, String message) throws IOException {
        response.sendRedirect(request.getContextPath() + "/userLogin/forgotPassword.jsp?error=" + message);
    }
}
