<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

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

    <!-- Sidebar -->
    <div class="sidebar">
        <h2>CarSales</h2>
        <ul>
            <li onclick="window.location.href='Dashboard.jsp'">Dashboard</li>
            <li onclick="window.location.href='addCarController?action=list'">Cars</li>
            <li onclick="window.location.href='salesreport.jsp'">Sales Report</li>
            <li class="active">Sales Entry</li>
            <li onclick="window.location.href='usersection.jsp'">Users</li>
            <li onclick="window.location.href='LogoutController'">Logout</li>
        </ul>
    </div>

    <!-- Main Content -->
    <div class="main-content">

        <header>
            <h1>New Sales Entry</h1>
            <div class="profile">
                <img src="images/avatar2.png" alt="User">
                <span>Welcome, Admin</span>
            </div>
        </header>

        <div class="sales-container">
            <form action="SalesEntryServlet" method="post" class="sales-form">

                <h3>Customer Details</h3>
                <div class="form-row">
                    <div class="form-group half-width">
                        <label>Customer Name</label>
                        <input type="text" name="customerName" placeholder="Full Name" required>
                    </div>
                    <div class="form-group half-width">
                        <label>Phone Number</label>
                        <input type="tel" name="customerPhone" placeholder="01X-XXXXXXX" required>
                    </div>
                </div>

                <div class="form-group">
                    <label>Email Address</label>
                    <input type="email" name="customerEmail" placeholder="email@example.com">
                </div>

                <hr>

                <h3>Sale Details</h3>
                <div class="form-row">
                    <div class="form-group half-width">
                        <label>Car Model</label>
                        <select name="carModel" required>
                            <option value="" disabled selected>Select Car</option>
                            <!-- Dynamically populate car models from cars table -->
                            <c:forEach items="${cars}" var="car">
                                <option value="${car.model}">${car.brand} ${car.model}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="form-group half-width">
                        <label>Sale Price (RM)</label>
                        <input type="number" name="salePrice" placeholder="e.g. 85,000" required>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group half-width">
                        <label>Salesperson</label>
                        <select name="salesperson" required>
                            <option value="" disabled selected>Select Staff</option>
                            <option value="Faris Izzat">Faris Izzat</option>
                            <option value="Ahmad Zaki">Ahmad Zaki</option>
                            <option value="Siti Aminah">Siti Aminah</option>
                        </select>
                    </div>
                    <div class="form-group half-width">
                        <label>Date of Sale</label>
                        <input type="date" name="saleDate" required>
                    </div>
                </div>

                <div class="form-group">
                    <label>Payment Method</label>
                    <select name="paymentMethod">
                        <option value="Loan">Bank Loan</option>
                        <option value="Cash">Cash / Transfer</option>
                        <option value="Credit">Credit Card</option>
                    </select>
                </div>

                <div class="btn-container">
                    <button type="reset" class="btn-cancel">Reset</button>
                    <button type="submit" class="btn-submit">Confirm Sale</button>
                </div>

            </form>
        </div>

    </div> <!-- END main-content -->

</body>
</html>
