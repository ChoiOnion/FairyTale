<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<head>
    <meta charset="UTF-8"> 
    <title>FairyTale</title>
</head>
<body>
    <div>
        <!-- 사용자 ID 표시 -->
        <div style="position: fixed; top: 10px; right: 10px;">
            <% String userId = (String) session.getAttribute("id"); %>
            <p>Welcome, <%= userId %></p>
        </div>
    </div>
    
    <h1>Main Page</h1>
    
    <!-- 세 개의 버튼 -->
    <div>
        <button onclick="location.href='fairyTail.jsp'">FairyTail</button>
        <button onclick="location.href='game.jsp'">Game</button>
        <button onclick="location.href='story.jsp'">Story</button>
    </div>
    
    <%-- 세션이 없으면 로그인 페이지로 이동 --%>
    <% if(session.getAttribute("id") == null) { %>
        <script>
            alert("로그인이 필요합니다.");
            location.href='login.jsp';
        </script>
    <% } %>
</body>
</html>
