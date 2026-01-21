package app.bean;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.File;
import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;

@MultipartConfig
@WebServlet("/RegisterController")
public class RegisterController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            User u = new User();
            u.setFullname(request.getParameter("fullname"));
            u.setUsername(request.getParameter("username"));
            u.setEmail(request.getParameter("email"));
            u.setPassword(request.getParameter("password"));

            // ✅ Force role = Guest (ignore any incoming "role")
            u.setRole("Guest");

            // ✅ Optional avatar upload, else default
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

            // Save user
            AddUserDAO.addUser(u);

            // After register -> go login
            response.sendRedirect("LoginPage.jsp");

        } catch (SQLException | NoSuchAlgorithmException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Registration failed. Please try again.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }
}
