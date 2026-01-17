<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Car - Car Sales Management</title>
    <link rel="stylesheet" href="dashboard.css">
</head>
<body>

    <!-- Sidebar -->
    <div class="sidebar">
        <h2>CarSales</h2>
        <ul>
            <li onclick="window.location.href='SalesReportController?action=dashboard'">Dashboard</li>
            <li class="active" onclick="window.location.href='addCarController?action=list'">Cars</li>
            <li class="active" onclick="window.location.href='SalesReportController'">Sales Report</li>
            <li onclick="window.location.href='SalesController'">Sales Entry</li>
            <li onclick="window.location.href='addUserController?action=list'">Users</li>
            <li onclick="window.location.href='LogoutController'">Logout</li>
        </ul>
    </div>

    <!-- Main Content -->
    <div class="main-content">

        <header>
            <h1>Edit Car Details</h1>
            <button class="add-car-btn" onclick="window.location.href='addCarController?action=list'">
            &larr; Back
        	</button>
        </header>

        <form action="addCarController" method="post" enctype="multipart/form-data">
            <input type="hidden" name="action" value="update">
            <input type="hidden" name="carID" value="${car.carID}">

            <div style="display: flex; gap: 30px; margin-top: 20px;">

                <!-- Left: Input Fields -->
                <div style="flex: 2;">
                    <div class="form-group">
                        <label>Model</label>
                        <input type="text" name="model" value="${car.model}" required>
                    </div>

                    <div class="form-group">
                        <label>Brand</label>
                        <input type="text" name="brand" value="${car.brand}" required>
                    </div>

                    <div class="form-group">
                        <label>Year</label>
                        <input type="number" name="year" value="${car.year}" required>
                    </div>

                    <div class="form-group">
                        <label>Price (RM)</label>
                        <input type="number" name="price" value="${car.price}" required>
                    </div>

                    <div class="form-group">
                        <label>Stock</label>
                        <input type="number" name="stock" value="${car.stock}" required>
                    </div>

                    <div class="form-group">
                        <label>Car Image</label>
                        <input type="file" name="carImage">
                    </div>

                    <div class="header-right" style="margin-top: 20px; gap: 15px;">
                        <button type="submit" class="add-car-btn">Update Car</button>
                        <a href="addCarController?action=delete&carID=${car.carID}" 
                           class="add-car-btn" 
                           style="background-color: red;"
                           onclick="return confirm('Are you sure you want to delete this car?');">
                           Delete Car
                        </a>
                    </div>
                </div>

                <!-- Right: Current Car Image -->
                <div style="flex: 1; display: flex; justify-content: center; align-items: flex-start;">
                    <img src="${car.carImagePath}" alt="${car.model}" style="width: 100%; max-width: 300px; border-radius: 10px; box-shadow: 0 2px 5px rgba(0,0,0,0.2);">
                </div>

            </div>
        </form>

    </div>
</body>
</html>
