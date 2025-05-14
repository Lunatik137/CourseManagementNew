package controller;

import dal.CourseCategoryDAO;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.CourseCategory;

@WebServlet(name = "AdminCategoriesServlet", urlPatterns = {"/admin/categories"})
public class AdminCategoriesServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        CourseCategoryDAO categoryDAO = new CourseCategoryDAO();
        List<CourseCategory> categories = categoryDAO.getAllCategories();
        
        request.setAttribute("categories", categories);
        request.getRequestDispatcher("/admin/category-list.jsp").forward(request, response);
    }
}