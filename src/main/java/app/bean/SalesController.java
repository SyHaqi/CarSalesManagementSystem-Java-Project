package app.bean;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.*;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/SalesController")
public class SalesController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final Map<String, Double> ACCESSORY_PRICE = new HashMap<>();
    static {
        ACCESSORY_PRICE.put("Spoiler", 200.0);
        ACCESSORY_PRICE.put("Bonnet Protector", 150.0);
        ACCESSORY_PRICE.put("Tinted Windows", 300.0);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // only show cars with stock > 0
            request.setAttribute("cars", AddCarDAO.getCarsInStock());

            // if car chosen, load its price
            String carID = request.getParameter("carID");
            if (carID != null && !carID.isEmpty()) {
                addcarbean car = AddCarDAO.getCarById(Integer.parseInt(carID));
                if (car != null) {
                    request.setAttribute("selectedCarPrice", car.getPrice());
                }
            }

            request.getRequestDispatcher("salesentry.jsp").forward(request, response);
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("login") == null) {
            response.sendRedirect("LoginPage.jsp");
            return;
        }

        User login = (User) session.getAttribute("login");
        int userId = login.getUserId();

        int carId = Integer.parseInt(request.getParameter("carID"));
        String customerName = request.getParameter("customerName");
        Date saleDate = Date.valueOf(request.getParameter("saleDate"));

        String commissionStr = request.getParameter("commission");
        double commission = 0.0;
        if (commissionStr != null && !commissionStr.trim().isEmpty()) {
            commission = Double.parseDouble(commissionStr);
        }

        String[] accessories = request.getParameterValues("accessories");

        Connection con = null;

        try {
            con = ConnectionManager.getConnection();
            con.setAutoCommit(false);

            // 1) fetch car info + ensure stock > 0
            double carPrice;
            String carBrand;
            String carModel;
            int stock;

            try (PreparedStatement ps = con.prepareStatement(
                    "SELECT brand, model, price, stock FROM cars WHERE carID=? FOR UPDATE")) {
                ps.setInt(1, carId);
                try (ResultSet rs = ps.executeQuery()) {
                    if (!rs.next()) throw new ServletException("Car not found.");
                    carBrand = rs.getString("brand");
                    carModel = rs.getString("model");
                    carPrice = rs.getDouble("price");
                    stock = rs.getInt("stock");
                }
            }

            if (stock <= 0) throw new ServletException("Car is out of stock.");

            // 2) accessories total
            double accessoriesTotal = 0.0;
            if (accessories != null) {
                for (String a : accessories) {
                    accessoriesTotal += ACCESSORY_PRICE.getOrDefault(a, 0.0);
                }
            }

            double totalCost = carPrice + accessoriesTotal;

            // 3) insert sale
            int saleId;
            try (PreparedStatement ps = con.prepareStatement(
                    "INSERT INTO sales (userId, carID, customerName, totalCost, commission, saleDate) VALUES (?, ?, ?, ?, ?, ?)",
                    Statement.RETURN_GENERATED_KEYS)) {
                ps.setInt(1, userId);
                ps.setInt(2, carId);
                ps.setString(3, customerName);
                ps.setDouble(4, totalCost);
                ps.setDouble(5, commission);
                ps.setDate(6, saleDate);
                ps.executeUpdate();

                try (ResultSet keys = ps.getGeneratedKeys()) {
                    if (!keys.next()) throw new ServletException("Failed to create sale.");
                    saleId = keys.getInt(1);
                }
            }

            // 4) insert accessories
            if (accessories != null) {
                try (PreparedStatement ps = con.prepareStatement(
                        "INSERT INTO accessories (saleID, accessoryName, cost) VALUES (?, ?, ?)")) {
                    for (String a : accessories) {
                        ps.setInt(1, saleId);
                        ps.setString(2, a);
                        ps.setDouble(3, ACCESSORY_PRICE.getOrDefault(a, 0.0));
                        ps.addBatch();
                    }
                    ps.executeBatch();
                }
            }

            // 5) reduce stock by 1
            try (PreparedStatement ps = con.prepareStatement(
                    "UPDATE cars SET stock = stock - 1 WHERE carID=?")) {
                ps.setInt(1, carId);
                ps.executeUpdate();
            }

            con.commit();

            // 6) forward to confirmation page with details
            request.setAttribute("saleId", saleId);
            request.setAttribute("customerName", customerName);
            request.setAttribute("saleDate", saleDate);
            request.setAttribute("commission", commission);

            request.setAttribute("carBrand", carBrand);
            request.setAttribute("carModel", carModel);
            request.setAttribute("carPrice", carPrice);

            request.setAttribute("accessories", accessories);
            request.setAttribute("accessoriesTotal", accessoriesTotal);
            request.setAttribute("totalCost", totalCost);

            request.getRequestDispatcher("salesConfirm.jsp").forward(request, response);

        } catch (Exception e) {
            try { if (con != null) con.rollback(); } catch (SQLException ignored) {}
            throw new ServletException(e);
        } finally {
            try { if (con != null) con.close(); } catch (SQLException ignored) {}
        }
    }
}
