package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Course;
import model.CourseCategory;
import model.Instructor;

public class CourseDAO extends DBContext {

    public List<Course> getAllCourses() {
        List<Course> courses = new ArrayList<>();
        String sql = "SELECT c.*, cc.Name as categoryName FROM Course c "
                + "LEFT JOIN CourseCategory cc ON c.courseCategoryId = cc.ID Where c.status = 'Active'";

        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            ResultSet rs = statement.executeQuery();

            while (rs.next()) {
                Course course = new Course();
                course.setId(rs.getInt("ID"));
                course.setCourseName(rs.getString("courseName"));
                course.setCourseTitle(rs.getString("courseTitle"));
                course.setCourseDescription(rs.getString("courseDescription"));
                course.setCourseImage(rs.getString("courseImage"));
                course.setStartDate(rs.getDate("startDate"));
                course.setEndDate(rs.getDate("endDate"));
                course.setStatus(rs.getString("status"));
                course.setCourseCategoryId(rs.getInt("courseCategoryId"));

                // Create and set the CourseCategory
                CourseCategory category = new CourseCategory();
                category.setId(rs.getInt("courseCategoryId"));
                category.setName(rs.getString("categoryName"));
                course.setCourseCategory(category);

                courses.add(course);
            }
        } catch (SQLException e) {
            System.out.println("Error retrieving courses: " + e.getMessage());
        }

