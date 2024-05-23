<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Join Action</title>
    <script>
        function showPopup() {
            alert("이미 존재하는 ID입니다. 다른 ID를 사용해주세요.");
            window.location.href = "join.jsp"; // join.jsp 페이지로 이동
        }
        function joinSuccess() {
            alert("회원가입이 완료되었습니다.");
            window.location.href = "https://www.aloemaesil.shop"; // join.jsp 페이지로 이동
        }
    </script>
</head>
<body>
    <%
        String userID = request.getParameter("userID");
        String userPassword = request.getParameter("userPassword");
        String userName = request.getParameter("userName");

        String dbURL = "jdbc:mariadb://10.250.3.72:3306/member";
        String dbUser = "root";
        String dbPassword = "dhsaxpes411!";

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            Class.forName("org.mariadb.jdbc.Driver");
            conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);

            // ID 중복 체크
            String checkSQL = "SELECT * FROM user WHERE userID = ?";
            pstmt = conn.prepareStatement(checkSQL);
            pstmt.setString(1, userID);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                // 이미 존재하는 ID일 경우 팝업을 띄우고 join.jsp 페이지로 이동
                out.println("<script>showPopup();</script>");
            } else {
                // ID가 존재하지 않을 경우 회원가입 진행
                String insertSQL = "INSERT INTO user (userID, userPassword, userName) VALUES (?, ?, ?)";
                pstmt = conn.prepareStatement(insertSQL);
                pstmt.setString(1, userID);
                pstmt.setString(2, userPassword);
                pstmt.setString(3, userName);
                int rowsAffected = pstmt.executeUpdate();

                if (rowsAffected > 0) {
                    out.println("<script>joinSuccess();</script>");
                } else {
                    out.println("회원가입 실패");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (pstmt != null) {
                try {
                    pstmt.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    %>
</body>
</html>

