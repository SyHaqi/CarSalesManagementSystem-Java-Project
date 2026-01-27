package app.bean;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class SalesReportDAO {

    // Table rows
    public static List<SalesReport> getSales(Date start, Date end) throws SQLException {
        List<SalesReport> list = new ArrayList<>();

        StringBuilder sql = new StringBuilder();
        sql.append("SELECT s.saleID, s.customerName, s.totalCost, s.saleDate, ");
        sql.append("       c.brand, c.model, u.username ");
        sql.append("FROM sales s ");
        sql.append("JOIN cars c ON s.carID = c.carID ");
        sql.append("JOIN loginpage u ON s.userId = u.userId ");

        if (start != null && end != null) {
            sql.append("WHERE s.saleDate BETWEEN ? AND ? ");
        } else if (start != null) {
            sql.append("WHERE s.saleDate >= ? ");
        } else if (end != null) {
            sql.append("WHERE s.saleDate <= ? ");
        }

        sql.append("ORDER BY s.saleDate DESC, s.saleID DESC");

        try (Connection con = ConnectionManager.getConnection();
             PreparedStatement ps = con.prepareStatement(sql.toString())) {

            int idx = 1;
            if (start != null && end != null) {
                ps.setDate(idx++, start);
                ps.setDate(idx++, end);
            } else if (start != null) {
                ps.setDate(idx++, start);
            } else if (end != null) {
                ps.setDate(idx++, end);
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    SalesReport r = new SalesReport();
                    r.setSaleId(rs.getInt("saleID"));
                    r.setCustomerName(rs.getString("customerName"));
                    r.setTotalCost(rs.getDouble("totalCost"));
                    r.setSaleDate(rs.getDate("saleDate"));
                    r.setCarName(rs.getString("brand") + " " + rs.getString("model"));
                    r.setSalesperson(rs.getString("username"));
                    list.add(r);
                }
            }
        }

        return list;
    }

    // KPI: total cars sold
    public static int getTotalCarsSold(Date start, Date end) throws SQLException {
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM sales ");
        if (start != null && end != null) sql.append("WHERE saleDate BETWEEN ? AND ?");
        else if (start != null) sql.append("WHERE saleDate >= ?");
        else if (end != null) sql.append("WHERE saleDate <= ?");

        try (Connection con = ConnectionManager.getConnection();
             PreparedStatement ps = con.prepareStatement(sql.toString())) {

            int idx = 1;
            if (start != null && end != null) { ps.setDate(idx++, start); ps.setDate(idx++, end); }
            else if (start != null) ps.setDate(idx++, start);
            else if (end != null) ps.setDate(idx++, end);

            try (ResultSet rs = ps.executeQuery()) {
                rs.next();
                return rs.getInt(1);
            }
        }
    }

    // KPI: total revenue
    public static double getTotalRevenue(Date start, Date end) throws SQLException {
        StringBuilder sql = new StringBuilder("SELECT COALESCE(SUM(totalCost), 0) FROM sales ");
        if (start != null && end != null) sql.append("WHERE saleDate BETWEEN ? AND ?");
        else if (start != null) sql.append("WHERE saleDate >= ?");
        else if (end != null) sql.append("WHERE saleDate <= ?");

        try (Connection con = ConnectionManager.getConnection();
             PreparedStatement ps = con.prepareStatement(sql.toString())) {

            int idx = 1;
            if (start != null && end != null) { ps.setDate(idx++, start); ps.setDate(idx++, end); }
            else if (start != null) ps.setDate(idx++, start);
            else if (end != null) ps.setDate(idx++, end);

            try (ResultSet rs = ps.executeQuery()) {
                rs.next();
                return rs.getDouble(1);
            }
        }
    }

    // KPI: total commission
    public static double getTotalCommission(Date start, Date end) throws SQLException {
        StringBuilder sql = new StringBuilder("SELECT COALESCE(SUM(commission), 0) FROM sales ");
        if (start != null && end != null) sql.append("WHERE saleDate BETWEEN ? AND ?");
        else if (start != null) sql.append("WHERE saleDate >= ?");
        else if (end != null) sql.append("WHERE saleDate <= ?");

        try (Connection con = ConnectionManager.getConnection();
             PreparedStatement ps = con.prepareStatement(sql.toString())) {

            int idx = 1;
            if (start != null && end != null) { ps.setDate(idx++, start); ps.setDate(idx++, end); }
            else if (start != null) ps.setDate(idx++, start);
            else if (end != null) ps.setDate(idx++, end);

            try (ResultSet rs = ps.executeQuery()) {
                rs.next();
                return rs.getDouble(1);
            }
        }
    }

    // KPI: cars in inventory (total stock)
    public static int getCarsInInventory() throws SQLException {
        String sql = "SELECT COALESCE(SUM(stock), 0) FROM cars";
        try (Connection con = ConnectionManager.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            rs.next();
            return rs.getInt(1);
        }
    }
    
    // Dashboard
    public static List<SalesReport> getRecentSales(int limit) throws SQLException {
        List<SalesReport> list = new ArrayList<>();

        String sql =
            "SELECT s.saleID, s.customerName, s.totalCost, s.saleDate, " +
            "       c.brand, c.model, u.username " +
            "FROM sales s " +
            "JOIN cars c ON s.carID = c.carID " +
            "JOIN loginpage u ON s.userId = u.userId " +
            "ORDER BY s.saleDate DESC, s.saleID DESC " +
            "LIMIT ?";

        try (Connection con = ConnectionManager.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, limit);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    SalesReport r = new SalesReport();
                    r.setSaleId(rs.getInt("saleID"));
                    r.setCustomerName(rs.getString("customerName"));
                    r.setTotalCost(rs.getDouble("totalCost"));
                    r.setSaleDate(rs.getDate("saleDate"));
                    r.setCarName(rs.getString("brand") + " " + rs.getString("model"));
                    r.setSalesperson(rs.getString("username"));
                    list.add(r);
                }
            }
        }

        return list;
    }
    
 // Dashboard: monthly sales (last 6 months)
    public static List<DashboardMonth> getMonthlySalesLast6() throws SQLException {
        List<DashboardMonth> list = new ArrayList<>();

        String sql =
            "SELECT DATE_FORMAT(saleDate, '%Y-%m') AS saleMonth, " +
            "       COUNT(*) AS carsSold, " +
            "       COALESCE(SUM(totalCost), 0) AS revenue " +
            "FROM sales " +
            "GROUP BY saleMonth " +
            "ORDER BY saleMonth DESC " +
            "LIMIT 6";

        try (Connection con = ConnectionManager.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                DashboardMonth m = new DashboardMonth();
                m.setMonth(rs.getString("saleMonth"));
                m.setCarsSold(rs.getInt("carsSold"));
                m.setRevenue(rs.getDouble("revenue"));
                list.add(m);
            }
        }

        // Reverse so it shows oldest -> newest
        java.util.Collections.reverse(list);
        return list;
    }

    // Dashboard: stock distribution by brand
    public static List<BrandStock> getStockByBrand() throws SQLException {
        List<BrandStock> list = new ArrayList<>();

        String sql =
            "SELECT brand, COALESCE(SUM(stock), 0) AS totalStock " +
            "FROM cars " +
            "GROUP BY brand " +
            "ORDER BY totalStock DESC, brand ASC";

        try (Connection con = ConnectionManager.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                BrandStock b = new BrandStock();
                b.setBrand(rs.getString("brand"));
                b.setStock(rs.getInt("totalStock"));
                list.add(b);
            }
        }
        return list;
    }


}
