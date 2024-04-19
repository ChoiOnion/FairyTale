<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<head>
    <meta charset="UTF-8"> 
    <title>FairyTale</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR:wght@300;400;500;600;700&family=Noto+Sans+KR:wght@300&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="style.css">
    <style>
     body{
     background-color:#026873;
     }
     </style>
</head>
<body>
    <div>
        <!-- 사용자 ID 표시 -->
        <div style="position: fixed; top: 10px; right: 10px; color:#c3bbb6;">
            <% String userId = (String) session.getAttribute("id"); %>
            <p>Welcome, <%= userId %></p>
        </div>
    </div>
    
    <p style="color:#FCFBED; font-size:40px; font-weight:700;">Our Services</p>
    <p style="color:#c3bbb6;">Have a good time with Fairy Tales</p>
    
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
