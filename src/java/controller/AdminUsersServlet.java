package controller;

import dal.UserDAO;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.User;

@WebServlet(name = "AdminUsersServlet", urlPatterns = {"/admin/users"})
public class AdminUsersServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        UserDAO userDAO = new UserDAO();
        List<User> users = userDAO.getAllUsers();
        
        request.setAttribute("users", users);
        request.getRequestDispatcher("/admin/user-list.jsp").forward(request, response);
    }
}