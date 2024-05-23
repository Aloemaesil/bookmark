<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book Mark</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="/board/css/boardlist.css">
</head>

<body>
    <div class="wrap" style="text-align: center;">
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
            <div class="intro_text">
                <h4>당신의 이야기를 책으로 써보세요</h4>
            </div>
        </div>
        <!-- intro end-->

        <select id="category-filter">
            <option value="all">전체</option>
            <option value="technology">기술</option>
            <option value="it">IT</option>
            <option value="Novel">소설</option>
            <option value="SF">SF</option>

            <!-- 필요한 만큼 카테고리를 추가할 수 있습니다. -->
        </select>

    <!-- Java 코드를 사용하여 데이터베이스와 연결하고 SQL 쿼리를 실행하여 결과를 가져오기 -->
    <%
    // case1 => redis 통신이 성공하면 
    // ~~~~

    // case 2 => redis에 데이터X => DB 접속해서 데이터 가져오기
    // 작업 후 redis에 캐시 값 저장
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
        while(rs.next()) {
          int boardID = rs.getInt("boardID");
          String boardTitle = rs.getString("boardTitle");
          String boardContent = rs.getString("boardContent");
          String boardWriter = rs.getString("boardWriter");
          String boardImage = rs.getString("boardImage");
          String boardCategory = rs.getString("boardCategory");
    %>

            <!-- 가져온 데이터를 사용하여 동적으로 게시물 표시 -->
            <div class="post-box <%= boardCategory %>" style="display: block;">
                <a href="./board/detail.jsp?id=<%= boardID %>&userId=<%= userId %>&sessionId=<%= compareSessionId %>">
                    <img src="<%= boardImage %>" alt="포스트 이미지" class="post-image">
                    <div class="post-content">
                        <h2 class="post-title">
                            <%= boardTitle %>
                        </h2>
                        <p class="post-summary">
                            <%= boardContent %>
                        </p>
                    </div>
                    <p class="author-nickname">작성자: <%= boardWriter %>
                    </p>
                    <p class="board-category">카테고리: <%= boardCategory %>
                    </p>
                </a>
            </div>
            <script>
                // 카테고리 선택 드롭다운 메뉴
                const categoryFilter = document.getElementById("category-filter");

                // 포스트를 표시하는 함수
                function displayPosts(category) {
                    const postBoxes = document.querySelectorAll('.post-box');
                    postBoxes.forEach(postBox => {
                        if (category === "all" || postBox.classList.contains(category)) {
                            postBox.style.display = 'block';
                        } else {
                            postBox.style.display = 'none';
                        }
                    });
                }

                // 페이지 로드 시 전체 카테고리의 포스트를 표시
                displayPosts("all");

                // 카테고리 선택 시 해당 카테고리의 포스트를 표시
                categoryFilter.addEventListener("change", function () {
                    const selectedCategory = this.value;
                    displayPosts(selectedCategory);
                });
            </script>

    <!-- Java 코드 종료 -->
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
</body>

</html>
