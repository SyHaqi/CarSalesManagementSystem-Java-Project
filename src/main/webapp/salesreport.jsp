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
        	<li onclick="window.location.href='carsection.jsp'">Cars</li>
            <li class="active" onclick="window.location.href='salesreport.jsp'">Sales Report</li>
            <li>Sales Entry</li>
            <li onclick="window.location.href='usersection.jsp'">Users</li>
            <li onclick="window.location.href='LogoutController'">Logout</li>
        </ul>
    </div>

   <!-- Main Content Only -->
<div class="main-content">
<div class="top-right-btn">
    <a href="carsection.html" class="add-car-btn">← Back</a>
</div>

    <div class="addcar-container">
        <h2>Sales Report</h2>

        <form action="#" method="post" enctype="multipart/form-data">

            
            <fieldset>
            <legend>Form:</legend>
            <div class="form-group">
                <div>
                <label for="start">Start</label>
                <input type="date" id="start" name="start">
                </div>
                <div>
                <label for="end">End</label>
                <input type="date" id="end" name="end">
                </div>
                
            </div>
            <button type="submit" class="add-car-btn">Filter</button>
           </fieldset>

           <!-- Table Section -->
        <div class="table-section">

            <!-- KPI Cards -->
        <div class="kpi-container">

            <div class="kpi-card">
                <h3>Total Cars Sold</h3>
                <p>3</p>
            </div>

            <div class="kpi-card">
                <h3>Total Revenue</h3>
                <p>RM 256,100</p>
            </div>

            <div class="kpi-card">
                <h3>Total Commission Earned</h3>
                <p>RM 17,927</p>
            </div>

            <div class="kpi-card">
                <h3>Cars In Inventory</h3>
                <p>3</p>
            </div>

        </div>

            <h3>Report Summary</h3>
            <table>
                <thead>
                    <tr>
                        <th>Customer</th>
                        <th>Car Model</th>
                        <th>Price</th>
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
                        <td>2025-04-08</td>
                    </tr>
                </tbody>
            </table>

            

            <button type="submit" class="add-car-btn">Print</button>

        </div>
            

        </form>

    </div>

</div>


</body>
</html>
