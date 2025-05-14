package controller;

import dal.CourseStudentDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "AdminUpdateStudentStatusServlet", urlPatterns = {"/admin/update-student-status"})
public class AdminUpdateStudentStatusServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String studentIdParam = request.getParameter("studentId");
        String courseIdParam = request.getParameter("courseId");
        String status = request.getParameter("status");
        
        if (studentIdParam == null || courseIdParam == null || status == null) {
            response.sendRedirect(request.getContextPath() + "/admin/courses?message=error");
            return;
        }
        
        try {
            int studentId = Integer.parseInt(studentIdParam);
            int courseId = Integer.parseInt(courseIdParam);
            
            // Validate status
            if (!status.equals("Active") && !status.equals("Inactive")) {
                response.sendRedirect(request.getContextPath() + "/admin/course-students?courseId=" + courseId + "&message=invalidstatus");
                return;
            }
            
            // Update student status
            CourseStudentDAO courseStudentDAO = new CourseStudentDAO();
            boolean success = courseStudentDAO.updateStudentStatus(studentId, courseId, status);
            
            if (success) {
                response.sendRedirect(request.getContextPath() + "/admin/course-students?courseId=" + courseId + "&message=success");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/course-students?courseId=" + courseId + "&message=error");
            }
            
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/courses?message=invalid");
        }
    }
}