package controller;

import dal.CourseDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "AdminCourseDeleteServlet", urlPatterns = {"/admin/course-delete"})
public class AdminCourseDeleteServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String courseIdParam = request.getParameter("id");
        
        if (courseIdParam != null && !courseIdParam.isEmpty()) {
            try {
                int courseId = Integer.parseInt(courseIdParam);
                CourseDAO courseDAO = new CourseDAO();
                boolean success = courseDAO.deleteCourse(courseId);
                
                if (success) {
                    response.sendRedirect(request.getContextPath() + "/admin/courses?message=deleted");
                } else {
                    response.sendRedirect(request.getContextPath() + "/admin/courses?message=error");
                }
            } catch (NumberFormatException e) {
                response.sendRedirect(request.getContextPath() + "/admin/courses?message=invalid");
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/courses");
        }
    }
}