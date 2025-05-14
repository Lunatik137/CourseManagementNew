package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import model.Instructor;

public class InstructorDAO extends DBContext {
    
    public List<Instructor> getAllInstructors() {
        List<Instructor> instructors = new ArrayList<>();
        String sql = "SELECT * FROM Instructor ORDER BY name";
        
        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            ResultSet rs = statement.executeQuery();
            
            while (rs.next()) {
                Instructor instructor = new Instructor();
                instructor.setId(rs.getInt("ID"));
                instructor.setName(rs.getString("name"));
                instructor.setImage(rs.getString("image"));
                instructor.setDescription(rs.getString("description"));
                
                instructors.add(instructor);
            }
        } catch (SQLException e) {
            System.out.println("Error retrieving instructors: " + e.getMessage());
        }
        
        return instructors;
    }
    
    public Instructor getInstructorById(int instructorId) {
        String sql = "SELECT * FROM Instructor WHERE ID = ?";
        
        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, instructorId);
            
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                Instructor instructor = new Instructor();
                instructor.setId(rs.getInt("ID"));
                instructor.setName(rs.getString("name"));
                instructor.setImage(rs.getString("image"));
                instructor.setDescription(rs.getString("description"));
                
                return instructor;
            }
        } catch (SQLException e) {
            System.out.println("Error retrieving instructor: " + e.getMessage());
        }
        
        return null;
    }
    
    public List<Instructor> searchInstructors(String searchQuery) {
        List<Instructor> instructors = new ArrayList<>();
        String sql = "SELECT * FROM Instructor WHERE name LIKE ? ORDER BY name";
        
        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, "%" + searchQuery + "%");
            
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                Instructor instructor = new Instructor();
                instructor.setId(rs.getInt("ID"));
                instructor.setName(rs.getString("name"));
                instructor.setImage(rs.getString("image"));
                instructor.setDescription(rs.getString("description"));
                
                instructors.add(instructor);
            }
        } catch (SQLException e) {
            System.out.println("Error searching instructors: " + e.getMessage());
        }
        
        return instructors;
    }
    
    public boolean createInstructor(Instructor instructor) {
        String sql = "INSERT INTO Instructor (name, image, description) VALUES (?, ?, ?)";
        
        try {
            PreparedStatement statement = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            statement.setString(1, instructor.getName());
            statement.setString(2, instructor.getImage());
            statement.setString(3, instructor.getDescription());
            
            int affectedRows = statement.executeUpdate();
            
            if (affectedRows > 0) {
                ResultSet generatedKeys = statement.getGeneratedKeys();
                if (generatedKeys.next()) {
                    instructor.setId(generatedKeys.getInt(1));
                }
                return true;
            }
        } catch (SQLException e) {
            System.out.println("Error creating instructor: " + e.getMessage());
        }
        
        return false;
    }
    
    public boolean updateInstructor(Instructor instructor) {
        String sql = "UPDATE Instructor SET name = ?, image = ?, description = ? WHERE ID = ?";
        
        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, instructor.getName());
            statement.setString(2, instructor.getImage());
            statement.setString(3, instructor.getDescription());
            statement.setInt(4, instructor.getId());
            
            int affectedRows = statement.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            System.out.println("Error updating instructor: " + e.getMessage());
        }
        
        return false;
    }
    
    public boolean deleteInstructor(int instructorId) {
        // First, update any courses that reference this instructor to set instructorId to NULL
        String updateCoursesSql = "UPDATE Course SET instructorId = NULL WHERE instructorId = ?";
        
        try {
            // Begin transaction
            connection.setAutoCommit(false);
            
            // Update courses
            PreparedStatement updateCoursesStmt = connection.prepareStatement(updateCoursesSql);
            updateCoursesStmt.setInt(1, instructorId);
            updateCoursesStmt.executeUpdate();
            
            // Delete instructor
            String deleteInstructorSql = "DELETE FROM Instructor WHERE ID = ?";
            PreparedStatement deleteInstructorStmt = connection.prepareStatement(deleteInstructorSql);
            deleteInstructorStmt.setInt(1, instructorId);
            int affectedRows = deleteInstructorStmt.executeUpdate();
            
            // Commit transaction
            connection.commit();
            connection.setAutoCommit(true);
            
            return affectedRows > 0;
        } catch (SQLException e) {
            try {
                // Rollback transaction on error
                connection.rollback();
                connection.setAutoCommit(true);
            } catch (SQLException ex) {
                System.out.println("Error rolling back transaction: " + ex.getMessage());
            }
            System.out.println("Error deleting instructor: " + e.getMessage());
        }
        
        return false;
    }
    
    public int getTotalInstructors() {
        String sql = "SELECT COUNT(*) as count FROM Instructor";
        
        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            ResultSet rs = statement.executeQuery();
            
            if (rs.next()) {
                return rs.getInt("count");
            }
        } catch (SQLException e) {
            System.out.println("Error counting instructors: " + e.getMessage());
        }
        
        return 0;
    }
}