package controller;

import dal.CourseDAO;
import dal.CourseCategoryDAO;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Course;
import model.CourseCategory;

@WebServlet(name = "AdminCourseListServlet", urlPatterns = {"/admin/courses"})
public class AdminCourseListServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get filter parameters
        String searchQuery = request.getParameter("search");
        String categoryId = request.getParameter("category");

        
        // Initialize DAOs
        CourseDAO courseDAO = new CourseDAO();
        CourseCategoryDAO categoryDAO = new CourseCategoryDAO();

        // Get all categories for filter dropdown
        List<CourseCategory> categories = categoryDAO.getAllCategories();
        request.setAttribute("categories", categories);

        // Get courses based on filters
        List<Course> courses;

        // Apply filters
        if (searchQuery != null && !searchQuery.isEmpty()) {
            courses = courseDAO.searchCoursesByName(searchQuery);
            request.setAttribute("searchQuery", searchQuery);
        } else if (categoryId != null && !categoryId.isEmpty()) {
            try {
                int catId = Integer.parseInt(categoryId);
                courses = courseDAO.getCoursesByCategory(catId);
                request.setAttribute("selectedCategoryId", catId);
            } catch (NumberFormatException e) {
                // If categoryId is not a valid number, get all courses
                courses = courseDAO.getAllCoursesForAdmin();
            }
        } else {
            // No filters, get all courses
            courses = courseDAO.getAllCoursesForAdmin();
        }

        request.setAttribute("courses", courses);
        request.getRequestDispatcher("/admin/course-list.jsp").forward(request, response);
    }
}
