<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Write Action</title>
</head>
<body>
<%
    request.setCharacterEncoding("UTF-8");

    // 데이터베이스 연결 정보
    String dbURL = "jdbc:mariadb://10.250.3.72:3306/bookmark?useUnicode=true&characterEncoding=UTF-8";
    String dbUser = "root";
    String dbPassword = "dhsaxpes411!";

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    // 파라미터로 받은 정보 추출
    String boardWriter = request.getParameter("userId");
    String boardTitle = request.getParameter("boardTitle");
    String boardContent = request.getParameter("boardContent");
    String boardImage = "https://alme-upload-test-bucket.s3.ap-northeast-2.amazonaws.com/"+boardWriter+"_"+boardTitle+".png";
    String boardCategory = request.getParameter("boardCategory");

    String RsessionId=request.getRequestedSessionId(); 
    String compareSessionId=session.getId();

    try {
        // 데이터베이스 연결 설정
        Class.forName("org.mariadb.jdbc.Driver");
        conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);

        // SQL 쿼리 실행
        String sql = "INSERT INTO board (boardTitle, boardContent, boardWriter, boardImage, boardCategory) VALUES (?, ?, ?, ?, ?)";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, boardTitle);
        pstmt.setString(2, boardContent);
        pstmt.setString(3, boardWriter);
        pstmt.setString(4, boardImage);
        pstmt.setString(5, boardCategory);
        
        // 쿼리 실행 결과를 반환하여 성공 여부 확인
        int rowsAffected = pstmt.executeUpdate();

        if (rowsAffected > 0 && (boardWriter != null || boardWriter.equals("null"))) {
            // out.println("<p>게시글이 성공적으로 저장되었습니다.</p>");
            response.sendRedirect("https://www.aloemaesil.shop/board?userId="+boardWriter+"&sessionId="+compareSessionId);
        } else {
            // out.println("<p>게시글 저장 중 오류가 발생했습니다.</p>");
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<p>게시글을 저장하는 중 오류가 발생했습니다.</p>");
    } finally {
        try {
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    %>
</body>
</html>
