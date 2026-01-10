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
		
			<c:forEach items="${cars}" var="car">
			    <div class="car-card">
			        <img src="${car.carImagePath}" alt="${car.model}">
			        <h4>${car.model}</h4>
			        <p>RM <c:out value="${car.price}" /></p>
			    </div>
			</c:forEach>

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
