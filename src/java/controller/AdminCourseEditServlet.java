package controller;

import dal.CourseDAO;
import dal.CourseCategoryDAO;
import dal.InstructorDAO;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import model.Course;
import model.CourseCategory;
import model.Instructor;

@WebServlet(name = "AdminCourseEditServlet", urlPatterns = {"/admin/course-edit"})
@MultipartConfig
public class AdminCourseEditServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String courseIdParam = request.getParameter("id");

        // Load categories and instructors for the form
        CourseCategoryDAO categoryDAO = new CourseCategoryDAO();
        InstructorDAO instructorDAO = new InstructorDAO();

        List<CourseCategory> categories = categoryDAO.getAllCategories();
        List<Instructor> instructors = instructorDAO.getAllInstructors();

        request.setAttribute("categories", categories);
        request.setAttribute("instructors", instructors);

        // If editing existing course
        if (courseIdParam != null && !courseIdParam.isEmpty()) {
            try {
                int courseId = Integer.parseInt(courseIdParam);
                CourseDAO courseDAO = new CourseDAO();
                Course course = courseDAO.getCourseById(courseId);

                if (course != null) {
                    request.setAttribute("course", course);
                    request.setAttribute("mode", "edit");
                } else {
                    response.sendRedirect(request.getContextPath() + "/admin/courses?message=notfound");
                    return;
                }
            } catch (NumberFormatException e) {
                response.sendRedirect(request.getContextPath() + "/admin/courses?message=invalid");
                return;
            }
        } else {
            // New course
            request.setAttribute("course", new Course());
            request.setAttribute("mode", "add");
        }

        request.getRequestDispatcher("/admin/course-form.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get form data
        String courseIdParam = request.getParameter("id");
        String courseName = request.getParameter("courseName");
        String courseTitle = request.getParameter("courseTitle");
        String courseDescription = request.getParameter("courseDescription");
        String startDateStr = request.getParameter("startDate");
        String endDateStr = request.getParameter("endDate");
        String status = request.getParameter("status");
        String categoryIdStr = request.getParameter("category");
        String instructorIdStr = request.getParameter("instructor");
        String requirements = request.getParameter("requirements");
        String courseImageUrl = request.getParameter("courseImageUrl"); // Lấy URL ảnh từ form

        String[] learningOutcomesArray = request.getParameterValues("learningOutcomes");
        List<String> learningOutcomes = new ArrayList<>();

        if (learningOutcomesArray != null) {
            for (String outcome : learningOutcomesArray) {
                if (outcome != null && !outcome.trim().isEmpty()) {
                    learningOutcomes.add(outcome.trim());
                }
            }
        }
        

        // Parse dates
        Date startDate = null;
        Date endDate = null;
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

        try {
            if (startDateStr != null && !startDateStr.isEmpty()) {
                startDate = dateFormat.parse(startDateStr);
            }
            if (endDateStr != null && !endDateStr.isEmpty()) {
                endDate = dateFormat.parse(endDateStr);
            }
        } catch (ParseException e) {
            request.setAttribute("errorMessage", "Invalid date format");
            doGet(request, response);
            return;
        }

        // Parse IDs
        int categoryId = 0;
        int instructorId = 0;

        try {
            if (categoryIdStr != null && !categoryIdStr.isEmpty()) {
                categoryId = Integer.parseInt(categoryIdStr);
            } else {
                request.setAttribute("errorMessage", "Category is required");
                doGet(request, response);
                return;
            }

            if (instructorIdStr != null && !instructorIdStr.isEmpty()) {
                instructorId = Integer.parseInt(instructorIdStr);
            }
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid category or instructor ID");
            doGet(request, response);
            return;
        }

        // Validate category exists
        CourseCategoryDAO categoryDAO = new CourseCategoryDAO();
        if (categoryDAO.getCategoryById(categoryId) == null) {
            request.setAttribute("errorMessage", "Selected category does not exist");
            doGet(request, response);
            return;
        }

        // Create or update course
        Course course = new Course();
        if (courseIdParam != null && !courseIdParam.isEmpty()) {
            course.setId(Integer.parseInt(courseIdParam));
        }

        course.setCourseName(courseName);
        course.setCourseTitle(courseTitle);
        course.setCourseDescription(courseDescription);
        course.setCourseImage(courseImageUrl);
        course.setStartDate(startDate);
        course.setEndDate(endDate);
        course.setStatus(status);
        course.setCourseCategoryId(categoryId);
        course.setRequirements(requirements);
        course.setLearningOutcomes(learningOutcomes);

        // Set instructor if selected
        if (instructorId > 0) {
            InstructorDAO instructorDAO = new InstructorDAO();
            Instructor instructor = instructorDAO.getInstructorById(instructorId);
            course.setInstructor(instructor);
        }

        // Save to database
        CourseDAO courseDAO = new CourseDAO();
        boolean success;

        if (course.getId() > 0) {
            // Update existing course
            success = courseDAO.updateCourse(course);
        } else {
            // Create new course
            success = courseDAO.createCourse(course);
        }

        if (success) {
            response.sendRedirect(request.getContextPath() + "/admin/courses?message=success");
        } else {
            request.setAttribute("errorMessage", "Failed to save course");
            request.setAttribute("course", course); // Return the course object to the form
            doGet(request, response);
        }
    }
}
