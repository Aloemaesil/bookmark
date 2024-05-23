<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book mark write</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="/write/css/writestyle.css">
</head>

<body>
    <div class="wrap">  
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
    <form method="post" action="/write/writeAction.jsp?userId=<%= userId %>" accept-charset="utf-8">
    <div class="card">
        <div class="card-header1">
            <!-- 게시판을 누를시 첫 페이지인 index.html로 이동 -->
            <h1>당신의 이야기를 공유해주세요</a></h1>
        </div>

        <div class="card-write">
            <div class="title-w">
                제목<input type="text" id="boardTitle" name="boardTitle" placeholder="제목을 입력하세요." accept-charset="utf-8">
            </div>
        <div class="myinfo">
                <!-- text만 입력하기 위해 input에서 type="text" 지정 -->
                <select id="category-filter" name="boardCategory" accept-charset="utf-8">
                    <option value="all">카테고리</option>
                    <option value="technology">기술</option>
                    <option value="it">IT</option>
                    <option value="Novel">소설</option>
                    <option value="SF">SF</option>
                </select>
        
            <div class="msg">
                <!-- 내용을 입력하기 위해 textarea tag를 이용 -->
                내용<textarea id="boardContent" name="boardContent"placeholder="내용을 입력하세요." accept-charset="utf-8"></textarea>
                <input type="file" name="image" id="image">
            </div>
        </div>
        <button type="submit" class="btn-w">Login</button>
    <form>
    </div>
    
</body>
</html>
