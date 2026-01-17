package app.bean;

import java.sql.Date;

public class SalesReport {
	private int saleId;
    private String customerName;
    private String carName;      // e.g. "Honda City"
    private double totalCost;
    private String salesperson;  // username
    private Date saleDate;
    
	public SalesReport() {
		super();
		// TODO Auto-generated constructor stub
	}

	public SalesReport(int saleId, String customerName, String carName, double totalCost, String salesperson,
			Date saleDate) {
		super();
		this.saleId = saleId;
		this.customerName = customerName;
		this.carName = carName;
		this.totalCost = totalCost;
		this.salesperson = salesperson;
		this.saleDate = saleDate;
	}

	public int getSaleId() {
		return saleId;
	}

	public void setSaleId(int saleId) {
		this.saleId = saleId;
	}

	public String getCustomerName() {
		return customerName;
	}

	public void setCustomerName(String customerName) {
		this.customerName = customerName;
	}

	public String getCarName() {
		return carName;
	}

	public void setCarName(String carName) {
		this.carName = carName;
	}

	public double getTotalCost() {
		return totalCost;
	}

	public void setTotalCost(double totalCost) {
		this.totalCost = totalCost;
	}

	public String getSalesperson() {
		return salesperson;
	}

	public void setSalesperson(String salesperson) {
		this.salesperson = salesperson;
	}

	public Date getSaleDate() {
		return saleDate;
	}

	public void setSaleDate(Date saleDate) {
		this.saleDate = saleDate;
	}
    
    

}
