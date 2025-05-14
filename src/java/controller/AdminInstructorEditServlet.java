package controller;

import dal.InstructorDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Instructor;

@WebServlet(name = "AdminInstructorEditServlet", urlPatterns = {"/admin/instructor-edit"})
public class AdminInstructorEditServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String instructorIdParam = request.getParameter("id");
        
        // If editing existing instructor
        if (instructorIdParam != null && !instructorIdParam.isEmpty()) {
            try {
                int instructorId = Integer.parseInt(instructorIdParam);
                InstructorDAO instructorDAO = new InstructorDAO();
                Instructor instructor = instructorDAO.getInstructorById(instructorId);
                
                if (instructor != null) {
                    request.setAttribute("instructor", instructor);
                    request.setAttribute("mode", "edit");
                } else {
                    response.sendRedirect(request.getContextPath() + "/admin/instructors?message=notfound");
                    return;
                }
            } catch (NumberFormatException e) {
                response.sendRedirect(request.getContextPath() + "/admin/instructors?message=invalid");
                return;
            }
        } else {
            // New instructor
            request.setAttribute("mode", "add");
            request.setAttribute("instructor", new Instructor()); // Add empty instructor to avoid null errors
        }
        
        request.getRequestDispatcher("/admin/instructor-form.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Get form data
        String instructorIdParam = request.getParameter("id");
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String imageUrl = request.getParameter("imageUrl"); // Lấy URL ảnh từ form
        
        // Validate required fields
        if (name == null || name.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Instructor name is required");
            doGet(request, response);
            return;
        }
        
        // Create or update instructor
        Instructor instructor = new Instructor();
        if (instructorIdParam != null && !instructorIdParam.isEmpty()) {
            instructor.setId(Integer.parseInt(instructorIdParam));
        }
        
        instructor.setName(name);
        instructor.setDescription(description);
        instructor.setImage(imageUrl); // Sử dụng URL ảnh
        
        // Save to database
        InstructorDAO instructorDAO = new InstructorDAO();
        boolean success;
        
        if (instructor.getId() > 0) {
            // Update existing instructor
            success = instructorDAO.updateInstructor(instructor);
        } else {
            // Create new instructor
            success = instructorDAO.createInstructor(instructor);
        }
        
        if (success) {
            response.sendRedirect(request.getContextPath() + "/admin/instructors?message=success");
        } else {
            request.setAttribute("errorMessage", "Failed to save instructor");
            request.setAttribute("instructor", instructor); // Return the instructor object to the form
            doGet(request, response);
        }
    }
}