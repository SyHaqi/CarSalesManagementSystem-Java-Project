<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="LoginStyle.css">
</head>
<body>

<div class="center-box">
	<div class="login-card">
    	<h2>Login</h2>
    	<form action="LoginController" method="post">
    		<c:if test="${not empty errorMessage}">
            	<div class="error-message">${errorMessage}</div>
        	</c:if>
        	<input type="text" name="username" placeholder="Username" required><br>
        	<input type="password" name="password" placeholder="Password" required><br>

        	<button type="submit">Login</button>
    	</form>
    	<div class="register-container">
            <a href="register.jsp" class="register-link">Register</a>
        </div>
    	
	</div>
</div>
</body>
</html>

