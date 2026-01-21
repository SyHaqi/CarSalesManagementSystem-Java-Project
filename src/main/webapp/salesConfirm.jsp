<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sale Confirmed</title>
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
	    <ul>
			  <li onclick="window.location.href='SalesReportController?action=dashboard'">Dashboard</li>
			
			  <c:if test="${role == 'Admin' || role == 'Salesperson' || role == 'Staff'}">
			    <li onclick="window.location.href='addCarController?action=list'">Cars</li>
			  </c:if>
			
			  <c:if test="${role == 'Admin'}">
			    <li onclick="window.location.href='addUserController?action=list'">Users</li>
			  </c:if>
			
			  <c:if test="${role == 'Admin' || role == 'Staff'}">
			    <li onclick="window.location.href='SalesReportController'">Sales Report</li>
			  </c:if>
			
			  <c:if test="${role == 'Admin' || role == 'Salesperson'}">
			    <li active="class" onclick="window.location.href='SalesController'">Sales Entry</li>
			  </c:if>
			
			  <li onclick="window.location.href='LogoutController'">Logout</li>
			</ul>
</div>

<div class="main-content">
    <header>
        <h1>Sale Confirmed</h1>
        <div class="header-right">
            <a class="add-car-btn" href="SalesController">+ New Sale</a>
        </div>
    </header>

    <div class="addcar-container">
        <h2>Receipt</h2>

        <p><b>Sale ID:</b> ${saleId}</p>
        <p><b>Customer:</b> ${customerName}</p>
        <p><b>Date:</b> ${saleDate}</p>

        <hr>

        <p><b>Car:</b> ${carModel}</p>
        <p><b>Car Price:</b> RM <fmt:formatNumber value="${carPrice}" type="number" groupingUsed="true"/></p>

        <hr>

        <p><b>Accessories:</b></p>
        <c:choose>
            <c:when test="${empty accessories}">
                <p>None</p>
            </c:when>
            <c:otherwise>
                <ul>
                    <c:forEach items="${accessories}" var="a">
                        <li>${a}</li>
                    </c:forEach>
                </ul>
            </c:otherwise>
        </c:choose>

        <p><b>Accessories Total:</b> RM <fmt:formatNumber value="${accessoriesTotal}" type="number" groupingUsed="true"/></p>

        <p><b>Commission:</b> RM <fmt:formatNumber value="${commission}" type="number" groupingUsed="true"/></p>

        <hr>

        <h3>
            Total Cost: RM <fmt:formatNumber value="${totalCost}" type="number" groupingUsed="true"/>
        </h3>

        <c:if test="${sessionScope.login.role == 'Admin'}">
		    <a href="SalesReportController" class="add-car-btn" style="display:inline-block; margin-top:15px;">
		        View Sales Report
		    </a>
		</c:if>


    </div>
</div>

</body>
</html>
