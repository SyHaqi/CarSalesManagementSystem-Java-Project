<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - CarSales</title>

    <!-- Reuse your theme -->
    <link rel="stylesheet" href="dashboard.css">

    <!-- Small page-only styling (kept inside JSP to avoid making a new css file) -->
    <style>
        .auth-wrapper{
            min-height: 100vh;
            display:flex;
            align-items:center;
            justify-content:center;
            padding: 30px;
        }
        .auth-card{
            width: 100%;
            max-width: 520px;
            background: white;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.12);
            overflow: hidden;
        }
        .auth-header{
            background: #1e3a8a;
            color: white;
            padding: 22px 26px;
        }
        .auth-header h2{
            margin: 0;
            font-size: 22px;
        }
        .auth-header p{
            margin: 6px 0 0;
            opacity: 0.9;
            font-size: 14px;
        }

        .auth-body{
            padding: 24px 26px 26px;
        }

        .grid-2{
            display:grid;
            grid-template-columns: 1fr 1fr;
            gap: 14px;
        }

        .form-group{
            margin-bottom: 14px;
        }

        .form-group label{
            display:block;
            margin-bottom: 6px;
            font-weight: bold;
            color: #444;
            font-size: 14px;
        }

        .form-group input{
            width: 100%;
            padding: 12px;
            border-radius: 8px;
            border: 1px solid #aaa;
            font-size: 15px;
            box-sizing: border-box;
            outline: none;
        }

        .form-group input:focus{
            border-color: #1e3a8a;
            box-shadow: 0 0 0 3px rgba(30,58,138,0.12);
        }

        .helper{
            font-size: 12px;
            color: #666;
            margin-top: 6px;
        }

        .error-message{
            background: #fee2e2;
            color: #991b1b;
            padding: 10px 12px;
            border-radius: 8px;
            margin-bottom: 14px;
            font-size: 14px;
            border: 1px solid #fecaca;
        }

        .btn-row{
            display:flex;
            gap: 12px;
            align-items:center;
            margin-top: 16px;
        }

        .btn-outline{
            background: transparent;
            border: 2px solid #1e3a8a;
            color: #1e3a8a;
            padding: 10px 18px;
            border-radius: 8px;
            font-size: 15px;
            font-weight: bold;
            cursor: pointer;
            text-decoration: none;
            transition: 0.25s ease;
            display:inline-block;
        }
        .btn-outline:hover{
            background: rgba(30,58,138,0.08);
            transform: translateY(-2px);
        }

        /* Reuse your add-car-btn look */
        .btn-primary{
            width: 100%;
        }

        .footer-link{
            margin-top: 14px;
            font-size: 14px;
            color: #555;
            text-align: center;
        }
        .footer-link a{
            color: #1e3a8a;
            font-weight: bold;
            text-decoration: none;
        }
        .footer-link a:hover{
            text-decoration: underline;
        }

        @media (max-width: 560px){
            .grid-2{ grid-template-columns: 1fr; }
        }
    </style>
</head>

<body>

<div class="auth-wrapper">
    <div class="auth-card">

        <div class="auth-header">
            <h2>Create Guest Account</h2>
            <p>Register to continue. Your role will be <b>Guest</b>.</p>
        </div>

        <div class="auth-body">

            <c:if test="${not empty errorMessage}">
                <div class="error-message">${errorMessage}</div>
            </c:if>

            <form action="RegisterController" method="post" enctype="multipart/form-data">

                <div class="form-group">
                    <label>Full Name</label>
                    <input type="text" name="fullname" placeholder="e.g. Ahmad Zaki" required>
                </div>

                <div class="grid-2">
                    <div class="form-group">
                        <label>Username</label>
                        <input type="text" name="username" placeholder="e.g. ahmadzaki" required>
                    </div>

                    <div class="form-group">
                        <label>Email</label>
                        <input type="email" name="email" placeholder="e.g. ahmad@example.com" required>
                    </div>
                </div>

                <div class="form-group">
                    <label>Password</label>
                    <input type="password" name="password" placeholder="Create a strong password" required>
                    <div class="helper">Tip: Use at least 8 characters.</div>
                </div>

                <div class="form-group">
                    <label>Avatar (Optional)</label>
                    <input type="file" name="avatar" accept="image/*">
                    <div class="helper">If empty, default avatar will be used.</div>
                </div>

                <div class="btn-row">
                    <a href="LoginPage.jsp" class="btn-outline">← Back</a>
                    <button type="submit" class="add-car-btn btn-primary">Create Account</button>
                </div>

            </form>

            <div class="footer-link">
                Already have an account? <a href="LoginPage.jsp">Login</a>
            </div>

        </div>
    </div>
</div>

</body>
</html>
