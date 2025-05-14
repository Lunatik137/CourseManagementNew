package controller;

import dal.CourseCategoryDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.CourseCategory;

@WebServlet(name = "AdminCategoryAddServlet", urlPatterns = {"/admin/category-add"})
public class AdminCategoryAddServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/admin/category-form.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String categoryName = request.getParameter("categoryName");
        
        if (categoryName != null && !categoryName.trim().isEmpty()) {
            CourseCategory category = new CourseCategory();
            category.setName(categoryName.trim());
            
            CourseCategoryDAO categoryDAO = new CourseCategoryDAO();
            boolean success = categoryDAO.addCategory(category);
            
            if (success) {
                response.sendRedirect(request.getContextPath() + "/admin/categories?message=added");
            } else {
                request.setAttribute("error", "Failed to add category. Please try again.");
                request.setAttribute("categoryName", categoryName);
                request.getRequestDispatcher("/admin/category-form.jsp").forward(request, response);
            }
        } else {
            request.setAttribute("error", "Category name cannot be empty.");
            request.getRequestDispatcher("/admin/category-form.jsp").forward(request, response);
        }
    }
}