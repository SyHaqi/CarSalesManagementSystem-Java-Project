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
    <link rel="stylesheet" href="users.css">
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
        <c:set var="role" value="${sessionScope.login.role}" />

			<ul>
			  <li onclick="window.location.href='SalesReportController?action=dashboard'">Dashboard</li>
			
			  <c:if test="${role == 'Admin' || role == 'Salesperson' || role == 'Staff'}">
			    <li onclick="window.location.href='addCarController?action=list'">Cars</li>
			  </c:if>
			
			  <c:if test="${role == 'Admin'}">
			    <li class="active" onclick="window.location.href='addUserController?action=list'">Users</li>
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
            <h1>Users</h1>

            <div class="profile">
			    <img src="${empty sessionScope.login.avatar ? 'images/users/avatar-default.png' : sessionScope.login.avatar}" alt="User">
			    <span>${sessionScope.login.username}</span>
			</div>

        </header>

        <!-- Search + Add User Button -->
        <div class="user-search" style="display: flex; justify-content: space-between; align-items: center; margin-top: 20px;">
            <input id="userSearch" type="text" placeholder="Search user by name, role, or email..." style="flex: 1; margin-right: 15px;">
            <button class="add-car-btn" onclick="window.location.href='adduser.jsp'">+ Add User</button>
        </div>

        <!-- User Table -->
        <div class="user-table">
            <table id="userTable">
                <thead>
                    <tr>
                        <th>Profile</th>
                        <th>Name</th>
                        <th>Email</th>
                        <th>Role</th>
                        <th>Actions</th>
                    </tr>
                </thead>

                <tbody>
                    <c:forEach items="${users}" var="u">
                        <tr>
                            <td>
                                <img src="${empty u.avatar ? 'images/users/avatar-default.png' : u.avatar}">
                            </td>
                            <td>${u.fullname}</td>
                            <td>${u.email}</td>
                            <td>${u.role}</td>
                            <td>
                                <a href="addUserController?action=edit&userId=${u.userId}">Edit</a> |
                                <a href="addUserController?action=delete&userId=${u.userId}" onclick="return confirm('Delete this user?');">Delete</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>

            </table>
        </div>

    </div>

    <!-- Search Script -->
    <script>
        document.getElementById("userSearch").addEventListener("keyup", function () {
            let filter = this.value.toLowerCase();
            let rows = document.querySelectorAll("#userTable tbody tr");

            rows.forEach(row => {
                let text = row.textContent.toLowerCase();
                row.style.display = text.includes(filter) ? "" : "none";
            });
        });
    </script>

</body>
</html>
