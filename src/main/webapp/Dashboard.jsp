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
            <li class="active" onclick="window.location.href='Dashboard.jsp'">Dashboard</li>
        	<li onclick="window.location.href='carsection.jsp'">Cars</li>
            <li onclick="window.location.href='salesreport.jsp'">Sales Report</li>
            <li>Sales Entry</li>
            <li onclick="window.location.href='usersection.jsp'">Users</li>
            <li onclick="window.location.href='LogoutController'">Logout</li>
        </ul>
    </div>

    <!-- Main Content -->
    <div class="main-content">

        <header>
            <h1>Dashboard Overview</h1>
            <div class="profile">
                <img src="images/avatar2.png" alt="User">
                <span>Welcome, Admin</span>
            </div>
        </header>

        <!-- KPI Cards -->
        <div class="kpi-container">

            <div class="kpi-card">
                <h3>Total Cars Sold</h3>
                <p>128</p>
            </div>

            <div class="kpi-card">
                <h3>Total Revenue</h3>
                <p>RM 1,254,600</p>
            </div>

            <div class="kpi-card">
                <h3>Total Commission Earned</h3>
                <p>RM 87,200</p>
            </div>

            <div class="kpi-card">
                <h3>Cars In Inventory</h3>
                <p>54</p>
            </div>

        </div>

        <!-- Charts Section -->
        <div class="charts-section">

            <div class="chart-box">
                <h3>Monthly Sales Chart</h3>
                <div class="chart-placeholder">Chart Placeholder</div>
            </div>

            <div class="chart-box">
                <h3>Stock Distribution (Brand)</h3>
                <div class="chart-placeholder">Chart Placeholder</div>
            </div>

        </div>

        <!-- Table Section -->
        <div class="table-section">

            <h3>Recent Sales Transactions</h3>
            <table>
                <thead>
                    <tr>
                        <th>Customer</th>
                        <th>Car Model</th>
                        <th>Total Cost</th>
                        <th>Salesperson</th>
                        <th>Date</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>Ahmad Zaki</td>
                        <td>Honda City</td>
                        <td>RM 92,000</td>
                        <td>Faris</td>
                        <td>2025-03-12</td>
                    </tr>
                    <tr>
                        <td>Siti Aminah</td>
                        <td>Proton X50</td>
                        <td>RM 85,200</td>
                        <td>Izzul</td>
                        <td>2025-03-10</td>
                    </tr>
                    <tr>
                        <td>John Lim</td>
                        <td>Toyota Vios</td>
                        <td>RM 78,900</td>
                        <td>Baihaqi</td>
                        <td>2025-03-08</td>
                    </tr>
                </tbody>
            </table>

        </div>

    </div>

</body>
</html>
