<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book mark</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="/board/css/detail.css">
</head>
<body>
    <%
    // 데이터베이스 연결 정보
    String dbURL = "jdbc:mariadb://10.250.3.72:3306/bookmark";
    String dbUser = "root";
    String dbPassword = "dhsaxpes411!";

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    // boardID 파라미터를 받기
    String boardIDParam = request.getParameter("id");

    // 유효한 boardID가 전달되었는지 확인
    if (boardIDParam != null && !boardIDParam.isEmpty()) {
        int boardID = Integer.parseInt(boardIDParam);

        try {
            // 데이터베이스 연결 설정
            Class.forName("org.mariadb.jdbc.Driver");
            conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);

            // SQL 쿼리 실행
            String sql = "SELECT * FROM board WHERE boardID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, boardID);
            rs = pstmt.executeQuery();

            // 결과를 반복문을 사용하여 가져와서 출력
            if(rs.next()) {
                String boardTitle = rs.getString("boardTitle");
                String boardContent = rs.getString("boardContent");
                String boardWriter = rs.getString("boardWriter");
                String boardImage = rs.getString("boardImage");
                String boardCategory = rs.getString("boardCategory");
                // String boardLike = rs.getString("boardLike");
    %>

    <div class="wrap">  
        <div class="intro_bg">
            <div class="intro_bg">
                <div class="header">
                    <ul class="nav">
                        <% 
                        String RsessionId = request.getRequestedSessionId();
                        String compareSessionId = session.getId();
                        String sessionId = request.getParameter("sessionId");
                        String userId = request.getParameter("userId");
        
                        // Check if userId is null or sessionId is "temp"
                        if (userId == null || sessionId == null || userId.equals("null")) {
                        %>
                            <li><a href="https://www.aloemaesil.shop/">HOME</a></li>
                            <li><a href="https://www.aloemaesil.shop/board">BOARD</a></li>
                            <li><a href="https://www.aloemaesil.shop/write">WRITING</a></li>
                            <li><a href="https://www.aloemaesil.shop/event">EVENT</a></li>
                            <li><a href="https://www.aloemaesil.shop/login">Login</a></li>
                        <% 
                        } else {
                            // Check if sessionId matches
                            if (!userId.equals("null") && (sessionId != null && (sessionId.equals(RsessionId) || compareSessionId.equals(RsessionId)))) {
                        %>
                                <li><a href="https://www.aloemaesil.shop?userId=<%= userId %>&sessionId=<%= compareSessionId %>">HOME</a></li>
                                <li><a href="https://www.aloemaesil.shop/board?userId=<%= userId %>&sessionId=<%= compareSessionId %>">BOARD</a></li>
                                <li><a href="https://www.aloemaesil.shop/write?userId=<%= userId %>&sessionId=<%= compareSessionId %>">WRITING</a></li>
                                <li><a href="https://www.aloemaesil.shop/event?userId=<%= userId %>&sessionId=<%= compareSessionId %>">EVENT</a></li>
                                <li>
                                    <span style="color: rgb(41, 112, 255);">
                                        <%= userId %>
                                    </span><span style="color: white;">님 환영합니다.</span><a href="https://www.aloemaesil.shop/login/logout.jsp" style="color: white;">Logout</a>
                                </li>
                            <% 
                            } else {
                            // If sessionId doesn't match
                            %>
                                <li><a href="https://www.aloemaesil.shop/">HOME</a></li>
                                <li><a href="https://www.aloemaesil.shop/board">BOARD</a></li>
                                <li><a href="https://www.aloemaesil.shop/write">WRITING</a></li>
                                <li><a href="https://www.aloemaesil.shop/event">EVENT</a></li>
                                <li><a href="https://www.aloemaesil.shop/login">Login</a></li>
                            <% 
                            }
                        } 
                        %>
                    </ul>
                </div>
            </div>

            <div class="container">
                <div class="post">
                    <div class="post-header">
                        <h1 class="post-title"><%= boardTitle %></h1>
                        <div class="post-meta">
                            <span>작성자: <%= boardWriter %></span>
                        </div>
                    </div>
                    <div class="post-content">
                        <img src="<%= boardImage %>" alt="게시글 이미지">
                        <p><%= boardContent %></p>
                        <!-- 좋아요 버튼 요소를 추가합니다. -->
                        <button class="like-btn">좋아요</button>
                        <!-- 좋아요 숫자를 표시하는 요소를 추가합니다. -->
                        <span id="like-count" class="like-count">1</span>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- JavaScript 파일을 추가합니다. -->
    <script src="./board/css/boarddetailscript.js"></script>

    <%
            } else {
                out.println("<p>해당 게시글을 찾을 수 없습니다.</p>");
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<p>게시글을 불러오는 중 오류가 발생했습니다.</p>");
        } finally {
            try {
                if(rs != null) rs.close();
                if(pstmt != null) pstmt.close();
                if(conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    } else {
        out.println("<p>유효한 게시글 ID가 제공되지 않았습니다.</p>");
    }
    %>
</body>
</html>
