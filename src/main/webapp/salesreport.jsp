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

<div class="sidebar">
    <h2>CarSales</h2>
    <c:set var="role" value="${sessionScope.login.role}" />

		<ul>
		  <li onclick="window.location.href='SalesReportController?action=dashboard'">Dashboard</li>
		
		  <c:if test="${role == 'Admin' || role == 'Salesperson' || role == 'Staff'}">
		    <li onclick="window.location.href='addCarController?action=list'">Cars</li>
		  </c:if>
		
		  <c:if test="${role == 'Admin'}">
		    <li onclick="window.location.href='addUserController?action=list'">Users</li>
		  </c:if>
		
		  <c:if test="${role == 'Admin' || role == 'Staff'}">
		    <li class="active" onclick="window.location.href='SalesReportController'">Sales Report</li>
		  </c:if>
		
		  <c:if test="${role == 'Admin' || role == 'Salesperson'}">
		    <li onclick="window.location.href='SalesController'">Sales Entry</li>
		  </c:if>
		
		  <li onclick="window.location.href='LogoutController'">Logout</li>
		</ul>

</div>

<div class="main-content">

    <header>
	    <h1>Sales Report</h1>
	
	    <div class="profile">
	        <img src="${empty sessionScope.login.avatar ? 'images/users/avatar-default.png' : sessionScope.login.avatar}" alt="User">
	        <span>${sessionScope.login.username}</span>
	    </div>
	</header>


    <div class="report-container">


        <!-- Filter -->
        <form action="SalesReportController" method="get">

            <fieldset>
                <legend>Filter</legend>

                <div class="form-group" style="display:flex; gap:20px;">
                    <div>
                        <label for="start">Start</label>
                        <input type="date" id="start" name="start" value="${param.start}">
                    </div>
                    <div>
                        <label for="end">End</label>
                        <input type="date" id="end" name="end" value="${param.end}">
                    </div>
                </div>

                <button type="submit" class="add-car-btn">Filter</button>
                <a href="SalesReportController" class="add-car-btn" style="margin-left:10px;">Reset</a>
            </fieldset>

            <!-- KPI Cards -->
            <div class="kpi-container" style="margin-top:20px;">
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

            <h3 style="margin-top:25px;">Report Summary</h3>

            <div class="table-section">
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
                            <c:when test="${empty report}">
                                <tr>
                                    <td colspan="5">No sales found for the selected date range.</td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach items="${report}" var="r">
                                    <tr>
                                        <td>
										  <a href="SalesConfirmController?saleId=${r.saleId}" style="text-decoration:none; color:inherit;">
										    ${r.customerName}
										  </a>
										</td>
                                        <td>${r.carName}</td>
                                        <td>RM <fmt:formatNumber value="${r.totalCost}" type="number" groupingUsed="true"/></td>
                                        <td>${r.salesperson}</td>
                                        <td>${r.saleDate}</td>
                                    </tr>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>

            <button type="button" class="add-car-btn" style="margin-top:15px;" onclick="window.print()">Print</button>

        </form>

    </div>
</div>

</body>
</html>
