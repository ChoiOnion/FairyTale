<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>로그인</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR:wght@300;400;500;600;700&family=Noto+Sans+KR:wght@300&display=swap" rel="stylesheet">
    
    <link rel="stylesheet" href="style.css">
</head>
 
<body>
	<h1 style="font-size:40px; font-weight:700">Welcome back!</h1>
	<form action="loginAction.jsp" method="post">
        <label for="id" class="green">ID:</label><br>
        <input type="text" id="id" name="id" placeholder="Enter your ID" required><br>
        <label for="pwd" class="green">Password:</label><br>
        <input type="password" id="pwd" name="pwd" placeholder="Enter your password" required><br><br>
        <input type="submit" value="Login" class="greenbtn">
    </form>
    <p style="font-size:15px; font-weight:300;">계정이 없으신가요? <a href="join.jsp">회원 가입</a></p>
</body>
</html>
