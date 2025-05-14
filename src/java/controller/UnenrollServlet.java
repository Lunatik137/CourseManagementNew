package controller;

import dal.CourseStudentDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;

@WebServlet(name = "UnenrollServlet", urlPatterns = {"/unenroll"})
public class UnenrollServlet extends HttpServlet {

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
        
        // Get course ID from request
        String courseIdParam = request.getParameter("courseId");
        if (courseIdParam == null || courseIdParam.isEmpty()) {
            response.sendRedirect("my-courses");
            return;
        }
        
        try {
            int courseId = Integer.parseInt(courseIdParam);
            
            // Delete enrollment
            CourseStudentDAO courseStudentDAO = new CourseStudentDAO();
            boolean success = courseStudentDAO.deleteEnrollment(user.getId(), courseId);
            
            if (success) {
                session.setAttribute("unenrollMessage", "You have successfully unenrolled from this course.");
            } else {
                session.setAttribute("unenrollMessage", "Failed to unenroll from this course.");
            }
            
            // Redirect back to my courses
            response.sendRedirect("my-courses");
        } catch (NumberFormatException e) {
            response.sendRedirect("my-courses");
        }
    }
}