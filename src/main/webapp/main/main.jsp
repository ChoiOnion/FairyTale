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
     .shadow-text {
        color: #FAE1AF;
        font-size: 45px;
        font-weight: 700;
        text-align: center;
        margin-top: 150px;
        text-shadow: 3px 3px 5px rgba(0, 0, 0, 0.8);
     }
     .underline {
        position: relative;
        font-size: 24px;
     }
     .underline::after {
        content: "";
        position: absolute;
        width: 100%;
        height: 2px;
        background-color: #615B57;
        bottom: -5px; /* Adjust this value to move the underline up or down */
        left: 0;
     }
     .underline a {
        color: #026873;
        font-size: 28px;
        font-weight: 700;
        text-decoration: none;
        position: relative;
     }
     .underline a:hover {
        color: #024F57; /* Color change on hover */
     }
     </style>
</head>
<body>
    <div>
        <!-- 사용자 ID 표시 -->
        <div style="position: fixed; top: 35%; right: calc(50% - 230px); color:#615B57; text-align: center;">
            <% String username = (String) session.getAttribute("username"); %>
            <p class="underline">어서오세요</p>
            <p class="underline"><%= username %> 님.</p><br>
            <button class="transparent-button" style="padding: 8px 16px; font-size: 16px;" onclick="location.href='logoutAction.jsp'">로그아웃</button>
        </div>
    </div>
    
    <!-- 책 제목 정렬 -->
    <p class="shadow-text">FairyTale</p>
    
    <!-- 버튼 재정렬 -->
    <div style="position: fixed; top: 30%; left: calc(50% - 220px); text-align: center;">
        <p class="underline"><a href="../intoStory/storyList.jsp">Fairytale</a></p><br>
        <p class="underline"><a href="../simulator/story.jsp">Story</a></p><br>
        <p class="underline"><a href="../game/gameMain.jsp">Game</a></p>
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
