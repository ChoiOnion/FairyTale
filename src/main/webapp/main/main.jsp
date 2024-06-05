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
    body { 
        font-family: 'TTHakgyoansimRikodeoR';
        background-image: url('bgImage.png');
        background-size: cover;
        background-position: center; 
        background-attachment: fixed;
    }
    .shadow-text {
        color: #615B57;
        font-size: 45px;
        font-weight: 700;
        text-align: center;
        margin-top: 185px;
        text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5);
    }

    /* Button Styles */
    .type--A{
      --line_color: #555555;
      --back_color: #FFECF6;
    }
    .type--B{
      --line_color: #1b1919;
      --back_color: #E9ECFF;
    }
    .type--C{
      --line_color: #00135C;
      --back_color: #DEFFFA;
    }
    .button{
        position: relative;
        z-index: 0;
        width: 240px;
        height: 56px;
        text-decoration: none;
        font-size: 14px; 
        font-weight: bold;
        color: var(--line_color);
        letter-spacing: 2px;
        transition: all .3s ease;
        display: flex;
        justify-content: center;
        align-items: center;
        margin-bottom: 20px; /* Increase the space between buttons */
    }
    .button__text{
        display: flex;
        justify-content: center;
        align-items: center;
        width: 100%;
        height: 100%;
    }
    .button::before,
    .button::after,
    .button__text::before,
    .button__text::after{
        content: '';
        position: absolute;
        height: 3px;
        border-radius: 2px;
        background: var(--line_color);
        transition: all .5s ease;
    }
    .button::before{
        top: 0;
        left: 54px;
        width: calc(100% - 56px * 2 - 16px);
    }
    .button::after{
        top: 0;
        right: 54px;
        width: 8px;
    }
    .button__text::before{
        bottom: 0;
        right: 54px;
        width: calc(100% - 56px * 2 - 16px);
    }
    .button__text::after{
        bottom: 0;
        left: 54px;
        width: 8px;
    }
    .button__line{
        position: absolute;
        top: 0;
        width: 56px;
        height: 100%;
        overflow: hidden;
    }
    .button__line::before{
        content: '';
        position: absolute;
        top: 0;
        width: 150%;
        height: 100%;
        box-sizing: border-box;
        border-radius: 300px;
        border: solid 3px var(--line_color);
    }
    .button__line:nth-child(1),
    .button__line:nth-child(1)::before{
        left: 0;
    }
    .button__line:nth-child(2),
    .button__line:nth-child(2)::before{
        right: 0;
    }
    .button:hover{
        letter-spacing: 6px;
    }
    .button:hover::before,
    .button:hover .button__text::before{
        width: 8px;
    }
    .button:hover::after,
    .button:hover .button__text::after{
        width: calc(100% - 56px * 2 - 16px);
    }
    .button__drow1,
    .button__drow2{
        position: absolute;
        z-index: -1;
        border-radius: 16px;
        transform-origin: 16px 16px;
    }
    .button__drow1{
        top: -16px;
        left: 40px;
        width: 32px;
        height: 0;
        transform: rotate(30deg);
    }
    .button__drow2{
        top: 44px;
        left: 77px;
        width: 32px;
        height: 0;
        transform: rotate(-127deg);
    }
    .button__drow1::before,
    .button__drow1::after,
    .button__drow2::before,
    .button__drow2::after{
        content: '';
        position: absolute;
    }
    .button__drow1::before{
        bottom: 0;
        left: 0;
        width: 0;
        height: 32px;
        border-radius: 16px;
        transform-origin: 16px 16px;
        transform: rotate(-60deg);
    }
    .button__drow1::after{
        top: -10px;
        left: 45px;
        width: 0;
        height: 32px;
        border-radius: 16px;
        transform-origin: 16px 16px;
        transform: rotate(69deg);
    }
    .button__drow2::before{
        bottom: 0;
        left: 0;
        width: 0;
        height: 32px;
        border-radius: 16px;
        transform-origin: 16px 16px;
        transform: rotate(-146deg);
    }
    .button__drow2::after{
        bottom: 26px;
        left: -40px;
        width: 0;
        height: 32px;
        border-radius: 16px;
        transform-origin: 16px 16px;
        transform: rotate(-262deg);
    }
    .button__drow1,
    .button__drow1::before,
    .button__drow1::after,
    .button__drow2,
    .button__drow2::before,
    .button__drow2::after{
        background: var(--back_color);
    }
    .button:hover .button__drow1{
        animation: drow1 ease-in .06s;
        animation-fill-mode: forwards;
    }
    .button:hover .button__drow1::before{
        animation: drow2 linear .08s .06s;
        animation-fill-mode: forwards;
    }
    .button:hover .button__drow1::after{
        animation: drow3 linear .03s .14s;
        animation-fill-mode: forwards;
    }
    .button:hover .button__drow2{
        animation: drow4 linear .06s .2s;
        animation-fill-mode: forwards;
    }
    .button:hover .button__drow2::before{
        animation: drow3 linear .03s .26s;
        animation-fill-mode: forwards;
    }
    .button:hover .button__drow2::after{
        animation: drow5 linear .06s .32s;
        animation-fill-mode: forwards;
    }
    @keyframes drow1{
        0% { height: 0; }
        100% { height: 100px; }
    }
    @keyframes drow2{
        0% { width: 0; opacity: 0; }
        10% { opacity: 0; }
        11% { opacity: 1; }
        100% { width: 120px; }
    }
    @keyframes drow3{
        0% { width: 0; }
        100% { width: 80px; }
    }
    @keyframes drow4{
        0% { height: 0; }
        100% { height: 120px; }
    }
    @keyframes drow5{
        0% { width: 0; }
        100% { width: 124px; }
    }
    </style>
</head>
<body>
    <div>
        <!-- 사용자 ID 표시 -->
        <div style="position: fixed; top: 39%; left: 560px; color:#615B57; text-align: center;">
            <% String username = (String) session.getAttribute("username"); %>
            <p>어서오세요</p>
            <p><%= username %> 님.</p>
            <button class="transparent-button" style="padding: 8px 16px; font-size: 12px;" onclick="location.href='logoutAction.jsp'">로그아웃</button>
        </div>
    </div>
    
    <!-- 책 제목 정렬 -->
    <p class="shadow-text" style="position: fixed; top: 1%; left: 660px; color:#615B57; text-align: center;" >FairyTale</p>
    
    <!-- 버튼 재정렬 -->
    <div style="position: fixed; top: 37%; right: calc(50% - 260px); text-align: center;"> <!-- Moved slightly to the right -->
        <a href="../game/gameMain.jsp" class="button type--A">
            <span class="button__text">Game</span>
            <div class="button__drow1"></div>
            <div class="button__drow2"></div>
        </a>
        <a href="../intoStory/storyList.jsp" class="button type--B">
            <span class="button__text">Fairytale</span>
            <div class="button__drow1"></div>
            <div class="button__drow2"></div>
        </a>
        <a href="../simulator/story.jsp" class="button type--C">
            <span class="button__text">Story</span>
            <div class="button__drow1"></div>
            <div class="button__drow2"></div>
        </a>
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
