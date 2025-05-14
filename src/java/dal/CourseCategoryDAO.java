package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.CourseCategory;

public class CourseCategoryDAO extends DBContext {

    public List<CourseCategory> getAllCategories() {
        List<CourseCategory> categories = new ArrayList<>();
        String sql = "SELECT * FROM CourseCategory";

        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            ResultSet rs = statement.executeQuery();

            while (rs.next()) {
                CourseCategory category = new CourseCategory();
                category.setId(rs.getInt("ID"));
                category.setName(rs.getString("Name"));
                categories.add(category);
            }
        } catch (SQLException e) {
            System.out.println("Error retrieving categories: " + e.getMessage());
        }

        return categories;
    }

    public List<CourseCategory> getTopCategories(int limit) {
        List<CourseCategory> categories = new ArrayList<>();
        String sql = "SELECT TOP (?) cc.ID, cc.Name, COUNT(c.ID) as courseCount "
                + "FROM CourseCategory cc "
                + "LEFT JOIN Course c ON cc.ID = c.courseCategoryId "
                + "GROUP BY cc.ID, cc.Name "
                + "ORDER BY courseCount DESC";

        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, limit);
            ResultSet rs = statement.executeQuery();

            while (rs.next()) {
                CourseCategory category = new CourseCategory();
                category.setId(rs.getInt("ID"));
                category.setName(rs.getString("Name"));
                categories.add(category);
            }
        } catch (SQLException e) {
            System.out.println("Error retrieving top categories: " + e.getMessage());
        }

        return categories;
    }

    public CourseCategory getCategoryById(int categoryId) {
        String sql = "SELECT * FROM CourseCategory WHERE ID = ?";

        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, categoryId);

            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                CourseCategory category = new CourseCategory();
                category.setId(rs.getInt("ID"));
                category.setName(rs.getString("Name"));
                return category;
            }
        } catch (SQLException e) {
            System.out.println("Error retrieving category: " + e.getMessage());
        }

        return null;
    }

    public boolean addCategory(CourseCategory category) {
        String sql = "INSERT INTO [CourseCategory] ([Name]) VALUES (?)";

        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, category.getName());

            int rowsAffected = statement.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.out.println("Error adding category: " + e.getMessage());
            return false;
        }
    }

    

    public boolean updateCategory(CourseCategory category) {
        String sql = "UPDATE [CourseCategory] SET [Name] = ? WHERE ID = ?";

        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, category.getName());
            statement.setInt(2, category.getId());

            int rowsAffected = statement.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.out.println("Error updating category: " + e.getMessage());
            return false;
        }
    }

    public boolean deleteCategory(int categoryId) {
        String sql = "DELETE FROM [CourseCategory] WHERE ID = ?";

        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, categoryId);

            int rowsAffected = statement.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.out.println("Error deleting category: " + e.getMessage());
            return false;
        }
    }

    public int getCoursesCountByCategory(int categoryId) {
        String sql = "SELECT COUNT(*) as count FROM [Course] WHERE courseCategoryId = ?";

        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, categoryId);
            ResultSet rs = statement.executeQuery();

            if (rs.next()) {
                return rs.getInt("count");
            }
        } catch (SQLException e) {
            System.out.println("Error counting courses by category: " + e.getMessage());
        }

        return 0;
    }
}
