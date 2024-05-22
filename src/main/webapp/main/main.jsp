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
            <button class="transparent-button" style="float:left;
            padding: 8px 16px; font-size: 12px;">게임</button>
            <button class="transparent-button" style="float: right;
            padding: 8px 16px; font-size: 12px;" onclick="location.href='logoutAction.jsp'" >로그아웃</button>
        </div>
    </div>
    
    <p style="color:#615B57; font-size:40px; font-weight:700;">FairyTale</p>
    

    <button  class="transparent-button" style="position: fixed; top: 35%; left: calc(50% - 230px);"
        onclick="location.href='../intoStory/storyList.jsp'">
        <img src="fairy.png" alt="동화" style="width: 100px; height: 100px;">
        <p style="color:#026873; font-size:20px; font-weight:700;">동화</p>
        </button>
	<button  class="transparent-button" style="position: fixed; top: 35%; right: calc(50% - 230px);"
        onclick="location.href='../simulator/index.html'">
        <img src="story.png" alt="스토리" style="width: 100px; height: 100px;">
        <p style="color:#026873; font-size:20px; font-weight:700;">스토리</p>
        </button>
    
    <%-- 세션이 없으면 로그인 페이지로 이동 --%>
    <% if(session.getAttribute("id") == null) { %>
        <script>
            alert("로그인이 필요합니다.");
            location.href='login.jsp';
        </script>
    <% } %>
</body>
</html>
