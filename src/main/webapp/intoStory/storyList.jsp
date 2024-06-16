<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>

<!DOCTYPE html>
<html lang="en">
   <!-- divinectorweb.com -->
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Fairy tale</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;700&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Bebas+Neue&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Jost:wght@&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@500;600&display=swap" rel="stylesheet">
	<link href="https://fonts.googleapis.com/css2?family=Gaegu&family=Handlee&family=Poppins:wght@100&family=Raleway:ital,wght@0,100..900;1,100..900&family=Sunflower:wght@300&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="style.css">
    <script>
    	function move(title){
    			var info = title;
    			location.href="typing.jsp?title=" + title;
    	}
        document.addEventListener('DOMContentLoaded', function() {
            document.getElementById('backButton').addEventListener('click', function() {
                window.history.back(); // 뒤로 가기
            });
        });
    </script>
</head>
<body>
	<svg xmlns="http://www.w3.org/2000/svg" width="50" height="50" fill="currentColor" class="bi bi-caret-left" viewBox="0 0 16 16" id="backButton">
        <path d="M10 12.796V3.204L4.519 8zm-.659.753-5.48-4.796a1 1 0 0 1 0-1.506l5.48-4.796A1 1 0 0 1 11 3.204v9.592a1 1 0 0 1-1.659.753"/>
    </svg>
  <div class="title"> Going into Fairy Tale</div>
  <div class="subtitle"> Have a good time with Fairy Tales</div>
  
  <div class="wrapper">
<% 

	Class.forName("com.mysql.jdbc.Driver");
	String db_address = "jdbc:mysql://localhost:3306/fairytale";
	String db_username = "root";
	String db_pwd = "1234";
                
	Connection connection = DriverManager.getConnection(db_address, db_username, db_pwd);
                
	String insertQuery = "SELECT distinct(title) FROM fairytale";
	PreparedStatement psmt = connection.prepareStatement(insertQuery);
	ResultSet result = psmt.executeQuery();
	
	while(result.next()){
		String title = result.getString("title");
%>
	<div class="single-card">
      <div class="img-area">
        <img src="<%= title+".jpg" %>" alt="">
        <div class="overlay">
          <button class="Following" onclick = 'move("<%=title%>")'>Following</button>
          <button class="restart">restart</button>
        </div>
      </div>
      <div class="info">
        <h3><%= title%></h3>
        <p>책 소개를 작성하세요.</p>
      </div>
    </div>
<%
	}
%>
  </div>
    
</body>
</html>