        return courses;
    }
    public List<Course> getAllCoursesForAdmin() {
        List<Course> courses = new ArrayList<>();
        String sql = "SELECT c.*, cc.Name as categoryName FROM Course c "
                + "LEFT JOIN CourseCategory cc ON c.courseCategoryId = cc.ID";

        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            ResultSet rs = statement.executeQuery();

            while (rs.next()) {
                Course course = new Course();
                course.setId(rs.getInt("ID"));
                course.setCourseName(rs.getString("courseName"));
                course.setCourseTitle(rs.getString("courseTitle"));
                course.setCourseDescription(rs.getString("courseDescription"));
                course.setCourseImage(rs.getString("courseImage"));
                course.setStartDate(rs.getDate("startDate"));
                course.setEndDate(rs.getDate("endDate"));
                course.setStatus(rs.getString("status"));
                course.setCourseCategoryId(rs.getInt("courseCategoryId"));

                // Create and set the CourseCategory
                CourseCategory category = new CourseCategory();
                category.setId(rs.getInt("courseCategoryId"));
                category.setName(rs.getString("categoryName"));
                course.setCourseCategory(category);

                courses.add(course);
            }
        } catch (SQLException e) {
            System.out.println("Error retrieving courses: " + e.getMessage());
        }

        return courses;
    }

    public List<Course> getPopularCourses(int limit) {
        List<Course> courses = new ArrayList<>();
        String sql = "SELECT TOP (?) c.*, cc.Name as categoryName FROM Course c "
                + "LEFT JOIN CourseCategory cc ON c.courseCategoryId = cc.ID "
                + "ORDER BY c.ID DESC"; // In a real app, you might order by enrollment count

        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, limit);
            ResultSet rs = statement.executeQuery();

            while (rs.next()) {
                Course course = new Course();
                course.setId(rs.getInt("ID"));
                course.setCourseName(rs.getString("courseName"));
                course.setCourseTitle(rs.getString("courseTitle"));
                course.setCourseDescription(rs.getString("courseDescription"));
                course.setCourseImage(rs.getString("courseImage"));
                course.setStartDate(rs.getDate("startDate"));
                course.setEndDate(rs.getDate("endDate"));
                course.setStatus(rs.getString("status"));
                course.setCourseCategoryId(rs.getInt("courseCategoryId"));

                // Create and set the CourseCategory
                CourseCategory category = new CourseCategory();
                category.setId(rs.getInt("courseCategoryId"));
                category.setName(rs.getString("categoryName"));
                course.setCourseCategory(category);

                courses.add(course);
            }
        } catch (SQLException e) {
            System.out.println("Error retrieving popular courses: " + e.getMessage());
        }

        return courses;
    }

    public Course getCourseById(int courseId) {
        Course course = null;
        String sql = "SELECT c.*, cc.Name as categoryName, i.ID as instructorId, i.name as instructorName, "
                + "i.image as instructorImage, i.description as instructorDescription "
                + "FROM Course c "
                + "LEFT JOIN CourseCategory cc ON c.courseCategoryId = cc.ID "
                + "LEFT JOIN Instructor i ON c.instructorId = i.ID "
                + "WHERE c.ID = ?";

        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, courseId);
            ResultSet rs = statement.executeQuery();

            if (rs.next()) {
                course = new Course();
                course.setId(rs.getInt("ID"));
                course.setCourseName(rs.getString("courseName"));
                course.setCourseTitle(rs.getString("courseTitle"));
                course.setCourseDescription(rs.getString("courseDescription"));
                course.setCourseImage(rs.getString("courseImage"));
                course.setStartDate(rs.getDate("startDate"));
                course.setEndDate(rs.getDate("endDate"));
                course.setStatus(rs.getString("status"));
                course.setCourseCategoryId(rs.getInt("courseCategoryId"));
                course.setRequirements(rs.getString("requirements"));

                // Create and set the CourseCategory
                CourseCategory category = new CourseCategory();
                category.setId(rs.getInt("courseCategoryId"));
                category.setName(rs.getString("categoryName"));
                course.setCourseCategory(category);

                // Create and set the Instructor
                Instructor instructor = new Instructor();
                instructor.setId(rs.getInt("instructorId"));
                instructor.setName(rs.getString("instructorName"));
                instructor.setImage(rs.getString("instructorImage"));
                instructor.setDescription(rs.getString("instructorDescription"));
                course.setInstructor(instructor);

                // Get learning outcomes in a separate query
                course.setLearningOutcomes(getLearningOutcomesByCourseId(courseId));
            }
        } catch (SQLException e) {
            System.out.println("Error retrieving course by ID: " + e.getMessage());
        }

        return course;
    }

    private List<String> getLearningOutcomesByCourseId(int courseId) {
        List<String> outcomes = new ArrayList<>();
        String sql = "SELECT outcomeText FROM LearningOutcome WHERE courseId = ? ORDER BY ID";

        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, courseId);
            ResultSet rs = statement.executeQuery();

            while (rs.next()) {
                outcomes.add(rs.getString("outcomeText"));
            }
        } catch (SQLException e) {
            System.out.println("Error retrieving learning outcomes: " + e.getMessage());
        }

        return outcomes;
    }

    public List<Course> getRelatedCourses(int currentCourseId, int categoryId, int limit) {
        List<Course> courses = new ArrayList<>();
        String sql = "SELECT TOP (?) c.*, cc.Name as categoryName FROM Course c "
                + "LEFT JOIN CourseCategory cc ON c.courseCategoryId = cc.ID "
                + "WHERE c.courseCategoryId = ? AND c.ID != ? "
                + "ORDER BY NEWID()"; // Random order for variety

        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, limit);
            statement.setInt(2, categoryId);
            statement.setInt(3, currentCourseId);
            ResultSet rs = statement.executeQuery();

            while (rs.next()) {
                Course course = new Course();
                course.setId(rs.getInt("ID"));
                course.setCourseName(rs.getString("courseName"));
                course.setCourseTitle(rs.getString("courseTitle"));
                course.setCourseDescription(rs.getString("courseDescription"));
                course.setCourseImage(rs.getString("courseImage"));
                course.setStartDate(rs.getDate("startDate"));
                course.setEndDate(rs.getDate("endDate"));
                course.setStatus(rs.getString("status"));
                course.setCourseCategoryId(rs.getInt("courseCategoryId"));

                // Create and set the CourseCategory
                CourseCategory category = new CourseCategory();
                category.setId(rs.getInt("courseCategoryId"));
                category.setName(rs.getString("categoryName"));
                course.setCourseCategory(category);

                courses.add(course);
            }
        } catch (SQLException e) {
            System.out.println("Error retrieving related courses: " + e.getMessage());
        }

        return courses;
    }

    public List<Course> searchCoursesByName(String searchQuery) {
        List<Course> courses = new ArrayList<>();
        String sql = "SELECT c.*, cc.Name as categoryName FROM Course c "
                + "LEFT JOIN CourseCategory cc ON c.courseCategoryId = cc.ID "
                + "WHERE c.courseName LIKE ? OR c.courseTitle LIKE ?";

        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, "%" + searchQuery + "%");
            statement.setString(2, "%" + searchQuery + "%");
            ResultSet rs = statement.executeQuery();

            while (rs.next()) {
                Course course = new Course();
                course.setId(rs.getInt("ID"));
                course.setCourseName(rs.getString("courseName"));
                course.setCourseTitle(rs.getString("courseTitle"));
                course.setCourseDescription(rs.getString("courseDescription"));
                course.setCourseImage(rs.getString("courseImage"));
                course.setStartDate(rs.getDate("startDate"));
                course.setEndDate(rs.getDate("endDate"));
                course.setStatus(rs.getString("status"));
                course.setCourseCategoryId(rs.getInt("courseCategoryId"));

                // Create and set the CourseCategory
                CourseCategory category = new CourseCategory();
                category.setId(rs.getInt("courseCategoryId"));
                category.setName(rs.getString("categoryName"));
                course.setCourseCategory(category);

                courses.add(course);
            }
        } catch (SQLException e) {
            System.out.println("Error searching courses: " + e.getMessage());
        }

        return courses;
    }

    public List<Course> getCoursesByCategory(int categoryId) {
        List<Course> courses = new ArrayList<>();
        String sql = "SELECT c.*, cc.Name as categoryName FROM Course c "
                + "LEFT JOIN CourseCategory cc ON c.courseCategoryId = cc.ID "
                + "WHERE c.courseCategoryId = ?";

        try {
            System.out.println("Executing SQL: " + sql + " with categoryId: " + categoryId);
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, categoryId);
            ResultSet rs = statement.executeQuery();

            int count = 0;
            while (rs.next()) {
                count++;
                Course course = new Course();
                course.setId(rs.getInt("ID"));
                course.setCourseName(rs.getString("courseName"));
                course.setCourseTitle(rs.getString("courseTitle"));
                course.setCourseDescription(rs.getString("courseDescription"));
                course.setCourseImage(rs.getString("courseImage"));
                course.setStartDate(rs.getDate("startDate"));
                course.setEndDate(rs.getDate("endDate"));
                course.setStatus(rs.getString("status"));
                course.setCourseCategoryId(rs.getInt("courseCategoryId"));

                // Create and set the CourseCategory
                CourseCategory category = new CourseCategory();
                category.setId(rs.getInt("courseCategoryId"));
                category.setName(rs.getString("categoryName"));
                course.setCourseCategory(category);

                courses.add(course);
            }
            System.out.println("Found " + count + " courses for category ID: " + categoryId);
        } catch (SQLException e) {
            System.out.println("Error retrieving courses by category: " + e.getMessage());
        }

        return courses;
    }

    public int getTotalCourses() {
        String sql = "SELECT COUNT(*) as count FROM Course";

        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            ResultSet rs = statement.executeQuery();

            if (rs.next()) {
                return rs.getInt("count");
            }
        } catch (SQLException e) {
            System.out.println("Error counting courses: " + e.getMessage());
        }

        return 0;
    }

    public List<Course> getCoursesByStatus(String status) {
        List<Course> courses = new ArrayList<>();
        String sql = "SELECT c.*, cc.Name as categoryName FROM Course c "
                + "LEFT JOIN CourseCategory cc ON c.courseCategoryId = cc.ID "
                + "WHERE c.status = ?";

        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, status);
            ResultSet rs = statement.executeQuery();

            while (rs.next()) {
                Course course = extractCourseFromResultSet(rs);
                courses.add(course);
            }
        } catch (SQLException e) {
            System.out.println("Error retrieving courses by status: " + e.getMessage());
        }

        return courses;
    }

    public boolean createCourse(Course course) {
        String sql = "INSERT INTO Course (courseName, courseTitle, courseDescription, courseImage, "
                + "startDate, endDate, status, courseCategoryId, instructorId, requirements) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try {
            connection.setAutoCommit(false);

            PreparedStatement statement = connection.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);
            statement.setString(1, course.getCourseName());
            statement.setString(2, course.getCourseTitle());
            statement.setString(3, course.getCourseDescription());
            statement.setString(4, course.getCourseImage());

            if (course.getStartDate() != null) {
                statement.setDate(5, new java.sql.Date(course.getStartDate().getTime()));
            } else {
                statement.setNull(5, java.sql.Types.DATE);
            }

            if (course.getEndDate() != null) {
                statement.setDate(6, new java.sql.Date(course.getEndDate().getTime()));
            } else {
                statement.setNull(6, java.sql.Types.DATE);
            }

            statement.setString(7, course.getStatus());
            statement.setInt(8, course.getCourseCategoryId());

            if (course.getInstructor() != null) {
                statement.setInt(9, course.getInstructor().getId());
            } else {
                statement.setNull(9, java.sql.Types.INTEGER);
            }

            statement.setString(10, course.getRequirements());

            int affectedRows = statement.executeUpdate();

            if (affectedRows > 0) {
                ResultSet generatedKeys = statement.getGeneratedKeys();
                if (generatedKeys.next()) {
                    int courseId = generatedKeys.getInt(1);

                    // Insert learning outcomes if available
                    if (course.getLearningOutcomes() != null && !course.getLearningOutcomes().isEmpty()) {
                        insertLearningOutcomes(courseId, course.getLearningOutcomes());
                    }

                    connection.commit();
                    return true;
                }
            }

            connection.rollback();
            return false;
        } catch (SQLException e) {
            try {
                connection.rollback();
            } catch (SQLException ex) {
                System.out.println("Error rolling back transaction: " + ex.getMessage());
            }
            System.out.println("Error creating course: " + e.getMessage());
            return false;
        } finally {
            try {
                connection.setAutoCommit(true);
            } catch (SQLException e) {
                System.out.println("Error resetting auto-commit: " + e.getMessage());
            }
        }
    }

    public boolean updateCourse(Course course) {
        String sql = "UPDATE Course SET courseName = ?, courseTitle = ?, courseDescription = ?, "
                + "startDate = ?, endDate = ?, status = ?, courseCategoryId = ?, "
                + "instructorId = ?, requirements = ? ";

        if (course.getCourseImage() != null && !course.getCourseImage().isEmpty()) {
            sql += ", courseImage = ? ";
        }

        sql += "WHERE ID = ?";

        try {
            connection.setAutoCommit(false);

            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, course.getCourseName());
            statement.setString(2, course.getCourseTitle());
            statement.setString(3, course.getCourseDescription());

            if (course.getStartDate() != null) {
                statement.setDate(4, new java.sql.Date(course.getStartDate().getTime()));
            } else {
                statement.setNull(4, java.sql.Types.DATE);
            }

            if (course.getEndDate() != null) {
                statement.setDate(5, new java.sql.Date(course.getEndDate().getTime()));
            } else {
                statement.setNull(5, java.sql.Types.DATE);
            }

            statement.setString(6, course.getStatus());
            statement.setInt(7, course.getCourseCategoryId());

            if (course.getInstructor() != null) {
                statement.setInt(8, course.getInstructor().getId());
            } else {
                statement.setNull(8, java.sql.Types.INTEGER);
            }

            statement.setString(9, course.getRequirements());

            int paramIndex = 10;
            if (course.getCourseImage() != null && !course.getCourseImage().isEmpty()) {
                statement.setString(paramIndex++, course.getCourseImage());
            }

            statement.setInt(paramIndex, course.getId());

            int affectedRows = statement.executeUpdate();

            if (affectedRows > 0) {
                // Update learning outcomes
                if (course.getLearningOutcomes() != null) {
                    // Delete existing outcomes
                    deleteLearningOutcomes(course.getId());

                    // Insert new outcomes
                    insertLearningOutcomes(course.getId(), course.getLearningOutcomes());
                }

                connection.commit();
                return true;
            }

            connection.rollback();
            return false;
        } catch (SQLException e) {
            try {
                connection.rollback();
            } catch (SQLException ex) {
                System.out.println("Error rolling back transaction: " + ex.getMessage());
            }
            System.out.println("Error updating course: " + e.getMessage());
            return false;
        } finally {
            try {
                connection.setAutoCommit(true);
            } catch (SQLException e) {
                System.out.println("Error resetting auto-commit: " + e.getMessage());
            }
        }
    }

    public boolean deleteCourse(int courseId) {
        String sql = "DELETE FROM Course WHERE ID = ?";

        try {
            connection.setAutoCommit(false);

            // Delete learning outcomes first (cascade should handle this, but just to be safe)
            deleteLearningOutcomes(courseId);

            // Delete course
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, courseId);

            int affectedRows = statement.executeUpdate();

            connection.commit();
            return affectedRows > 0;
        } catch (SQLException e) {
            try {
                connection.rollback();
            } catch (SQLException ex) {
                System.out.println("Error rolling back transaction: " + ex.getMessage());
            }
            System.out.println("Error deleting course: " + e.getMessage());
            return false;
        } finally {
            try {
                connection.setAutoCommit(true);
            } catch (SQLException e) {
                System.out.println("Error resetting auto-commit: " + e.getMessage());
            }
        }
    }

    private void deleteLearningOutcomes(int courseId) throws SQLException {
        String sql = "DELETE FROM LearningOutcome WHERE courseId = ?";

        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setInt(1, courseId);
        statement.executeUpdate();
    }

    private void insertLearningOutcomes(int courseId, List<String> outcomes) throws SQLException {
        String sql = "INSERT INTO LearningOutcome (courseId, outcomeText) VALUES (?, ?)";

        PreparedStatement statement = connection.prepareStatement(sql);

        for (String outcome : outcomes) {
            if (outcome != null && !outcome.trim().isEmpty()) {
                statement.setInt(1, courseId);
                statement.setString(2, outcome.trim());
                statement.addBatch();
            }
        }

        statement.executeBatch();
    }

    private Course extractCourseFromResultSet(ResultSet rs) throws SQLException {
        Course course = new Course();
        course.setId(rs.getInt("ID"));
        course.setCourseName(rs.getString("courseName"));
        course.setCourseTitle(rs.getString("courseTitle"));
        course.setCourseDescription(rs.getString("courseDescription"));
        course.setCourseImage(rs.getString("courseImage"));
        course.setStartDate(rs.getDate("startDate"));
        course.setEndDate(rs.getDate("endDate"));
        course.setStatus(rs.getString("status"));
        course.setCourseCategoryId(rs.getInt("courseCategoryId"));

        // Create and set the CourseCategory
        CourseCategory category = new CourseCategory();
        category.setId(rs.getInt("courseCategoryId"));
        category.setName(rs.getString("categoryName"));
        course.setCourseCategory(category);

        return course;
    }
}
