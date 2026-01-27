package app.bean;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.MultipartConfig;
import java.io.*;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@MultipartConfig
@WebServlet("/addCarController")
public class addCarController extends HttpServlet {

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
                    showEditForm(request, response);
                    break;
                default:
                    listCars(request, response);
                    break;
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        try {
            if ("update".equals(action)) {
                updateCar(request, response); // update car request method
            } else {
                addCar(request, response);   // addcar request method
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }


    // 1. LIST all cars
    private void listCars(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {

        List<addcarbean> allCars = AddCarDAO.getAllCars();

        // Get search query from the request
        String query = request.getParameter("search");
        List<addcarbean> filteredCars = new ArrayList<>();

        if (query != null && !query.isEmpty()) {
            for (addcarbean car : allCars) {
                // Check if model or brand contains the query
                if (car.getModel().toLowerCase().contains(query.toLowerCase()) ||
                    car.getBrand().toLowerCase().contains(query.toLowerCase())) {
                    filteredCars.add(car);
                }
            }
        } else {
            filteredCars = allCars;
        }

        request.setAttribute("cars", filteredCars);
        RequestDispatcher rd = request.getRequestDispatcher("carsection.jsp");
        rd.forward(request, response);
    }


    // 2. DELETE a car
    private void deleteCar(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {

        int carID = Integer.parseInt(request.getParameter("carID"));
        AddCarDAO.deleteCar(carID);
        System.out.println("Car deleted successfully.");
        response.sendRedirect("addCarController?action=list");
    }

    // 3. SHOW edit form for a car
    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {

        int carID = Integer.parseInt(request.getParameter("carID"));
        addcarbean car = AddCarDAO.getCarById(carID);
        request.setAttribute("car", car);
        RequestDispatcher dispatcher = request.getRequestDispatcher("editCar.jsp");
        dispatcher.forward(request, response);
    }

    // 4. ADD a new car
    private void addCar(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {

        String model = request.getParameter("model");
        String brand = request.getParameter("brand");
        int year = Integer.parseInt(request.getParameter("year"));
        double price = Double.parseDouble(request.getParameter("price"));
        int stock = Integer.parseInt(request.getParameter("stock"));

        // Handle file upload
        Part filePart = request.getPart("carImagePath");
        String fileName = filePart.getSubmittedFileName();
        String uploadDir = getServletContext().getRealPath("/images/cars");
        File uploads = new File(uploadDir);
        if (!uploads.exists()) uploads.mkdirs();
        filePart.write(uploadDir + File.separator + fileName);
        String carImagePath = "images/cars/" + fileName;

        // Save car
        addcarbean car = new addcarbean(model, brand, price, year, stock, carImagePath);
        AddCarDAO.addCar(car);

        System.out.println("Car added successfully.");
        response.sendRedirect("addCarController?action=list");
    }

    // 5. UPDATE an existing car
    private void updateCar(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {

        int carID = Integer.parseInt(request.getParameter("carID"));

        // Fetch existing car from DB
        addcarbean car = AddCarDAO.getCarById(carID);

        // Update fields from form
        car.setModel(request.getParameter("model"));
        car.setBrand(request.getParameter("brand"));
        car.setYear(Integer.parseInt(request.getParameter("year")));
        car.setPrice(Double.parseDouble(request.getParameter("price")));
        car.setStock(Integer.parseInt(request.getParameter("stock")));

        // Handle file upload
        Part filePart = request.getPart("carImagePath");
        if (filePart != null && filePart.getSize() > 0) {
            String fileName = filePart.getSubmittedFileName();
            String uploadDir = getServletContext().getRealPath("/images/cars");
            File uploads = new File(uploadDir);
            if (!uploads.exists()) uploads.mkdirs();
            filePart.write(uploadDir + File.separator + fileName);
            car.setCarImagePath("images/cars/" + fileName); // replace old image
        }
        // else keep old image path

        AddCarDAO.updateCar(car);

        System.out.println("Car updated successfully.");
        response.sendRedirect("addCarController?action=list");
    }

}
