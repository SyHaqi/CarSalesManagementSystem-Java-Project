package app.bean;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDAO {

    private static Connection con = null;
    private static PreparedStatement ps = null;
    private static ResultSet rs = null;

    // ✅ include avatar + fullname + role + email (so session has everything)
    private static final String SELECT_LOGIN =
        "SELECT userId, username, fullname, role, email, avatar FROM loginpage WHERE username = ? AND password = ?";

    public static User login(User login)
            throws SQLException, NoSuchAlgorithmException {

        // MD5 hashing
        MessageDigest md = MessageDigest.getInstance("MD5");
        md.update(login.getPassword().getBytes());
        byte[] byteData = md.digest();

        StringBuilder sb = new StringBuilder();
        for (byte b : byteData) {
            sb.append(String.format("%02x", b));
        }

        try {
            con = ConnectionManager.getConnection();
            ps = con.prepareStatement(SELECT_LOGIN);
            ps.setString(1, login.getUsername());
            ps.setString(2, sb.toString());

            rs = ps.executeQuery();

            if (rs.next()) {
                login.setUserId(rs.getInt("userId"));
                login.setUsername(rs.getString("username"));
                login.setFullname(rs.getString("fullname"));
                login.setRole(rs.getString("role"));
                login.setEmail(rs.getString("email"));
                login.setAvatar(rs.getString("avatar"));
                login.setLoggedIn(true);
            } else {
                login.setLoggedIn(false);
            }

        } finally {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (con != null) con.close();
        }

        return login;
    }
}
