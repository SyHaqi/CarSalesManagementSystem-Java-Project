package app.bean;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class SalesDAO {

    // CREATE sale + reduce stock (transaction)
    public static void addSale(Sales sale) throws SQLException {
        Connection con = null;

        String checkStockSql = "SELECT stock FROM cars WHERE carID = ?";
        String updateStockSql = "UPDATE cars SET stock = stock - 1 WHERE carID = ? AND stock > 0";
        String insertSaleSql =
                "INSERT INTO sales (userId, carID, customerName, totalCost, commission, saleDate) " +
                "VALUES (?, ?, ?, ?, ?, ?)";

        try {
            con = ConnectionManager.getConnection();
            con.setAutoCommit(false);

            // check stock
            try (PreparedStatement ps = con.prepareStatement(checkStockSql)) {
                ps.setInt(1, sale.getCarID());
                try (ResultSet rs = ps.executeQuery()) {
                    if (!rs.next()) {
                        throw new SQLException("Car not found.");
                    }
                    int stock = rs.getInt("stock");
                    if (stock <= 0) {
                        throw new SQLException("Car out of stock.");
                    }
                }
            }

            // reduce stock
            try (PreparedStatement ps = con.prepareStatement(updateStockSql)) {
                ps.setInt(1, sale.getCarID());
                int affected = ps.executeUpdate();
                if (affected == 0) {
                    throw new SQLException("Failed to reduce stock (maybe out of stock).");
                }
            }

            // insert sale
            try (PreparedStatement ps = con.prepareStatement(insertSaleSql)) {
                ps.setInt(1, sale.getUserId());
                ps.setInt(2, sale.getCarID());
                ps.setString(3, sale.getCustomerName());
                ps.setDouble(4, sale.getTotalCost());
                ps.setDouble(5, sale.getCommission());
                ps.setDate(6, sale.getSaleDate());
                ps.executeUpdate();
            }

            con.commit();
        } catch (SQLException e) {
            if (con != null) con.rollback();
            throw e;
        } finally {
            if (con != null) {
                con.setAutoCommit(true);
                con.close();
            }
        }
    }
    
    
}
