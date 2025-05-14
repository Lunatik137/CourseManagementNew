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

@WebServlet(name = "CourseListServlet", urlPatterns = {"/courses"})
public class CourseListServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Lấy các tham số lọc từ request
        String searchQuery = request.getParameter("search");
        String categoryId = request.getParameter("category");
        
        // Khởi tạo DAO
        CourseDAO courseDAO = new CourseDAO();
        CourseCategoryDAO categoryDAO = new CourseCategoryDAO();
        
        // Lấy danh sách tất cả các danh mục
        List<CourseCategory> categories = categoryDAO.getAllCategories();
        request.setAttribute("categories", categories);
        
        // Lấy danh sách khóa học theo bộ lọc
        List<Course> courses;
        if (searchQuery != null && !searchQuery.trim().isEmpty()) {
            // Tìm kiếm theo tên
            courses = courseDAO.searchCoursesByName(searchQuery);
            request.setAttribute("searchQuery", searchQuery);
        } else if (categoryId != null && !categoryId.trim().isEmpty()) {
            try {
                // Lọc theo danh mục
                int catId = Integer.parseInt(categoryId);
                courses = courseDAO.getCoursesByCategory(catId);
                request.setAttribute("selectedCategoryId", catId);
            } catch (NumberFormatException e) {
                // Nếu categoryId không phải là số, lấy tất cả khóa học
                courses = courseDAO.getAllCourses();
            }
        } else {
            // Không có bộ lọc, lấy tất cả khóa học
            courses = courseDAO.getAllCourses();
        }
        
        request.setAttribute("courses", courses);
        request.getRequestDispatcher("course-list.jsp").forward(request, response);
    }
}