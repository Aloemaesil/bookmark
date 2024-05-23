<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <link rel="stylesheet" type="text/css" href="/login/css/loginstyle.css">
</head>
<body>
        <div class="wrapper">
            <form method="post" action="/login/loginAction.jsp">
                <h1>Login</h1>
                <div class="input-box">
                    <input type="text" id="userID" name="userID" placeholder="Username" required>
                    <i class='bx bxs-user'></i>
                </div>
                <div class="input-box">
                    <input type="password" id="userPassword" name="userPassword" placeholder="Password"required>
                    <i class='bx bxs-lock-alt'></i>
                </div>
                <button type="submit" class="btn">Login</button>
                <div class="register-link">
                    <p>Don`t have an account?
                    <a href="/login/join.jsp">Register</a></p>
                </div>
            </form>

        </div>
</body>
</html>