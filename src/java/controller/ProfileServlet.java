package controller;

import dal.UserDAO;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;

@WebServlet(name = "ProfileServlet", urlPatterns = {"/profile"})
public class ProfileServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Check if user is logged in
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            // Redirect to login if not logged in
            response.sendRedirect("login");
            return;
        }
        
        // Get fresh user data from database
        UserDAO userDAO = new UserDAO();
        User freshUserData = userDAO.getUserById(user.getId());
        
        if (freshUserData != null) {
            request.setAttribute("userProfile", freshUserData);
        } else {
            request.setAttribute("userProfile", user);
        }
        
        // Forward to profile page
        request.getRequestDispatcher("profile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Check if user is logged in
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            // Redirect to login if not logged in
            response.sendRedirect("login");
            return;
        }
        
        // Get parameters
        String email = request.getParameter("email");
        String phoneNumber = request.getParameter("phoneNumber");
        String gender = request.getParameter("gender");
        String dobString = request.getParameter("dob");
        String studentID = request.getParameter("studentID");
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");
        
        // Create user object for update
        User updatedUser = new User();
        updatedUser.setId(user.getId());
        updatedUser.setUsername(user.getUsername());
        updatedUser.setEmail(email);
        updatedUser.setPhoneNumber(phoneNumber);
        updatedUser.setGender(gender);
        updatedUser.setStudentID(studentID);
        
        // Parse date of birth
        if (dobString != null && !dobString.trim().isEmpty()) {
            try {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                Date dob = sdf.parse(dobString);
                updatedUser.setDob(dob);
            } catch (ParseException e) {
                System.out.println("Error parsing date: " + e.getMessage());
            }
        }
        
        // Validate and handle password change if requested
        boolean passwordChanged = false;
        if (currentPassword != null && !currentPassword.trim().isEmpty() &&
            newPassword != null && !newPassword.trim().isEmpty() &&
            confirmPassword != null && !confirmPassword.trim().isEmpty()) {
            
            // Verify current password
            UserDAO userDAO = new UserDAO();
            if (userDAO.verifyPassword(user.getId(), currentPassword)) {
                // Check if new passwords match
                if (newPassword.equals(confirmPassword)) {
                    updatedUser.setPassword(newPassword);
                    passwordChanged = true;
                } else {
                    request.setAttribute("passwordError", "New passwords do not match");
                }
            } else {
                request.setAttribute("passwordError", "Current password is incorrect");
            }
        }
        
        // Update user profile
        UserDAO userDAO = new UserDAO();
        boolean success = userDAO.updateUserProfile(updatedUser, passwordChanged);
        
        if (success) {
            // Update session user data
            User updatedSessionUser = userDAO.getUserById(user.getId());
            session.setAttribute("user", updatedSessionUser);
            
            request.setAttribute("successMessage", "Profile updated successfully");
        } else {
            request.setAttribute("errorMessage", "Failed to update profile");
        }
        
        // Get fresh user data
        User freshUserData = userDAO.getUserById(user.getId());
        request.setAttribute("userProfile", freshUserData);
        
        // Forward back to profile page
        request.getRequestDispatcher("profile.jsp").forward(request, response);
    }
}