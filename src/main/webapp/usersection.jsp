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

    <!-- Sidebar -->
    <div class="sidebar">
        <h2>CarSales</h2>
        <ul>
            <li onclick="window.location.href='Dashboard.jsp'">Dashboard</li>
        	<li onclick="window.location.href='carsection.jsp'">Cars</li>
            <li onclick="window.location.href='salesreport.jsp'">Sales Report</li>
            <li>Sales Entry</li>
            <li class="active" onclick="window.location.href='usersection.jsp'">Users</li>
            <li onclick="window.location.href='LogoutController'">Logout</li>
        </ul>
    </div>

    <!-- Main Content (REPLACED with Users Section) -->
    <div class="main-content">

        <header>
            <h1>Users</h1>
            <div class="profile">
                <img src="images/avatar2.png" alt="User">
                <span>Welcome, Admin</span>
            </div>
        </header>

        <!-- Search -->
        <div class="user-search">
            <input id="userSearch" type="text" placeholder="Search user by name, role, or email...">
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
                        <th>Status</th>
                    </tr>
                </thead>

                <tbody>

                    <tr>
                        <td><img src="images/users/user1.jpg"></td>
                        <td>Ahmad Zaki</td>
                        <td>ahmadzaki@example.com</td>
                        <td>Admin</td>
                        <td><span class="status-active">Active</span></td>
                    </tr>

                    <tr>
                        <td><img src="images/users/user2.jpg"></td>
                        <td>Faris Izzat</td>
                        <td>faris@example.com</td>
                        <td>Salesperson</td>
                        <td><span class="status-active">Active</span></td>
                    </tr>

                    <tr>
                        <td><img src="images/users/user3.jpg"></td>
                        <td>Siti Aminah</td>
                        <td>siti@example.com</td>
                        <td>Staff</td>
                        <td><span class="status-disabled">Disabled</span></td>
                    </tr>

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
