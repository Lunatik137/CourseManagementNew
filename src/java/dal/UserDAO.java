package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Role;
import model.User;

public class UserDAO extends DBContext {

    public User login(String username, String password) {
        String sql = "SELECT * FROM [User] WHERE username = ? AND password = ?";

        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, username);
            statement.setString(2, password);
            ResultSet rs = statement.executeQuery();

            if (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("ID"));
                user.setUsername(rs.getString("username"));
                user.setRoleId(rs.getInt("roleId"));
                user.setPhoneNumber(rs.getString("phoneNumber"));
                user.setGender(rs.getString("gender"));
                user.setDob(rs.getDate("dob"));
                user.setIdentityCard(rs.getString("identityCard"));
                user.setEmail(rs.getString("email"));
                user.setStudentID(rs.getString("studentID"));
                return user;
            }
        } catch (SQLException e) {
            System.out.println("Error during login: " + e.getMessage());
        }

        return null;
    }

    public boolean checkUsernameExists(String username) {
        String sql = "SELECT COUNT(*) as count FROM [User] WHERE username = ?";

        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, username);
            ResultSet rs = statement.executeQuery();

            if (rs.next()) {
                return rs.getInt("count") > 0;
            }
        } catch (SQLException e) {
            System.out.println("Error checking username: " + e.getMessage());
        }

        return false;
    }

    public List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        String sql = "SELECT u.*, r.roleName FROM [User] u "
                + "LEFT JOIN [Role] r ON u.roleId = r.ID "
                + "ORDER BY u.ID";

        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            ResultSet rs = statement.executeQuery();

            while (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("ID"));
                user.setUsername(rs.getString("username"));
                user.setRoleId(rs.getInt("roleId"));
                user.setPhoneNumber(rs.getString("phoneNumber"));
                user.setGender(rs.getString("gender"));
                user.setDob(rs.getDate("dob"));
                user.setIdentityCard(rs.getString("identityCard"));
                user.setEmail(rs.getString("email"));
                user.setStudentID(rs.getString("studentID"));

                // Tạo đối tượng Role
                Role role = new Role();
                role.setId(rs.getInt("roleId"));
                role.setRoleName(rs.getString("roleName"));
                user.setRole(role);

                users.add(user);
            }
        } catch (SQLException e) {
            System.out.println("Error retrieving users: " + e.getMessage());
        }

        return users;
    }

    public boolean register(User user) {
        String sql = "INSERT INTO [User] (username, password, roleId, phoneNumber, gender, dob, email, identityCard, studentID) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, user.getUsername());
            statement.setString(2, user.getPassword());
            statement.setInt(3, 2); // Default role is Student (roleId = 2)
            statement.setString(4, user.getPhoneNumber());
            statement.setString(5, user.getGender());
            statement.setDate(6, new java.sql.Date(user.getDob().getTime()));
            statement.setString(7, user.getEmail());
            statement.setString(8, user.getIdentityCard());
            statement.setString(9, user.getStudentID());

            if (user.getDob() != null) {
                statement.setDate(6, new java.sql.Date(user.getDob().getTime()));
            } else {
                statement.setNull(6, java.sql.Types.DATE);
            }

            statement.setString(7, user.getEmail());

            int rowsAffected = statement.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.out.println("Error during registration: " + e.getMessage());
            return false;
        }
    }

    public User getUserById(int userId) {
        String sql = "SELECT * FROM [User] WHERE ID = ?";

        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, userId);
            ResultSet rs = statement.executeQuery();

            if (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("ID"));
                user.setUsername(rs.getString("username"));
                user.setRoleId(rs.getInt("roleId"));
                user.setPhoneNumber(rs.getString("phoneNumber"));
                user.setGender(rs.getString("gender"));
                user.setDob(rs.getDate("dob"));
                user.setIdentityCard(rs.getString("identityCard"));
                user.setEmail(rs.getString("email"));
                user.setStudentID(rs.getString("studentID"));
                return user;
            }
        } catch (SQLException e) {
            System.out.println("Error retrieving user: " + e.getMessage());
        }

        return null;
    }

    public boolean verifyPassword(int userId, String password) {
        String sql = "SELECT COUNT(*) as count FROM [User] WHERE ID = ? AND password = ?";

        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, userId);
            statement.setString(2, password);
            ResultSet rs = statement.executeQuery();

            if (rs.next()) {
                return rs.getInt("count") > 0;
            }
        } catch (SQLException e) {
            System.out.println("Error verifying password: " + e.getMessage());
        }

        return false;
    }

    public boolean updateUserProfile(User user, boolean updatePassword) {
        StringBuilder sql = new StringBuilder("UPDATE [User] SET email = ?, phoneNumber = ?, gender = ?, dob = ?, studentID = ?");

        if (updatePassword) {
            sql.append(", password = ?");
        }

        sql.append(" WHERE ID = ?");

        try {
            PreparedStatement statement = connection.prepareStatement(sql.toString());
            statement.setString(1, user.getEmail());
            statement.setString(2, user.getPhoneNumber());
            statement.setString(3, user.getGender());

            if (user.getDob() != null) {
                statement.setDate(4, new java.sql.Date(user.getDob().getTime()));
            } else {
                statement.setNull(4, java.sql.Types.DATE);
            }

            statement.setString(5, user.getStudentID());

            if (updatePassword) {
                statement.setString(6, user.getPassword());
                statement.setInt(7, user.getId());
            } else {
                statement.setInt(6, user.getId());
            }

            int rowsAffected = statement.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.out.println("Error updating user profile: " + e.getMessage());
            return false;
        }
    }

    public int getTotalUsersByRole(int roleId) {
        String sql = "SELECT COUNT(*) as count FROM [User] WHERE roleId = ?";

        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, roleId);
            ResultSet rs = statement.executeQuery();

            if (rs.next()) {
                return rs.getInt("count");
            }
        } catch (SQLException e) {
            System.out.println("Error counting users by role: " + e.getMessage());
        }

        return 0;
    }

    public boolean deleteUser(int userId) {
        // Không cho phép xóa tài khoản admin (roleId = 1)
        String checkSql = "SELECT roleId FROM [User] WHERE ID = ?";

        try {
            // Bắt đầu transaction
            connection.setAutoCommit(false);

            PreparedStatement checkStatement = connection.prepareStatement(checkSql);
            checkStatement.setInt(1, userId);
            ResultSet rs = checkStatement.executeQuery();

            if (rs.next() && rs.getInt("roleId") == 1) {
                // Không cho phép xóa tài khoản admin
                connection.rollback();
                connection.setAutoCommit(true);
                return false;
            }

            // 1. Xóa các bản ghi trong CourseStudent
            // Mặc dù có ON DELETE CASCADE, nhưng chúng ta sẽ xóa rõ ràng để kiểm soát quá trình
            String deleteEnrollmentsSql = "DELETE FROM [CourseStudent] WHERE studentId = ?";
            PreparedStatement deleteEnrollmentsStmt = connection.prepareStatement(deleteEnrollmentsSql);
            deleteEnrollmentsStmt.setInt(1, userId);
            deleteEnrollmentsStmt.executeUpdate();

            // 2. Tiến hành xóa người dùng
            String deleteUserSql = "DELETE FROM [User] WHERE ID = ?";
            PreparedStatement deleteUserStmt = connection.prepareStatement(deleteUserSql);
            deleteUserStmt.setInt(1, userId);

            int rowsAffected = deleteUserStmt.executeUpdate();

            // Commit transaction nếu mọi thứ thành công
            connection.commit();
            connection.setAutoCommit(true);

            return rowsAffected > 0;
        } catch (SQLException e) {
            // Rollback transaction nếu có lỗi
            try {
                connection.rollback();
                connection.setAutoCommit(true);
            } catch (SQLException ex) {
                System.out.println("Error rolling back transaction: " + ex.getMessage());
            }

            System.out.println("Error deleting user: " + e.getMessage());
            return false;
        }
    }
}
