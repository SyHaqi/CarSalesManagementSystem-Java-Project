package app.bean;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;


@MultipartConfig
@WebServlet("/addCarController")
public class addCarController extends HttpServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) action = "list";

        try {
            switch (action) {
                case "delete":
                    deleteCar(request, response);
                    break;
                case "edit":
                    editForm(request, response);
                    break;
                default:
                    listCars(request, response);
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            addCar(request, response);
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    private void listCars(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {

        List<addcarbean> cars = AddCarDAO.getAllCars();
        request.setAttribute("cars", cars);
        RequestDispatcher rd = request.getRequestDispatcher("carsection.jsp");
        rd.forward(request, response);
    }

    private void addCar(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {

        // Get text fields
        String model = request.getParameter("model");
        String brand = request.getParameter("brand");
        int year = Integer.parseInt(request.getParameter("year"));
        double price = Double.parseDouble(request.getParameter("price"));
        int stock = Integer.parseInt(request.getParameter("stock"));

        // Get uploaded file
        Part filePart = request.getPart("carImagePath"); // name="car_image" in JSP
        String fileName = filePart.getSubmittedFileName();
        String uploadDir = getServletContext().getRealPath("/images/cars");
        File uploads = new File(uploadDir);
        if (!uploads.exists()) uploads.mkdirs();
        filePart.write(uploadDir + File.separator + fileName);

        // Save path to DB
        String carImagePath = "images/cars/" + fileName;

        // Create bean and save
        addcarbean car = new addcarbean(model, brand, price, year, stock, carImagePath);
        AddCarDAO.addCar(car);

        response.sendRedirect("addCarController?action=list");
    }
    private void deleteCar(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {

        int carID = Integer.parseInt(request.getParameter("carID"));
        AddCarDAO.deleteCar(carID);
        response.sendRedirect("AddCarController?action=list");
    }

    private void editForm(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {

        int carID = Integer.parseInt(request.getParameter("carID"));
        addcarbean car = AddCarDAO.getCarById(carID);
        request.setAttribute("car", car);
        RequestDispatcher rd = request.getRequestDispatcher("editCar.jsp");
        rd.forward(request, response);
    }
}
