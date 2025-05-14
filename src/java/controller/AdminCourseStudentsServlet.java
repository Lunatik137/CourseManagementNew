package controller;

import dal.CourseDAO;
import dal.CourseStudentDAO;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Course;
import model.CourseStudent;

@WebServlet(name = "AdminCourseStudentsServlet", urlPatterns = {"/admin/course-students"})
public class AdminCourseStudentsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String courseIdParam = request.getParameter("courseId");
        
        if (courseIdParam == null || courseIdParam.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/admin/courses?message=nocourse");
            return;
        }
        
        try {
            int courseId = Integer.parseInt(courseIdParam);
            
            // Get course information
            CourseDAO courseDAO = new CourseDAO();
            Course course = courseDAO.getCourseById(courseId);
            
            if (course == null) {
                response.sendRedirect(request.getContextPath() + "/admin/courses?message=notfound");
                return;
            }
            
            // Get students for this course
            CourseStudentDAO courseStudentDAO = new CourseStudentDAO();
            List<CourseStudent> students = courseStudentDAO.getStudentsByCourseId(courseId);
            
            request.setAttribute("course", course);
            request.setAttribute("students", students);
            request.getRequestDispatcher("/admin/course-students.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/courses?message=invalid");
        }
    }
}