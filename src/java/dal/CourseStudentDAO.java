package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Course;
import model.CourseStudent;
import model.Instructor;
import model.User;

public class CourseStudentDAO extends DBContext {

    public boolean isStudentEnrolledInCourse(int studentId, int courseId) {
        String sql = "SELECT COUNT(*) as count FROM CourseStudent WHERE studentId = ? AND courseId = ?";

        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, studentId);
            statement.setInt(2, courseId);
            ResultSet rs = statement.executeQuery();

            if (rs.next()) {
                return rs.getInt("count") > 0;
            }
        } catch (SQLException e) {
            System.out.println("Error checking enrollment: " + e.getMessage());
        }

        return false;
    }

    public boolean enrollStudentInCourse(int studentId, int courseId) {
        // First check if already enrolled
        if (isStudentEnrolledInCourse(studentId, courseId)) {
            return false;
        }

        String sql = "INSERT INTO CourseStudent (studentId, courseId) VALUES (?, ?)";

        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, studentId);
            statement.setInt(2, courseId);
            int rowsAffected = statement.executeUpdate();

            return rowsAffected > 0;
        } catch (SQLException e) {
            System.out.println("Error enrolling student: " + e.getMessage());
            return false;
        }
    }

    public boolean unenrollStudentFromCourse(int studentId, int courseId) {
        String sql = "DELETE FROM CourseStudent WHERE studentId = ? AND courseId = ?";

        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, studentId);
            statement.setInt(2, courseId);
            int rowsAffected = statement.executeUpdate();

            return rowsAffected > 0;
        } catch (SQLException e) {
            System.out.println("Error unenrolling student: " + e.getMessage());
            return false;
        }
    }

    public List<CourseStudent> getEnrollmentsByStudentId(int studentId) {
        List<CourseStudent> enrollments = new ArrayList<>();
        String sql = "SELECT cs.*, c.courseName, c.courseTitle, c.courseDescription, c.courseImage, "
                + "c.startDate, c.endDate, c.status as courseStatus, c.courseCategoryId, cc.Name as categoryName, "
                + "i.ID as instructorId, i.name as instructorName, i.image as instructorImage "
                + "FROM CourseStudent cs "
                + "JOIN Course c ON cs.courseId = c.ID "
                + "JOIN CourseCategory cc ON c.courseCategoryId = cc.ID "
                + "LEFT JOIN Instructor i ON c.instructorId = i.ID "
                + "WHERE cs.studentId = ? "
                + "ORDER BY cs.enrollDate DESC";

        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, studentId);

            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                CourseStudent enrollment = new CourseStudent();
                enrollment.setStudentId(rs.getInt("studentId"));
                enrollment.setCourseId(rs.getInt("courseId"));
                enrollment.setEnrollDate(rs.getTimestamp("enrollDate"));
                enrollment.setStatus(rs.getString("status"));

                // Create course object
                Course course = new Course();
                course.setId(rs.getInt("courseId"));
                course.setCourseName(rs.getString("courseName"));
                course.setCourseTitle(rs.getString("courseTitle"));
                course.setCourseDescription(rs.getString("courseDescription"));
                course.setCourseImage(rs.getString("courseImage"));
                course.setStartDate(rs.getDate("startDate"));
                course.setEndDate(rs.getDate("endDate"));
                course.setStatus(rs.getString("courseStatus"));
                course.setCourseCategoryId(rs.getInt("courseCategoryId"));

                // Set instructor if available
                int instructorId = rs.getInt("instructorId");
                if (!rs.wasNull()) {
                    Instructor instructor = new Instructor();
                    instructor.setId(instructorId);
                    instructor.setName(rs.getString("instructorName"));
                    instructor.setImage(rs.getString("instructorImage"));
                    course.setInstructor(instructor);
                }

                enrollment.setCourse(course);
                enrollments.add(enrollment);
            }
        } catch (SQLException e) {
            System.out.println("Error getting enrollments: " + e.getMessage());
        }

        return enrollments;
    }

    public boolean updateEnrollmentStatus(int studentId, int courseId, String status) {
        String sql = "UPDATE CourseStudent SET status = ? WHERE studentId = ? AND courseId = ?";

        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, status);
            statement.setInt(2, studentId);
            statement.setInt(3, courseId);

            int rowsAffected = statement.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.out.println("Error updating enrollment status: " + e.getMessage());
            return false;
        }
    }

    public boolean deleteEnrollment(int studentId, int courseId) {
        String sql = "DELETE FROM CourseStudent WHERE studentId = ? AND courseId = ?";

        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, studentId);
            statement.setInt(2, courseId);

            int rowsAffected = statement.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.out.println("Error deleting enrollment: " + e.getMessage());
            return false;
        }
    }

    public List<CourseStudent> getStudentsByCourseId(int courseId) {
        List<CourseStudent> students = new ArrayList<>();
        String sql = "SELECT cs.*, u.username, u.email, u.phoneNumber, u.gender, u.dob, u.identityCard, u.studentID "
                + "FROM CourseStudent cs "
                + "JOIN [User] u ON cs.studentId = u.ID "
                + "WHERE cs.courseId = ? "
                + "ORDER BY cs.enrollDate DESC";

        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, courseId);
            ResultSet rs = statement.executeQuery();

            while (rs.next()) {
                CourseStudent courseStudent = new CourseStudent();
                courseStudent.setStudentId(rs.getInt("studentId"));
                courseStudent.setCourseId(rs.getInt("courseId"));
                courseStudent.setEnrollDate(rs.getTimestamp("enrollDate"));
                courseStudent.setStatus(rs.getString("status"));

                // Set user information
                User student = new User();
                student.setId(rs.getInt("studentId"));
                student.setUsername(rs.getString("username"));
                student.setEmail(rs.getString("email"));
                student.setPhoneNumber(rs.getString("phoneNumber"));
                student.setGender(rs.getString("gender"));
                student.setDob(rs.getDate("dob"));
                student.setIdentityCard(rs.getString("identityCard"));
                student.setStudentID(rs.getString("studentID"));

                courseStudent.setStudent(student);
                students.add(courseStudent);
            }
        } catch (SQLException e) {
            System.out.println("Error retrieving students: " + e.getMessage());
        }

        return students;
    }

    public boolean updateStudentStatus(int studentId, int courseId, String status) {
        String sql = "UPDATE CourseStudent SET status = ? WHERE studentId = ? AND courseId = ?";

        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, status);
            statement.setInt(2, studentId);
            statement.setInt(3, courseId);

            int affectedRows = statement.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            System.out.println("Error updating student status: " + e.getMessage());
            return false;
        }
    }

    public CourseStudent getStudentCourse(int studentId, int courseId) {
        String sql = "SELECT cs.*, u.username, u.email, u.phoneNumber, "
                + "c.courseName, c.courseTitle "
                + "FROM CourseStudent cs "
                + "JOIN [User] u ON cs.studentId = u.ID "
                + "JOIN Course c ON cs.courseId = c.ID "
                + "WHERE cs.studentId = ? AND cs.courseId = ?";

        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, studentId);
            statement.setInt(2, courseId);
            ResultSet rs = statement.executeQuery();

            if (rs.next()) {
                CourseStudent courseStudent = new CourseStudent();
                courseStudent.setStudentId(rs.getInt("studentId"));
                courseStudent.setCourseId(rs.getInt("courseId"));
                courseStudent.setEnrollDate(rs.getTimestamp("enrollDate"));
                courseStudent.setStatus(rs.getString("status"));

                // Set user information
                User student = new User();
                student.setId(rs.getInt("studentId"));
                student.setUsername(rs.getString("username"));
                student.setEmail(rs.getString("email"));
                student.setPhoneNumber(rs.getString("phoneNumber"));
                courseStudent.setStudent(student);

                // Set course information
                Course course = new Course();
                course.setId(rs.getInt("courseId"));
                course.setCourseName(rs.getString("courseName"));
                course.setCourseTitle(rs.getString("courseTitle"));
                courseStudent.setCourse(course);

                return courseStudent;
            }
        } catch (SQLException e) {
            System.out.println("Error retrieving student course: " + e.getMessage());
        }

        return null;
    }

    public int getTotalStudentsByCourseId(int courseId) {
        String sql = "SELECT COUNT(*) as count FROM CourseStudent WHERE courseId = ?";

        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, courseId);
            ResultSet rs = statement.executeQuery();

            if (rs.next()) {
                return rs.getInt("count");
            }
        } catch (SQLException e) {
            System.out.println("Error counting students: " + e.getMessage());
        }

        return 0;
    }

    public String getStudentStatusInCourse(int studentId, int courseId) {
        String sql = "SELECT status FROM CourseStudent WHERE studentId = ? AND courseId = ?";

        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, studentId);
            statement.setInt(2, courseId);
            ResultSet rs = statement.executeQuery();

            if (rs.next()) {
                return rs.getString("status");
            }
        } catch (SQLException e) {
            System.out.println("Error checking student status: " + e.getMessage());
        }

        return null; 
    }
}
