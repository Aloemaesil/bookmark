<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register</title>
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <link rel="stylesheet" href="/login/css/joinstyle.css">
</head>
<body>

    <div class="wrapper">
        <form method="post" action="/login/joinAction.jsp" onsubmit="return validateForm()">
            <h1>Registration</h1>
            <div class="input-box">
                <input type="text" id="userID" name="userID" placeholder="ID" required>
                <i class='bx bxs-user'></i>
            </div>
            <div class="input-box">
                <input type="password" placeholder="Password" id="userPassword" name="userPassword" required>
                <i class='bx bxs-lock-alt'></i>
            </div>
            <div class="input-box">
                <input type="password" id="checkUserPassword" name="checkUserPassword" placeholder="Check Password" required>
                <i class='bx bxs-lock-alt'></i>
            </div>
            <div class="input-box">
                <input type="text" id="userName" name="userName" placeholder="userName" required>
                <i class= 'bx bxs-user'></i>
            </div>

            <div class="remember-forgot">
                <label><input type="checkbox" id="agreeCheckbox"> 회원가입 정보 수집을 동의하겠습니다.</label>
            </div>

            <button type="submit" class="btn">Register</button>
            <div class="register-link">
                <p>Already have an account?
                <a href="https://www.aloemaesil.shop/">Login</a></p>
            </div>
        </form>
    </div>

    <script>
        function validateForm() {
            var userPassword = document.getElementById("userPassword").value;
            var checkUserPassword = document.getElementById("checkUserPassword").value;

            if (userPassword !== checkUserPassword) {
                alert("비밀번호가 일치하지 않습니다.");
                return false;
            }

            var agreeCheckbox = document.getElementById("agreeCheckbox");
            if (!agreeCheckbox.checked) {
                alert("회원가입 정보를 동의하지 않으셨습니다.");
                return false;
            }
            return true;
        }
    </script>
</body>
</html>
