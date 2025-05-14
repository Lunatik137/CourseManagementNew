package controller;

import dal.CourseStudentDAO;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.CourseStudent;
import model.User;

@WebServlet(name = "MyCoursesServlet", urlPatterns = {"/my-courses"})
public class MyCoursesServlet extends HttpServlet {

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
        
        // Get enrollments for user
        CourseStudentDAO courseStudentDAO = new CourseStudentDAO();
        List<CourseStudent> enrollments = courseStudentDAO.getEnrollmentsByStudentId(user.getId());
        
        // Kiểm tra xem có khóa học nào bị ban không
        boolean hasBannedCourses = false;
        for (CourseStudent enrollment : enrollments) {
            if (enrollment.getStatus() != null && enrollment.getStatus().equals("Inactive")) {
                hasBannedCourses = true;
                break;
            }
        }
        
        // Thêm thông báo nếu có khóa học bị ban
        if (hasBannedCourses) {
            request.setAttribute("banMessage", "You have been banned from one or more courses by the administrator.");
        }
        
        request.setAttribute("enrollments", enrollments);
        request.getRequestDispatcher("my-courses.jsp").forward(request, response);
    }
}