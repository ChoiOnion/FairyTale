<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>로그인</title>
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
    }
    </style>
</head>
 
<body>
	<h1 style="font-size:40px; font-weight:700">어서오세요!</h1>
	<form action="loginAction.jsp" method="post">
        <label for="id" class="green">아이디:</label><br>
        <input type="text" id="id" name="id" placeholder="Enter your ID" required><br>
        <br>
        <label for="pwd" class="green">비밀번호:</label><br>
        <input type="password" id="pwd" name="pwd" placeholder="Enter your password" required><br><br>
        <button class="transparent-button">로그인</button>
    </form>
    <p style="font-size:15px; font-weight:300;">계정이 없으신가요? <a href="join.jsp">회원 가입</a></p>
</body>
</html>
