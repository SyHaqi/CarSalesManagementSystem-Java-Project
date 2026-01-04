package app.bean;

import java.io.Serializable;

public class addcarbean implements Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	public String car_name;
	public int year;
	public double price;
	private String carImagePath;
	
	public addcarbean(String car_name, int year, double price, String carImagePath) {
		super();
		this.car_name = car_name;
		this.year = year;
		this.price = price;
		this.carImagePath = carImagePath;
	}

	public String getCar_name() {
		return car_name;
	}

	public void setCar_name(String car_name) {
		this.car_name = car_name;
	}

	public int getYear() {
		return year;
	}

	public void setYear(int year) {
		this.year = year;
	}

	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
	}

	public String getCarImagePath() {
		return carImagePath;
	}

	public void setCarImagePath(String carImagePath) {
		this.carImagePath = carImagePath;
	}
	
	
	
	
	
	

}
