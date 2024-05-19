<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>

<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Typing</title>
<link
	href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet" />
<link rel="stylesheet" href="style2.css" />
</head>
<script type="text/javascript">

	function start(){
		<% 
		Class.forName("com.mysql.jdbc.Driver");
		String db_address = "jdbc:mysql://localhost:3306/fairytale";
		String db_username = "root";
		String db_pwd = "1234";
	            
		Connection connection = DriverManager.getConnection(db_address, db_username, db_pwd);
		
		String title = request.getParameter("title");
		System.out.println(title);
		String insertQuery = "SELECT text_eng FROM fairytale WHERE progress='1' AND title = ?";
		PreparedStatement psmt = connection.prepareStatement(insertQuery);
		psmt.setString(1, title);
		ResultSet result = psmt.executeQuery();	
		
		String text = "";
        if (result.next()) {
            text = result.getString("text_eng");
        }
		%>	
		var element = document.getElementById("text");
		element.innerText = "<%= text %>";
	}
</script>

<body>
	<div class="container">
	<p id="text">${param.title}</p>

		<div class="stats">
			<p>Time: <span id="timer">0s</span></p>
			<p>Mistakes: <span id="mistakes">0</span></p>
		</div>
		
		<div id="quote"></div>
		
		<textarea rows="5" id="quote-input" placeholder="Type here when the test starts.."></textarea>
		
		<button id="start-test" onclick="start()">Start</button>
		
		<div class="result">
			<h3>Result</h3>
			<div class="wrapper">
				<p>Accuracy: <span id="accuracy"></span></p>
				<p>Speed: <span id="wpm"></span></p>
			</div>
		</div>
		
	</div>
</body>
</html>