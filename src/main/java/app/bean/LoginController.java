package app.bean;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;

@WebServlet("/LoginController")
public class LoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String username = request.getParameter("username");
		String password = request.getParameter("password");

		loginbean login = new loginbean();
		login.setUsername(username);
		login.setPassword(password);

		try {
			login = UserDAO.login(login);

			if (login.isLoggedIn()) {
				HttpSession session = request.getSession(true);
				session.setAttribute("login", login);
				session.setAttribute("userid", login.getUserId());
				session.setAttribute("username", login.getUsername());

				response.sendRedirect("Dashboard.jsp");
			} else {
				request.setAttribute("errorMessage", "Invalid username or password.");
				request.getRequestDispatcher("LoginPage.jsp").forward(request, response);
			}

		} catch (SQLException | NoSuchAlgorithmException e) {
			e.printStackTrace();
			request.setAttribute("errorMessage", "System error. Please try again.");
			request.getRequestDispatcher("LoginPage.jsp").forward(request, response);
		}
	}
}
