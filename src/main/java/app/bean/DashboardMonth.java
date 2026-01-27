package app.bean;

public class DashboardMonth {
    private String month;     
    private int carsSold;
    private double revenue;

    public String getMonth() { 
    	return month;
    }
    public void setMonth(String month) {
    	this.month = month;
    }
    public int getCarsSold() {
    	return carsSold; 
    }
    public void setCarsSold(int carsSold) {
    	this.carsSold = carsSold; 
    }
    public double getRevenue() {
    	return revenue; 
    }
    public void setRevenue(double revenue) {
    	this.revenue = revenue; 
    }
}
