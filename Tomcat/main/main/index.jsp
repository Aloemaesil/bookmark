<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book mark Login</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="/css/mainstyle.css">
</head>

<body>
    <div class="wrap">
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
            <div class="main_text1">
                <h1>BEST WRITING</h1>
                <div class="contents1">인기글</div>
            </div>
        
            <div class="card-container">
            <%
                String dbURL = "jdbc:mariadb://10.250.3.72:3306/bookmark";
                String dbUser = "root";
                String dbPassword = "dhsaxpes411!";
          
                Connection conn = null;
                Statement stmt = null;
                ResultSet rs = null;
                try {
                    // 데이터베이스 연결 설정
                    Class.forName("org.mariadb.jdbc.Driver");
                    conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);
          
                    // SQL 쿼리 실행
                    stmt = conn.createStatement();
                    String sql = "SELECT * FROM board";
                    rs = stmt.executeQuery(sql);
          
                    // 결과를 반복문을 사용하여 가져와서 출력
                    int count = 0;
                    while(rs.next() && count < 4) {
                        int boardID = rs.getInt("boardID");
                        String boardTitle = rs.getString("boardTitle");
                        String boardContent = rs.getString("boardContent");
                        String boardWriter = rs.getString("boardWriter");
                        String boardImage = rs.getString("boardImage");
                        String boardCategory = rs.getString("boardCategory");
                        count++;
            %>
                <div class="card">
                    <img src="<%= boardImage %>"> 
                    <div class="card-content">
                        <h3><%= boardTitle %></h3>
                        <p><%= boardWriter %></p>
                        <a href="https://www.aloemaesil.shop/board/detail.jsp?id=<%= boardID %>&userId=<%= userId %>&sessionId=<%= compareSessionId %>" class="btn">Read More</a>
                    </div>
                </div>
            <%
                  }
                } catch (Exception e) {
                  e.printStackTrace();
                } finally {
                  try {
                    if(rs != null) rs.close();
                    if(stmt != null) stmt.close();
                    if(conn != null) conn.close();
                  } catch (SQLException e) {
                    e.printStackTrace();
                  }
                }
            %>
            </div>
            <% if (userId != null && !userId.equals("null")) { %>
            <div class="main_text0">
                <h1>ABOUT</h1>
                <ul class="icons">
                    <li>
                        <div class="icon_img">
                            <img src="/board/image/icon4.png">
                        </div>
                        <div class="contents1_bold">게시판</div>
                        <div class="contents1">
                            사람들의 이야기를 즐겨보세요
                        </div>
                        <div class="more">
                            <a href="https://www.aloemaesil.shop/board?userId=<%= userId %>&sessionId=<%= compareSessionId %>">MORE</a>
                        </div>
                    </li>
                    <li>
                        <div class="icon_img">
                            <img src="/board/image/icon2.png">
                        </div>
                        <div class="contents1_bold">집필</div>
                        <div class="contents1">
                            자신의 이야기를 적어보세요 
                        </div>
                        <div class="more">
                            <a href="https://www.aloemaesil.shop/write?userId=<%= userId %>&sessionId=<%= compareSessionId %>">MORE</a>
                        </div>
                    </li>
                    <li>
                        <div class="icon_img">
                            <img src="/board/image/icon3.png">
                        </div>
                        <div class="contents1_bold">공지사항</div>
                        <div class="contents1">
                            새로운 공지사항을 확인하세요
                        </div>
                        <div class="more">
                            <a href="https://www.aloemaesil.shop/event?userId=<%= userId %>&sessionId=<%= compareSessionId %>">MORE</a>
                        </div>
                    </li>
                </ul>
            </div>
            <% } else { %>
            <div class="main_text0">
                <h1>ABOUT</h1>
                <ul class="icons">
                    <li>
                        <div class="icon_img">
                            <img src="/board/image/icon4.png">
                        </div>
                        <div class="contents1_bold">게시판</div>
                        <div class="contents1">
                            사람들의 이야기를 즐겨보세요
                        </div>
                        <div class="more">
                            <a href="https://www.aloemaesil.shop/board">MORE</a>
                        </div>
                    </li>
                    <li>
                        <div class="icon_img">
                            <img src="/board/image/icon2.png">
                        </div>
                        <div class="contents1_bold">집필</div>
                        <div class="contents1">
                            자신의 이야기를 적어보세요 
                        </div>
                        <div class="more">
                            <a href="https://www.aloemaesil.shop/write">MORE</a>
                        </div>
                    </li>
                    <li>
                        <div class="icon_img">
                            <img src="/board/image/icon3.png">
                        </div>
                        <div class="contents1_bold">공지사항</div>
                        <div class="contents1">
                            새로운 공지사항을 확인하세요
                        </div>
                        <div class="more">
                            <a href="https://www.aloemaesil.shop/event">MORE</a>
                        </div>
                    </li>
                </ul>
            </div>
            <% } %>
        </div>
    </body>
</html>
