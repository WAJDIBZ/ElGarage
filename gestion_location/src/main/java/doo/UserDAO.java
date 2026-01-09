package doo;

import entity.User;
import util.SingletonConnex;

import java.sql.*;

public class UserDAO {
    /** Récupère l’utilisateur par username */
    public User findByUsername(String username) {
        String sql = "SELECT * FROM users WHERE username = ?";
        Connection c = SingletonConnex.getConnection();
        try (
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, username);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    User u = new User();
                    u.setUserId(rs.getInt("userId"));
                    u.setUsername(rs.getString("username"));
                    u.setPasswordHash(rs.getString("passwordHash"));
                    u.setRole(rs.getString("role"));
                    int cid = rs.getInt("clientId");
                    u.setClientId(rs.wasNull() ? null : cid);
                    return u;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    public boolean addUser(User u) {
        String sql = "INSERT INTO users (username, passwordHash, role, clientId) VALUES (?,?,?,?)";
        Connection c = SingletonConnex.getConnection();
        try (
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, u.getUsername());
            ps.setString(2, u.getPasswordHash());
            ps.setString(3, u.getRole());
            ps.setObject(4, u.getClientId(), java.sql.Types.INTEGER);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

}
