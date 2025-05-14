package controller;

import dal.CourseCategoryDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.CourseCategory;

@WebServlet(name = "AdminCategoryEditServlet", urlPatterns = {"/admin/category-edit"})
public class AdminCategoryEditServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String categoryIdParam = request.getParameter("id");
        
        if (categoryIdParam != null && !categoryIdParam.isEmpty()) {
            try {
                int categoryId = Integer.parseInt(categoryIdParam);
                CourseCategoryDAO categoryDAO = new CourseCategoryDAO();
                CourseCategory category = categoryDAO.getCategoryById(categoryId);
                
                if (category != null) {
                    request.setAttribute("category", category);
                    request.getRequestDispatcher("/admin/category-form.jsp").forward(request, response);
                } else {
                    response.sendRedirect(request.getContextPath() + "/admin/categories?message=notfound");
                }
            } catch (NumberFormatException e) {
                response.sendRedirect(request.getContextPath() + "/admin/categories?message=invalid");
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/categories");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String categoryIdParam = request.getParameter("id");
        String categoryName = request.getParameter("categoryName");
        
        if (categoryIdParam != null && !categoryIdParam.isEmpty() && 
            categoryName != null && !categoryName.trim().isEmpty()) {
            
            try {
                int categoryId = Integer.parseInt(categoryIdParam);
                
                CourseCategory category = new CourseCategory();
                category.setId(categoryId);
                category.setName(categoryName.trim());
                
                CourseCategoryDAO categoryDAO = new CourseCategoryDAO();
                boolean success = categoryDAO.updateCategory(category);
                
                if (success) {
                    response.sendRedirect(request.getContextPath() + "/admin/categories?message=updated");
                } else {
                    request.setAttribute("error", "Failed to update category. Please try again.");
                    request.setAttribute("category", category);
                    request.getRequestDispatcher("/admin/category-form.jsp").forward(request, response);
                }
            } catch (NumberFormatException e) {
                response.sendRedirect(request.getContextPath() + "/admin/categories?message=invalid");
            }
        } else {
            request.setAttribute("error", "Category ID and name are required.");
            request.getRequestDispatcher("/admin/category-form.jsp").forward(request, response);
        }
    }
}