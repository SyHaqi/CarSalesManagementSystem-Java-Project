package app.bean;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AddUserDAO {

    private static Connection connection = null;

    // Helper: MD5 hash
    private static String md5(String input) throws NoSuchAlgorithmException {
        MessageDigest md = MessageDigest.getInstance("MD5");
        md.update(input.getBytes());
        byte[] byteData = md.digest();

        StringBuilder sb = new StringBuilder();
        for (byte b : byteData) sb.append(String.format("%02x", b));
        return sb.toString();
    }

    // CREATE
    public static void addUser(User user) throws SQLException, NoSuchAlgorithmException {
        String sql = "INSERT INTO loginpage (username, password, fullname, role, email, avatar) VALUES (?, ?, ?, ?, ?, ?)";

        try {
            connection = ConnectionManager.getConnection();
            PreparedStatement ps = connection.prepareStatement(sql);

            ps.setString(1, user.getUsername());
            ps.setString(2, md5(user.getPassword()));
            ps.setString(3, user.getFullname());
            ps.setString(4, user.getRole());
            ps.setString(5, user.getEmail());
            ps.setString(6, user.getAvatar());  // avatar filepath

            ps.executeUpdate();
            ps.close();
        } finally {
            if (connection != null) connection.close();
        }
    }

    // READ ALL
    public static List<User> getAllUsers() throws SQLException {
        List<User> list = new ArrayList<>();
        String sql = "SELECT userId, username, fullname, role, email, avatar FROM loginpage";

        try {
            connection = ConnectionManager.getConnection();
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                User u = new User();
                u.setUserId(rs.getInt("userId"));
                u.setUsername(rs.getString("username"));
                u.setFullname(rs.getString("fullname"));
                u.setRole(rs.getString("role"));
                u.setEmail(rs.getString("email"));
                u.setAvatar(rs.getString("avatar"));   
                list.add(u);
            }

            rs.close();
            ps.close();
        } finally {
            if (connection != null) connection.close();
        }

        return list;
    }

    // READ BY ID
    public static User getUserById(int userId) throws SQLException {
        User u = null;
        String sql = "SELECT userId, username, fullname, role, email, avatar FROM loginpage WHERE userId = ?";

        try {
            connection = ConnectionManager.getConnection();
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                u = new User();
                u.setUserId(rs.getInt("userId"));
                u.setUsername(rs.getString("username"));
                u.setFullname(rs.getString("fullname"));
                u.setRole(rs.getString("role"));
                u.setEmail(rs.getString("email"));
                u.setAvatar(rs.getString("avatar"));  
            }

            rs.close();
            ps.close();
        } finally {
            if (connection != null) connection.close();
        }

        return u;
    }

    // UPDATE
    // - password optional (if empty -> keep old)
    // - avatar optional (if empty -> keep old)
    public static void updateUser(User user) throws SQLException, NoSuchAlgorithmException {

        boolean updatePassword = user.getPassword() != null && !user.getPassword().trim().isEmpty();
        boolean updateAvatar = user.getAvatar() != null && !user.getAvatar().trim().isEmpty();

        // Build SQL based on what user is updating
        String sql;

        if (updatePassword && updateAvatar) {
            sql = "UPDATE loginpage SET username=?, password=?, fullname=?, role=?, email=?, avatar=? WHERE userId=?";
        } else if (updatePassword) {
            sql = "UPDATE loginpage SET username=?, password=?, fullname=?, role=?, email=? WHERE userId=?";
        } else if (updateAvatar) {
            sql = "UPDATE loginpage SET username=?, fullname=?, role=?, email=?, avatar=? WHERE userId=?";
        } else {
            sql = "UPDATE loginpage SET username=?, fullname=?, role=?, email=? WHERE userId=?";
        }

        try {
            connection = ConnectionManager.getConnection();
            PreparedStatement ps = connection.prepareStatement(sql);

            int i = 1;

            ps.setString(i++, user.getUsername());

            if (updatePassword) {
                ps.setString(i++, md5(user.getPassword()));
            }

            ps.setString(i++, user.getFullname());
            ps.setString(i++, user.getRole());
            ps.setString(i++, user.getEmail());

            if (updateAvatar) {
                ps.setString(i++, user.getAvatar());
            }

            ps.setInt(i, user.getUserId());

            ps.executeUpdate();
            ps.close();
        } finally {
            if (connection != null) connection.close();
        }
    }

    // DELETE
    public static void deleteUser(int userId) throws SQLException {
        String sql = "DELETE FROM loginpage WHERE userId = ?";

        try {
            connection = ConnectionManager.getConnection();
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, userId);
            ps.executeUpdate();
            ps.close();
        } finally {
            if (connection != null) connection.close();
        }
    }
}
