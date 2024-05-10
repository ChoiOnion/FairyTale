<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<head>
    <meta charset="UTF-8"> 
    <title>FairyTale</title>
    <link rel="stylesheet" href="style.css">
    <style>
    @font-face {
    font-family: 'TTHakgyoansimRikodeoR';
    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_2402_keris@1.0/TTHakgyoansimRikodeoR.woff2') format('woff2');
    font-weight: normal;
    font-style: normal;
	}
     body{ 
    	font-family: 'TTHakgyoansimRikodeoR';
     	background-image: url('bgImage.png');
        background-size: cover;
        background-position: center; 
        background-attachment: fixed;
        }
     }
     </style>
</head>
<body>
    <div>
        <!-- 사용자 ID 표시 -->
        <div style="position: fixed; top: 10px; right: 10px; color:#615B57;">
            <% String username = (String) session.getAttribute("username"); %>
            <p>어서오세요, <%= username %> 님.</p>
            <button onclick="location.href='logoutAction.jsp'">로그아웃</button>
        </div>
    </div>
    
    <p style="color:#615B57; font-size:40px; font-weight:700;">FairyTale</p>
    
    <!-- 세 개의 버튼 -->
    <div>
        <button onclick="location.href='fairyTale.jsp'">동화</button>
        <button onclick="location.href='game.jsp'">게임</button>
		<button onclick="location.href='../simulator/index.html'">스토리</button>
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
