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
import model.User;

@WebServlet(name = "RegisterServlet", urlPatterns = {"/register"})
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Forward to register page
        request.getRequestDispatcher("register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Get parameters
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String email = request.getParameter("email");
        String phoneNumber = request.getParameter("phoneNumber");
        String gender = request.getParameter("gender");
        String dobString = request.getParameter("dob");
        String studentId = request.getParameter("studentID");
        String identityCard = request.getParameter("identityCard");
        
        // Validate input
        boolean hasError = false;
        
        if (username == null || username.trim().isEmpty()) {
            request.setAttribute("usernameError", "Username is required");
            hasError = true;
        }
        
        if (password == null || password.trim().isEmpty()) {
            request.setAttribute("passwordError", "Password is required");
            hasError = true;
        }
        
        if (!password.equals(confirmPassword)) {
            request.setAttribute("confirmPasswordError", "Passwords do not match");
            hasError = true;
        }
        
        if (email == null || email.trim().isEmpty() || !email.contains("@")) {
            request.setAttribute("emailError", "Valid email is required");
            hasError = true;
        }
        
        // Check if username already exists
        UserDAO userDAO = new UserDAO();
        if (userDAO.checkUsernameExists(username)) {
            request.setAttribute("usernameError", "Username already exists");
            hasError = true;
        }
        
        // If there are errors, return to register page
        if (hasError) {
            // Keep entered values
            request.setAttribute("username", username);
            request.setAttribute("email", email);
            request.setAttribute("phoneNumber", phoneNumber);
            request.setAttribute("gender", gender);
            request.setAttribute("dob", dobString);
            
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }
        
        // Create user object
        User user = new User();
        user.setUsername(username);
        user.setPassword(password);
        user.setEmail(email);
        user.setPhoneNumber(phoneNumber);
        user.setGender(gender);
        user.setStudentID(studentId);
        user.setIdentityCard(identityCard);
        
        // Parse date of birth
        if (dobString != null && !dobString.trim().isEmpty()) {
            try {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                Date dob = sdf.parse(dobString);
                user.setDob(dob);
            } catch (ParseException e) {
                System.out.println("Error parsing date: " + e.getMessage());
            }
        }
        
        // Register user
        boolean success = userDAO.register(user);
        
        if (success) {
            // Registration successful, redirect to login page with success message
            request.getSession().setAttribute("registerSuccess", "Registration successful! Please login.");
            response.sendRedirect("login");
        } else {
            // Registration failed
            request.setAttribute("errorMessage", "Registration failed. Please try again.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }
}