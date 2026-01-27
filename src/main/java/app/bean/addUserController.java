package app.bean;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;
import java.util.List;

@MultipartConfig
@WebServlet("/addUserController")
public class addUserController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) action = "list";

        try {
            switch (action) {
                case "list":
                    listUsers(request, response);
                    break;
                case "delete":
                    deleteUser(request, response);
                    break;
                case "edit":
                    showEditForm(request, response);
                    break;
                default:
                    listUsers(request, response);
                    break;
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String userId = request.getParameter("userId");

        try {
            if (userId == null || userId.isEmpty()) {
                addUser(request, response);
            } else {
                updateUser(request, response);
            }
        } catch (SQLException | NoSuchAlgorithmException e) {
            throw new ServletException(e);
        }
    }

    // 1. LIST
    private void listUsers(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {

        List<User> users = AddUserDAO.getAllUsers();
        request.setAttribute("users", users);
        RequestDispatcher rd = request.getRequestDispatcher("usersection.jsp");
        rd.forward(request, response);
    }

    // 2. DELETE
    private void deleteUser(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {

        int userId = Integer.parseInt(request.getParameter("userId"));
        AddUserDAO.deleteUser(userId);
        response.sendRedirect("addUserController?action=list");
    }

    // 3. SHOW EDIT
    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {

        int userId = Integer.parseInt(request.getParameter("userId"));
        User user = AddUserDAO.getUserById(userId);
        request.setAttribute("user", user);
        RequestDispatcher rd = request.getRequestDispatcher("adduser.jsp");
        rd.forward(request, response);
    }


    // 4. ADD
    private void addUser(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, NoSuchAlgorithmException, ServletException {

        User u = new User();
        u.setUsername(request.getParameter("username"));
        u.setPassword(request.getParameter("password")); // DAO will hash
        u.setFullname(request.getParameter("fullname"));
        u.setRole(request.getParameter("role"));
        u.setEmail(request.getParameter("email"));

        // Avatar image upload
        Part filePart = request.getPart("avatar");
        String avatarPath = "images/users/avatar-default.png";

        if (filePart != null && filePart.getSize() > 0) {
            String fileName = filePart.getSubmittedFileName();
            String uploadDir = getServletContext().getRealPath("/images/users");
            File uploads = new File(uploadDir);
            if (!uploads.exists()) uploads.mkdirs();

            filePart.write(uploadDir + File.separator + fileName);
            avatarPath = "images/users/" + fileName;
        }

        u.setAvatar(avatarPath);
        

        AddUserDAO.addUser(u);
        response.sendRedirect("addUserController?action=list");
    }


    // 5. UPDATE
    private void updateUser(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, NoSuchAlgorithmException {

        User u = new User();
        u.setUserId(Integer.parseInt(request.getParameter("userId")));
        u.setUsername(request.getParameter("username"));
        u.setPassword(request.getParameter("password")); // if empty -> DAO keeps old password
        u.setFullname(request.getParameter("fullname"));
        u.setRole(request.getParameter("role"));
        u.setEmail(request.getParameter("email"));

        AddUserDAO.updateUser(u);
        response.sendRedirect("addUserController?action=list");
    }
}
