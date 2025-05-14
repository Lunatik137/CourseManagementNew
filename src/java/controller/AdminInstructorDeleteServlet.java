package controller;

import dal.InstructorDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "AdminInstructorDeleteServlet", urlPatterns = {"/admin/instructor-delete"})
public class AdminInstructorDeleteServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String instructorIdParam = request.getParameter("id");
        
        if (instructorIdParam != null && !instructorIdParam.isEmpty()) {
            try {
                int instructorId = Integer.parseInt(instructorIdParam);
                InstructorDAO instructorDAO = new InstructorDAO();
                boolean success = instructorDAO.deleteInstructor(instructorId);
                
                if (success) {
                    response.sendRedirect(request.getContextPath() + "/admin/instructors?message=deleted");
                } else {
                    response.sendRedirect(request.getContextPath() + "/admin/instructors?message=error");
                }
            } catch (NumberFormatException e) {
                response.sendRedirect(request.getContextPath() + "/admin/instructors?message=invalid");
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/instructors");
        }
    }
}