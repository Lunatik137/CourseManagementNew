package controller;

import dal.CourseDAO;
import dal.CourseStudentDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Course;
import model.User;

@WebServlet(name = "CourseDetailServlet", urlPatterns = {"/course-details"})
public class CourseDetailServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // Get course ID from request parameter
            int courseId = Integer.parseInt(request.getParameter("id"));

            // Get course details from database
            CourseDAO courseDAO = new CourseDAO();
            Course course = courseDAO.getCourseById(courseId);

            if (course != null) {
                // Set course as request attribute
                request.setAttribute("course", course);

                // Check if user is enrolled in this course
                HttpSession session = request.getSession();
                User currentUser = (User) session.getAttribute("user");

                boolean isEnrolled = false;
                boolean isBanned = false;

                if (currentUser != null) {
                    CourseStudentDAO courseStudentDAO = new CourseStudentDAO();
                    isEnrolled = courseStudentDAO.isStudentEnrolledInCourse(currentUser.getId(), courseId);

                    // Kiểm tra trạng thái của học viên nếu đã đăng ký
                    if (isEnrolled) {
                        String status = courseStudentDAO.getStudentStatusInCourse(currentUser.getId(), courseId);
                        isBanned = status != null && status.equals("Inactive");
                        
                        // Thêm thông báo nếu học viên bị ban
                        if (isBanned) {
                            request.setAttribute("banMessage", "You have been banned from this course by the administrator.");
                        }
                    }
                }
                
                // Set enrollment status attributes
                request.setAttribute("isEnrolled", isEnrolled);
                request.setAttribute("isBanned", isBanned);

                // Get related courses (same category)
                request.setAttribute("relatedCourses", courseDAO.getRelatedCourses(courseId, course.getCourseCategoryId(), 3));

                // Forward to course detail page
                request.getRequestDispatcher("course-detail.jsp").forward(request, response);
            } else {
                // Course not found, redirect to courses page
                response.sendRedirect("courses");
            }
        } catch (NumberFormatException e) {
            // Invalid course ID, redirect to courses page
            response.sendRedirect("courses");
        }
    }
}