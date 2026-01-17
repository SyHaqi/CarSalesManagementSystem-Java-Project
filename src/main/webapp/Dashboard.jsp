<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

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


    <!-- Sidebar -->
    <div class="sidebar">
        <h2>CarSales</h2>
        <ul>
            <li class="active" onclick="window.location.href='SalesReportController?action=dashboard'">Dashboard</li>
        	<li onclick="window.location.href='addCarController?action=list'">Cars</li>
            <li onclick="window.location.href='salesreport.jsp'">Sales Report</li>
            <li onclick="window.location.href='SalesController'">Sales Entry</li>
            <li onclick="window.location.href='addUserController?action=list'">Users</li>
            <li onclick="window.location.href='LogoutController'">Logout</li>
        </ul>
    </div>

    <!-- Main Content -->
    <div class="main-content">

        <header>
            <h1>Dashboard Overview</h1>
            <div class="profile">
			    <img src="${empty sessionScope.login.avatar ? 'images/users/avatar-default.png' : sessionScope.login.avatar}" alt="User">
			    <span>${sessionScope.login.username}</span>
			</div>

        </header>

        <!-- KPI Cards -->
        <div class="kpi-container">

            <div class="kpi-card">
                <h3>Total Cars Sold</h3>
                <p>${totalCarsSold}</p>
            </div>

            <div class="kpi-card">
                <h3>Total Revenue</h3>
                <p>RM <fmt:formatNumber value="${totalRevenue}" type="number" groupingUsed="true"/></p>
            </div>

            <div class="kpi-card">
                <h3>Total Commission Earned</h3>
                <p>RM <fmt:formatNumber value="${totalCommission}" type="number" groupingUsed="true"/></p>
            </div>

            <div class="kpi-card">
                <h3>Cars In Inventory</h3>
                <p>${carsInInventory}</p>
            </div>

        </div>

        <!-- Charts Section -->
        <div class="charts-section">

            <div class="chart-box">
			    <h3>Monthly Sales (Last 6 Months)</h3>
			
			    <table style="width:100%; border-collapse:collapse;">
			        <thead>
			            <tr>
			                <th style="text-align:center; padding:10px;">Month</th>
			                <th style="text-align:center; padding:10px;">Cars Sold</th>
			                <th style="text-align:center; padding:10px;">Revenue</th>
			            </tr>
			        </thead>
			        <tbody>
			            <c:forEach items="${monthlySales}" var="m">
			                <tr>
			                    <td style="padding:10px; text-align:center;">
								    <fmt:parseDate value="${m.month}-01" pattern="yyyy-MM-dd" var="monthDate" />
								    <fmt:formatDate value="${monthDate}" pattern="MMMM yyyy" />
								</td>

			                    <td style="padding:10px; text-align:center;">${m.carsSold}</td>
			                    <td style="padding:10px; text-align:center;">
			                        RM <fmt:formatNumber value="${m.revenue}" type="number" groupingUsed="true"/>
			                    </td>
			                </tr>
			            </c:forEach>
			
			            <c:if test="${empty monthlySales}">
			                <tr><td colspan="3" style="padding:10px; text-align:center;">No data</td></tr>
			            </c:if>
			        </tbody>
			    </table>
			</div>


            <div class="chart-box">
			    <h3>Stock Distribution (Brand)</h3>
			
			    <table style="width:100%; border-collapse:collapse;">
			        <thead>
			            <tr>
			                <th style="text-align:center; padding:10px;">Brand</th>
			                <th style="text-align:center; padding:10px;">Total Stock</th>
			            </tr>
			        </thead>
			        <tbody>
			            <c:forEach items="${stockByBrand}" var="b">
			                <tr>
			                    <td style="padding:10px;">${b.brand}</td>
			                    <td style="padding:10px; text-align:center;">${b.stock}</td>
			                </tr>
			            </c:forEach>
			
			            <c:if test="${empty stockByBrand}">
			                <tr><td colspan="2" style="padding:10px; text-align:center;">No data</td></tr>
			            </c:if>
			        </tbody>
			    </table>
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
				    <c:choose>
				        <c:when test="${empty recentSales}">
				            <tr>
				                <td colspan="5">No sales found.</td>
				            </tr>
				        </c:when>
				        <c:otherwise>
				            <c:forEach items="${recentSales}" var="s">
				                <tr>
				                    <td>${s.customerName}</td>
				                    <td>${s.carName}</td>
				                    <td>RM <fmt:formatNumber value="${s.totalCost}" type="number" groupingUsed="true"/></td>
				                    <td>${s.salesperson}</td>
				                    <td>${s.saleDate}</td>
				                </tr>
				            </c:forEach>
				        </c:otherwise>
				    </c:choose>
				</tbody>

            </table>

        </div>

    </div>

</body>
</html>
