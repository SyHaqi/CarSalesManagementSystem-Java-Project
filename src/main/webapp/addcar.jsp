<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Car Sales Management Dashboard</title>
    <link rel="stylesheet" href="dashboard.css">
</head>
<body>

    <!-- Sidebar -->
    <div class="sidebar">
        <h2>CarSales</h2>
        <ul>
            <li onclick="window.location.href='Dashboard.jsp'">Dashboard</li>
        	<li class="active" onclick="window.location.href='addCarController?action=list'">Cars</li>
            <li onclick="window.location.href='salesreport.jsp'">Sales Report</li>
            <li>Sales Entry</li>
            <li onclick="window.location.href='usersection.jsp'">Users</li>
            <li onclick="window.location.href='LogoutController'">Logout</li>
        </ul>
    </div>

   <!-- Main Content Only -->
<div class="main-content">
<div class="top-right-btn">
    <a href="addCarController?action=list" class="add-car-btn">← Back</a>
</div>

    <div class="addcar-container">
        <h2>Add New Car</h2>

        <form action="addCarController" method="post" enctype="multipart/form-data">

            <div class="form-group">
                <label>Car Name</label>
                <input type="text" name="model" placeholder="e.g. Honda City" required>
            </div>

            <div class="form-group">
                <label>Brand</label>
                <select name="brand" required>
                    <option value="" disabled selected>Select brand</option>
                    <option>Honda</option>
                    <option>Toyota</option>
                    <option>Proton</option>
                    <option>Perodua</option>
                    <option>BMW</option>
                    <option>Mercedes</option>
                </select>
            </div>

            <div class="form-group">
                <label>Price (RM)</label>
                <input type="number" name="price" placeholder="e.g. 85000" required>
            </div>

            <div class="form-group">
                <label>Year</label>
                <input type="number" name="year" min="1990" max="2025" placeholder="e.g. 2023" required>
            </div>

            <div class="form-group">
                <label>Stock</label>
                <input type="number" name="stock" placeholder="e.g. 10" required>
            </div>

            <div class="form-group">
                <label>Car Image</label>
                <input type="file" name="carImagePath" accept="image/*" required>
            </div>

            <button type="submit" class="add-car-btn">Save Car</button>
        </form>

    </div>

</div>


</body>
</html>
