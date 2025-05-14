package controller;

import dal.UserDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "AdminUserDeleteServlet", urlPatterns = {"/admin/user-delete"})
public class AdminUserDeleteServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String userIdParam = request.getParameter("id");
        
        if (userIdParam != null && !userIdParam.isEmpty()) {
            try {
                int userId = Integer.parseInt(userIdParam);
                UserDAO userDAO = new UserDAO();
                boolean success = userDAO.deleteUser(userId);
                
                if (success) {
                    response.sendRedirect(request.getContextPath() + "/admin/users?message=deleted");
                } else {
                    response.sendRedirect(request.getContextPath() + "/admin/users?message=error");
                }
            } catch (NumberFormatException e) {
                response.sendRedirect(request.getContextPath() + "/admin/users?message=invalid");
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/users");
        }
    }
}