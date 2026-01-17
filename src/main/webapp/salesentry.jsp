<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sales Entry - Car Sales Management</title>
    <link rel="stylesheet" href="dashboard.css">
    <link rel="stylesheet" href="salesentry.css">
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

<div class="sidebar">
    <h2>CarSales</h2>
    <ul>
        <li onclick="window.location.href='SalesReportController?action=dashboard'">Dashboard</li>
        <li onclick="window.location.href='addCarController?action=list'">Cars</li>
        <li onclick="window.location.href='SalesReportController'">Sales Report</li>
        <li class="active" onclick="window.location.href='SalesController'">Sales Entry</li>
        <li onclick="window.location.href='addUserController?action=list'">Users</li>
        <li onclick="window.location.href='LogoutController'">Logout</li>
    </ul>
</div>

<div class="main-content">
    <header>
        <h1>New Sales Entry</h1>
        <div class="profile">
            <img src="${empty sessionScope.login.avatar ? 'images/users/avatar-default.png' : sessionScope.login.avatar}" alt="User">
            <span>${sessionScope.login.username}</span>
        </div>
    </header>

    <div class="sales-container">

        <!-- GET form just to refresh price when car changes -->
        <form action="SalesController" method="get" class="sales-form">
            <h3>Sale Details</h3>

            <div class="form-row">
                <div class="form-group half-width">
                    <label>Car</label>
                    <select name="carID" onchange="this.form.submit()" required>
                        <option value="" disabled ${empty param.carID ? 'selected' : ''}>Select Car</option>
                        <c:forEach items="${cars}" var="car">
                            <option value="${car.carID}" ${param.carID == car.carID ? 'selected' : ''}>
                                ${car.brand} ${car.model} (Stock: ${car.stock})
                            </option>
                        </c:forEach>
                    </select>
                </div>

                <div class="form-group half-width">
                    <label>Car Price (RM)</label>
                    <input type="text" value="${empty selectedCarPrice ? '' : selectedCarPrice}" readonly>
                </div>
            </div>
        </form>

        <!-- POST form to confirm sale -->
        <form action="SalesController" method="post" class="sales-form">

            <!-- keep selected carID -->
            <input type="hidden" name="carID" value="${param.carID}">

            <h3>Customer Details</h3>
            <div class="form-row">
                <div class="form-group half-width">
                    <label>Customer Name</label>
                    <input type="text" name="customerName" placeholder="Full Name" required>
                </div>
                <div class="form-group half-width">
                    <label>Date of Sale</label>
                    <input type="date" name="saleDate" required>
                </div>
            </div>

            <div class="form-group">
                <label>Commission (RM) (optional)</label>
                <input type="number" step="0.01" name="commission" placeholder="Leave empty if none">
            </div>

            <hr>

            <h3>Accessories (optional)</h3>
            <div class="form-group">
                <label><input type="checkbox" name="accessories" value="Spoiler"> Spoiler (RM 200)</label><br>
                <label><input type="checkbox" name="accessories" value="Bonnet Protector"> Bonnet Protector (RM 150)</label><br>
                <label><input type="checkbox" name="accessories" value="Tinted Windows"> Tinted Windows (RM 300)</label>
            </div>

            <div class="btn-container">
                <button type="reset" class="btn-cancel">Reset</button>
                <button type="submit" class="btn-submit" ${empty param.carID ? "disabled" : ""}>Confirm Sale</button>
            </div>
        </form>

    </div>
</div>

</body>
</html>
