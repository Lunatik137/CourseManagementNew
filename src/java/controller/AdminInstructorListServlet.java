package controller;

import dal.InstructorDAO;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Instructor;

@WebServlet(name = "AdminInstructorListServlet", urlPatterns = {"/admin/instructors"})
public class AdminInstructorListServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Get search parameter
        String searchQuery = request.getParameter("search");
        
        // Initialize DAO
        InstructorDAO instructorDAO = new InstructorDAO();
        
        // Get instructors based on search
        List<Instructor> instructors;
        if (searchQuery != null && !searchQuery.isEmpty()) {
            instructors = instructorDAO.searchInstructors(searchQuery);
        } else {
            instructors = instructorDAO.getAllInstructors();
        }
        
        request.setAttribute("instructors", instructors);
        request.getRequestDispatcher("/admin/instructor-list.jsp").forward(request, response);
    }
}