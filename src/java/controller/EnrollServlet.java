package controller;

import dal.CourseStudentDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;

@WebServlet(name = "EnrollServlet", urlPatterns = {"/enroll"})
public class EnrollServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
       
        
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            System.out.println("Error: User not logged in");
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
       
        
        
        String courseIdParam = request.getParameter("courseId");
        String idParam = request.getParameter("id");
        
        System.out.println("courseId parameter: " + courseIdParam);
        System.out.println("id parameter: " + idParam);
        
        
        String finalIdParam = (courseIdParam != null && !courseIdParam.isEmpty()) ? courseIdParam : idParam;
        
        if (finalIdParam == null || finalIdParam.isEmpty()) {
            System.out.println("Error: No course ID provided");
            response.sendRedirect(request.getContextPath() + "/courses");
            return;
        }
        
        try {
            int courseId = Integer.parseInt(finalIdParam);
            System.out.println("Parsed course ID: " + courseId);
            
            CourseStudentDAO courseStudentDAO = new CourseStudentDAO();
            
          
            String currentStatus = courseStudentDAO.getStudentStatusInCourse(user.getId(), courseId);
            
            
            if ("Inactive".equals(currentStatus)) {
                
                session.setAttribute("enrollMessage", "You have been banned from this course by the administrator.");
                response.sendRedirect(request.getContextPath() + "/course-detail?id=" + courseId);
                return;
            }
            
            if (currentStatus != null) {
                System.out.println("User is already enrolled in this course with status: " + currentStatus);
                session.setAttribute("enrollMessage", "You are already enrolled in this course.");
                response.sendRedirect(request.getContextPath() + "/course-detail?id=" + courseId);
                return;
            }
            
            
            boolean success = courseStudentDAO.enrollStudentInCourse(user.getId(), courseId);
            
            if (success) {
                
                session.setAttribute("enrollMessage", "You have successfully enrolled in this course!");
                response.sendRedirect(request.getContextPath() + "/course-details?id=" + courseId);
            } else {
                
                session.setAttribute("enrollMessage", "There was an error enrolling in this course. Please try again.");
                response.sendRedirect(request.getContextPath() + "/course-details?id=" + courseId);
            }
        } catch (NumberFormatException e) {
            
            response.sendRedirect(request.getContextPath() + "/courses");
        } catch (Exception e) {
            
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/courses");
        } finally {
            
        }
    }
}