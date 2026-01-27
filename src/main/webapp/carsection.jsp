<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Car Sales Management Dashboard</title>
    <link rel="stylesheet" href="dashboard.css">
</head>
<body>
<%
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);

if (session.getAttribute("login") == null) {
    response.sendRedirect("LoginPage.jsp");
    return;
}
%>

<c:set var="role" value="${sessionScope.login.role}" />

<!-- Sidebar -->
<div class="sidebar">
    <h2>CarSales</h2>

    <ul>
        <li onclick="window.location.href='SalesReportController?action=dashboard'">Dashboard</li>

        <c:if test="${role == 'Admin' || role == 'Salesperson' || role == 'Staff' || role == 'Guest'}">
            <li class="active" onclick="window.location.href='addCarController?action=list'">Cars</li>
        </c:if>

        <c:if test="${role == 'Admin'}">
            <li onclick="window.location.href='addUserController?action=list'">Users</li>
        </c:if>

        <c:if test="${role == 'Admin' || role == 'Staff'}">
            <li onclick="window.location.href='SalesReportController'">Sales Report</li>
        </c:if>

        <c:if test="${role == 'Admin' || role == 'Salesperson'}">
            <li onclick="window.location.href='SalesController'">Sales Entry</li>
        </c:if>

        <li onclick="window.location.href='LogoutController'">Logout</li>
    </ul>
</div>

<!-- Main Content -->
<div class="main-content">

    <header>
        <h1>Cars</h1>

        <div class="profile">
            <img src="${empty sessionScope.login.avatar ? 'images/users/avatar-default.png' : sessionScope.login.avatar}" alt="User">
            <span>${sessionScope.login.username}</span>
        </div>
    </header>

    <!-- Search & Add Car Button -->
    <div class="car-search-section" style="display:flex; justify-content:center; align-items:center; gap:15px;">
        <input type="text" id="carSearch" placeholder="Search car model or brand..." style="width:50%;">

        <c:if test="${role == 'Admin' || role == 'Salesperson'}">
            <button class="add-car-btn" onclick="window.location.href='addcar.jsp'">+ Add Car</button>
        </c:if>
    </div>

    <!-- Car Grid -->
    <div class="car-grid" id="carGrid">
	    <c:forEach items="${cars}" var="car">
	
	        <c:choose>
	            <c:when test="${role == 'Staff' || role == 'Guest'}">
	                <div class="car-card">
	                    <img src="${car.carImagePath}" alt="${car.model}">
	                    <h4>${car.model}</h4>
	                    <p>${car.brand}</p>
	                    <p>Year: ${car.year}</p>
	                    <p>Stock: ${car.stock}</p>
	                    <p>RM <fmt:formatNumber value="${car.price}" type="number" groupingUsed="true" /></p>
	                </div>
	            </c:when>
	
	            <c:otherwise>
	                <a href="addCarController?action=edit&carID=${car.carID}" class="car-card" style="text-decoration:none;">
	                    <img src="${car.carImagePath}" alt="${car.model}">
	                    <h4>${car.model}</h4>
	                    <p>${car.brand}</p>
	                    <p>Year: ${car.year}</p>
	                    <p>RM <fmt:formatNumber value="${car.price}" type="number" groupingUsed="true" /></p>
	                </a>
	            </c:otherwise>
	        </c:choose>
	
	    </c:forEach>
	</div>


    <!-- Search Filter Script -->
    <script>
        document.getElementById("carSearch").addEventListener("keyup", function () {
            let filter = this.value.toLowerCase();
            let cards = document.querySelectorAll(".car-card");

            cards.forEach(card => {
                let name = card.querySelector("h4").textContent.toLowerCase();
                card.style.display = name.includes(filter) ? "" : "none";
            });
        });
    </script>

</div>

</body>
</html>
