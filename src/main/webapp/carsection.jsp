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
        	<li class="active" onclick="window.location.href='carsection.jsp'">Cars</li>
            <li onclick="window.location.href='salesreport.jsp'">Sales Report</li>
            <li>Sales Entry</li>
            <li onclick="window.location.href='usersection.jsp'">Users</li>
            <li onclick="window.location.href='LogoutController'">Logout</li>
        </ul>
    </div>

    <!-- Main Content -->
    <div class="main-content">

        <header>
            <h1>Cars</h1>

            <div class="header-right">
            <button class="add-car-btn" onclick="window.location.href='addcar.jsp'">
    + Add Car
</button>

        </div>
        </header>


        <!-- Car Search Section -->
        <div class="car-search-section">
            <input type="text" id="carSearch" placeholder="Search car model or brand...">
        </div>

        <!-- Car Grid Section -->
        <div class="car-grid" id="carGrid">

            <div class="car-card">
                <img src="images/cars/honda_city.jpg" alt="Honda City">
                <h4>Honda City</h4>
                <p>RM 92,000</p>
            </div>

            <div class="car-card">
                <img src="images/cars/proton_x50.jpg" alt="Proton X50">
                <h4>Proton X50</h4>
                <p>RM 85,200</p>
            </div>

            <div class="car-card">
                <img src="images/cars/toyota_vios.jpg" alt="Toyota Vios">
                <h4>Toyota Vios</h4>
                <p>RM 78,900</p>
            </div>

        </div>

        <!-- Search Filter Script -->
        <script>
            document.getElementById("carSearch").addEventListener("keyup", function () {
                let filter = this.value.toLowerCase();
                let cars = document.querySelectorAll(".car-card");

                cars.forEach(card => {
                    let name = card.querySelector("h4").textContent.toLowerCase();
                    card.style.display = name.includes(filter) ? "block" : "none";
                });
            });
        </script>

    </div> <!-- END main-content -->

</body>
</html>
