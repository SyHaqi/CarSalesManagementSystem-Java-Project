package app.bean;

import java.io.Serializable;

public class addcarbean implements Serializable {

    private static final long serialVersionUID = 1L;

    private int carID;
    private String model;
    private String brand;
    private double price;
    private int year;
    private int stock;
    private String carImagePath;

    public addcarbean() {}

    public addcarbean(String model, String brand, double price, int year, int stock, String carImagePath) {
        this.model = model;
        this.brand = brand;
        this.price = price;
        this.year = year;
        this.stock = stock;
        this.carImagePath = carImagePath;
    }

	public int getCarID() {
		return carID;
	}

	public void setCarID(int carID) {
		this.carID = carID;
	}

	public String getModel() {
		return model;
	}

	public void setModel(String model) {
		this.model = model;
	}

	public String getBrand() {
		return brand;
	}

	public void setBrand(String brand) {
		this.brand = brand;
	}

	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
	}

	public int getYear() {
		return year;
	}

	public void setYear(int year) {
		this.year = year;
	}

	public int getStock() {
		return stock;
	}

	public void setStock(int stock) {
		this.stock = stock;
	}

	public String getCarImagePath() {
		return carImagePath;
	}

	public void setCarImagePath(String carImagePath) {
		this.carImagePath = carImagePath;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

    
}
