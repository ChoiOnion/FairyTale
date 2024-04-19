<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>로그인</title>
</head>
 
<body>
	<h1>Welcome back!</h1>
	<form action="loginAction.jsp" method="post">
        <label for="id">Id:</label><br>
        <input type="text" id="id" name="id"><br>
        <label for="pwd">Password:</label><br>
        <input type="password" id="pwd" name="pwd"><br><br>
        <input type="submit" value="Login">
    </form>
    <p>계정이 없으신가요? <a href="join.jsp">회원 가입</a></p>
</body>
</html>
