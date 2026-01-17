package app.bean;

import java.sql.Date;

public class Sales {
	private int saleID;
    private int userId;
    private int carID;
    private String customerName;
    private double totalCost;
    private double commission;
    private Date saleDate;
    
	public Sales() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Sales(int saleID, int userId, int carID, String customerName, double totalCost, double commission,
			Date saleDate) {
		super();
		this.saleID = saleID;
		this.userId = userId;
		this.carID = carID;
		this.customerName = customerName;
		this.totalCost = totalCost;
		this.commission = commission;
		this.saleDate = saleDate;
	}

	public int getSaleID() {
		return saleID;
	}

	public void setSaleID(int saleID) {
		this.saleID = saleID;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userID) {
		this.userId = userID;
	}

	public int getCarID() {
		return carID;
	}

	public void setCarID(int carID) {
		this.carID = carID;
	}

	public String getCustomerName() {
		return customerName;
	}

	public void setCustomerName(String customerName) {
		this.customerName = customerName;
	}

	public double getTotalCost() {
		return totalCost;
	}

	public void setTotalCost(double totalCost) {
		this.totalCost = totalCost;
	}

	public double getCommission() {
		return commission;
	}

	public void setCommission(double commission) {
		this.commission = commission;
	}

	public Date getSaleDate() {
		return saleDate;
	}

	public void setSaleDate(Date saleDate) {
		this.saleDate = saleDate;
	}
    
    
}
