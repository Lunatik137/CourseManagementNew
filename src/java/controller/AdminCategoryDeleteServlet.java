package controller;

import dal.CourseCategoryDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "AdminCategoryDeleteServlet", urlPatterns = {"/admin/category-delete"})
public class AdminCategoryDeleteServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String categoryIdParam = request.getParameter("id");
        
        if (categoryIdParam != null && !categoryIdParam.isEmpty()) {
            try {
                int categoryId = Integer.parseInt(categoryIdParam);
                CourseCategoryDAO categoryDAO = new CourseCategoryDAO();
                
                // Kiểm tra xem danh mục có khóa học nào không
                int courseCount = categoryDAO.getCoursesCountByCategory(categoryId);
                
                if (courseCount > 0) {
                    // Có khóa học sử dụng danh mục này
                    response.sendRedirect(request.getContextPath() + "/admin/categories?message=inuse");
                } else {
                    // Không có khóa học, có thể xóa an toàn
                    boolean success = categoryDAO.deleteCategory(categoryId);
                    
                    if (success) {
                        response.sendRedirect(request.getContextPath() + "/admin/categories?message=deleted");
                    } else {
                        response.sendRedirect(request.getContextPath() + "/admin/categories?message=error");
                    }
                }
            } catch (NumberFormatException e) {
                response.sendRedirect(request.getContextPath() + "/admin/categories?message=invalid");
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/categories");
        }
    }
}