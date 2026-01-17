package app.bean;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AddCarDAO {

    private static Connection connection;

    // CREATE
    public static void addCar(addcarbean car) throws SQLException {

        String sql = "INSERT INTO cars (model, brand, price, year, stock, carImagePath) VALUES (?, ?, ?, ?, ?, ?)";

        connection = ConnectionManager.getConnection();
        PreparedStatement ps = connection.prepareStatement(sql);

        ps.setString(1, car.getModel());
        ps.setString(2, car.getBrand());
        ps.setDouble(3, car.getPrice());
        ps.setInt(4, car.getYear());
        ps.setInt(5, car.getStock());
        ps.setString(6, car.getCarImagePath());

        ps.executeUpdate();
        ps.close();
    }

    // READ ALL
    public static List<addcarbean> getAllCars() throws SQLException {

        List<addcarbean> list = new ArrayList<>();
        String sql = "SELECT * FROM cars";

        connection = ConnectionManager.getConnection();
        PreparedStatement ps = connection.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            addcarbean car = new addcarbean(
                rs.getString("model"),
                rs.getString("brand"),
                rs.getDouble("price"),
                rs.getInt("year"),
                rs.getInt("stock"),
                rs.getString("carImagePath")
            );
            car.setCarID(rs.getInt("carID"));
            list.add(car);
        }

        rs.close();
        ps.close();
        return list;
    }

    // READ BY ID
    public static addcarbean getCarById(int carID) throws SQLException {

        addcarbean car = null;
        String sql = "SELECT * FROM cars WHERE carID = ?";

        connection = ConnectionManager.getConnection();
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setInt(1, carID);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            car = new addcarbean(
                rs.getString("model"),
                rs.getString("brand"),
                rs.getDouble("price"),
                rs.getInt("year"),
                rs.getInt("stock"),
                rs.getString("carImagePath")
            );
            car.setCarID(carID);
        }

        rs.close();
        ps.close();
        return car;
    }

    // UPDATE
    public static void updateCar(addcarbean car) throws SQLException {

        String sql = "UPDATE cars SET model=?, brand=?, price=?, year=?, stock=?, carImagePath=? WHERE carID=?";

        connection = ConnectionManager.getConnection();
        PreparedStatement ps = connection.prepareStatement(sql);

        ps.setString(1, car.getModel());
        ps.setString(2, car.getBrand());
        ps.setDouble(3, car.getPrice());
        ps.setInt(4, car.getYear());
        ps.setInt(5, car.getStock());
        ps.setString(6, car.getCarImagePath());
        ps.setInt(7, car.getCarID());

        ps.executeUpdate();
        ps.close();
    }
    
    public static List<addcarbean> getCarsInStock() throws SQLException {
        List<addcarbean> list = new ArrayList<>();
        String sql = "SELECT * FROM cars WHERE stock > 0 ORDER BY brand, model";

        connection = ConnectionManager.getConnection();
        PreparedStatement ps = connection.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            addcarbean car = new addcarbean(
                rs.getString("model"),
                rs.getString("brand"),
                rs.getDouble("price"),
                rs.getInt("year"),
                rs.getInt("stock"),
                rs.getString("carImagePath")
            );
            car.setCarID(rs.getInt("carID"));
            list.add(car);
        }

        rs.close();
        ps.close();
        connection.close();
        return list;
    }


    // DELETE
    public static void deleteCar(int carID) throws SQLException {

        String sql = "DELETE FROM cars WHERE carID=?";

        connection = ConnectionManager.getConnection();
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setInt(1, carID);
        ps.executeUpdate();
        ps.close();
    }
}
