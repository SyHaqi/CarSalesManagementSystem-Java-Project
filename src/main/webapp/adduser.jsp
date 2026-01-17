<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><c:choose><c:when test="${not empty user}">Edit User</c:when><c:otherwise>Add User</c:otherwise></c:choose> - Car Sales Management</title>
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
            <li onclick="window.location.href='SalesReportController?action=dashboard'">Dashboard</li>
            <li onclick="window.location.href='addCarController?action=list'">Cars</li>
            <li class="active" onclick="window.location.href='SalesReportController'">Sales Report</li>
            <li onclick="window.location.href='salesentry.jsp'">Sales Entry</li>
            <li class="active" onclick="window.location.href='addUserController?action=list'">Users</li>
            <li onclick="window.location.href='LogoutController'">Logout</li>
        </ul>
    </div>

    <!-- Main Content -->
    <div class="main-content">

        <header>
            <h1>
                <c:choose>
                    <c:when test="${not empty user}">Edit User</c:when>
                    <c:otherwise>Add New User</c:otherwise>
                </c:choose>
            </h1>

            <div class="header-right">
                <a href="addUserController?action=list" class="add-car-btn">← Back</a>
            </div>
        </header>

        <!-- Form Card -->
        <div class="addcar-container">
            <h2>User Details</h2>

            <form action="addUserController" method="post" enctype="multipart/form-data">

                <!-- If editing, these will have values; if adding, they’ll be empty -->
                <input type="hidden" name="userId" value="${user.userId}">
                <input type="hidden" name="existingAvatar" value="${user.avatar}">

                <div class="form-group">
                    <label>Full Name</label>
                    <input type="text" name="fullname" placeholder="e.g. Ahmad Zaki" value="${user.fullname}" required>
                </div>

                <div class="form-group">
                    <label>Username</label>
                    <input type="text" name="username" placeholder="e.g. ahmadzaki" value="${user.username}" required>
                </div>

                <div class="form-group">
                    <label>Email</label>
                    <input type="email" name="email" placeholder="e.g. ahmadzaki@example.com" value="${user.email}" required>
                </div>

                <div class="form-group">
                    <label>Role</label>
                    <select name="role" required>
                        <option value="" disabled>Select role</option>
                        <option value="Admin" <c:if test="${user.role == 'Admin'}">selected</c:if>>Admin</option>
                        <option value="Salesperson" <c:if test="${user.role == 'Salesperson'}">selected</c:if>>Salesperson</option>
                        <option value="Staff" <c:if test="${user.role == 'Staff'}">selected</c:if>>Staff</option>
                    </select>
                </div>

                <div class="form-group">
                    <label>
                        Password
                        <c:if test="${not empty user}">(leave blank to keep current)</c:if>
                    </label>
                    <input type="password" name="password"
                           placeholder="<c:choose><c:when test='${not empty user}'>Leave blank to keep current password</c:when><c:otherwise>Enter password</c:otherwise></c:choose>"
                           <c:if test="${empty user}">required</c:if>>
                </div>

                <div class="form-group">
                    <label>Avatar <c:if test="${not empty user}">(optional)</c:if></label>
                    <input type="file" name="avatar" accept="image/*">
                    <c:if test="${not empty user.avatar}">
                        <div style="margin-top:10px;">
                            <img src="${user.avatar}" alt="Current Avatar" style="width:70px;height:70px;border-radius:50%;object-fit:cover;">
                        </div>
                    </c:if>
                </div>

                <button type="submit" class="add-car-btn">
                    <c:choose>
                        <c:when test="${not empty user}">Update User</c:when>
                        <c:otherwise>Save User</c:otherwise>
                    </c:choose>
                </button>

            </form>
        </div>

    </div>

</body>
</html>
