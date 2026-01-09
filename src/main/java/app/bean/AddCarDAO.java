package app.bean;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class AddCarDAO {
	private static Connection connection = null;

	// CREATE - Insert new booking
	public static void addCar(addcarbean addcar) throws 
	SQLException {
		try {
			String query = "INSERT INTO booking (userId, "
					+ "bookingdate, bookingsession, guide, "
					+ "generalQuantity, studentQuantity, "
					+ "seniorQuantity, audioQuantity, "
					+ "cafeQuantity) "
					+ "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
			connection = ConnectionManager.getConnection();
			PreparedStatement ps = connection.prepareStatement(
					query);

			ps.setInt(1, booking.getUserId());
			ps.setDate(2, booking.getDate());
			ps.setString(3, booking.getSession());
			ps.setString(4, booking.getGuide());
			ps.setInt(5, booking.getGeneralQuantity());
			ps.setInt(6, booking.getStudentQuantity());
			ps.setInt(7, booking.getSeniorQuantity());
			ps.setInt(8, booking.getAudioQuantity());
			ps.setInt(9, booking.getCafeQuantity());
			System.out.println(ps);
			ps.executeUpdate();
			ps.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	//SELECT - get all bookings
	public static List<Booking> getAllBookings() throws SQLException {
		List<Booking> bookings = new ArrayList<>();

		try{
			String query = "SELECT * FROM booking";
			connection = ConnectionManager.getConnection();
			PreparedStatement ps = connection.prepareStatement(query);
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				Booking booking = new Booking();
				booking.setBookingId(rs.getInt("bookingId"));
				booking.setUserId(rs.getInt("userId"));
				booking.setDate(rs.getDate("bookingdate"));
				booking.setSession(rs.getString("bookingsession"));
				booking.setGuide(rs.getString("guide"));
				booking.setGeneralQuantity(rs.getInt("generalQuantity"));
				booking.setStudentQuantity(rs.getInt("studentQuantity"));
				booking.setSeniorQuantity(rs.getInt("seniorQuantity"));
				booking.setAudioQuantity(rs.getInt("audioQuantity"));
				booking.setCafeQuantity(rs.getInt("cafeQuantity"));
				bookings.add(booking);
			}
			ps.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return bookings;
	}

	// READ - Get a booking by ID
	public static Booking getBookingById(int bookingId) throws SQLException {
		Booking booking = null;

		try {
			String query = "SELECT * FROM booking WHERE bookingId = ?";
			connection = ConnectionManager.getConnection();
			PreparedStatement ps = connection.prepareStatement(query);
			ps.setInt(1, bookingId);
			ResultSet rs = ps.executeQuery();

			if (rs.next()) {
				booking = new Booking();
				booking.setBookingId(rs.getInt("bookingId"));//blue is column name in db
				booking.setUserId(rs.getInt("userId"));
				booking.setDate(rs.getDate("bookingdate"));
				booking.setSession(rs.getString("bookingsession"));
				booking.setGuide(rs.getString("guide"));
				booking.setGeneralQuantity(rs.getInt("generalQuantity"));
				booking.setStudentQuantity(rs.getInt("studentQuantity"));
				booking.setSeniorQuantity(rs.getInt("seniorQuantity"));
				booking.setAudioQuantity(rs.getInt("audioQuantity"));
				booking.setCafeQuantity(rs.getInt("cafeQuantity"));
			}
			rs.close();
			ps.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return booking;
	}

	// UPDATE - Modify an existing booking
	public static void updateBooking(Booking booking) throws SQLException {
		try {
			String query = "UPDATE booking SET bookingdate=?, bookingsession=?, guide=?, generalQuantity=?, studentQuantity=?, seniorQuantity=?, audioQuantity=?, cafeQuantity=? WHERE bookingId=?";
			connection = ConnectionManager.getConnection();
			PreparedStatement ps = connection.prepareStatement(query);

			ps.setDate(1, booking.getDate());
			ps.setString(2, booking.getSession());
			ps.setString(3, booking.getGuide());
			ps.setInt(4, booking.getGeneralQuantity());
			ps.setInt(5, booking.getStudentQuantity());
			ps.setInt(6, booking.getSeniorQuantity());
			ps.setInt(7, booking.getAudioQuantity());
			ps.setInt(8, booking.getCafeQuantity());
			ps.setInt(9, booking.getBookingId());

			ps.executeUpdate();
			ps.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	// DELETE - Remove a booking by ID
	public static void deleteBooking(int bookingId) throws SQLException {
		try {
			String query = "DELETE FROM booking WHERE bookingId = ?";
			connection = ConnectionManager.getConnection();
			PreparedStatement ps = connection.prepareStatement(query);
			ps.setInt(1, bookingId);
			ps.executeUpdate();
			ps.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}
