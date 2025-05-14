package controller;

import dal.CourseCategoryDAO;
import dal.CourseDAO;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Course;
import model.CourseCategory;

@WebServlet(name = "HomeServlet", urlPatterns = {"/home"})
public class HomeServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Get popular courses
        CourseDAO courseDAO = new CourseDAO();
        List<Course> popularCourses = courseDAO.getPopularCourses(3);
        request.setAttribute("popularCourses", popularCourses);
        
        // Get top categories
        CourseCategoryDAO categoryDAO = new CourseCategoryDAO();
        List<CourseCategory> topCategories = categoryDAO.getTopCategories(6);
        request.setAttribute("topCategories", topCategories);
        
        // Forward to the home page
        request.getRequestDispatcher("index.jsp").forward(request, response);
    }
}