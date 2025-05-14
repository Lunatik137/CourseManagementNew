package controller;

import dal.CourseDAO;
import dal.InstructorDAO;
import dal.UserDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "AdminDashboardServlet", urlPatterns = {"/admin/dashboard"})
public class AdminDashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        CourseDAO courseDAO = new CourseDAO();
        UserDAO userDAO = new UserDAO();
        InstructorDAO instructorDAO = new InstructorDAO();
        // Get counts for dashboard
        int totalCourses = courseDAO.getTotalCourses();
        int totalStudents = userDAO.getTotalUsersByRole(2); 
        int totalInstructors = instructorDAO.getTotalInstructors();
        
        // Set attributes for the dashboard
        request.setAttribute("totalCourses", totalCourses);
        request.setAttribute("totalStudents", totalStudents);
        request.setAttribute("totalInstructors", totalInstructors);
        
        // Forward to the dashboard page
        request.getRequestDispatcher("/admin/dashboard.jsp").forward(request, response);
    }
}