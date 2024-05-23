<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Move Page</title>
</head>
<body>
        <%
            String page = request.getParameter("page");
            String userID = (String) session.getAttribute("userID");
            if (userID != null){
                session.setAttribute("userID", userID);
            }
            String userSession = (String) session.setAttribute("userID", userID);
            if(userSession != null){
                response.sendRedirect("https://www.aloemaesil.shop/"+page?userID=userSession);
            } else {
                response.sendRedirect("https://www.aloemaesil.shop/"+page);
            }
        %>
</body>
</html>