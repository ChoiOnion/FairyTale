<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<head>
    <meta charset="UTF-8">
    <title>회원가입</title> 
    <link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR:wght@300;400;500;600;700&family=Noto+Sans+KR:wght@300&display=swap" rel="stylesheet">
    
    <link rel="stylesheet" href="style.css">
</head>
 
<body>   
	<h1 style="font-size:40px; font-weight:700">Get Started Now</h1>
    <form action="joinAction.jsp" method="post">
        <label for="ID" class="green">ID:</label><br>
        <input type="text" id="id" name="id" placeholder="Enter your ID" required>
        <span id="idError" style="color:red;"></span>
        <br>
        <label for="pwd" class="green">Password:</label><br>
        <input type="password" id="pwd" name="pwd" placeholder="Enter your password" required><br>
        <label for="name" class="green">Name:</label><br>
        <input type="text" id="name" name="name" placeholder="Enter your name" required><br><br>
        <input type="submit" value="Join" class="greenbtn">
    </form>


    <script>
    window.onload = function() {
        document.getElementById("id").addEventListener("blur", function() {
            var id =  document.getElementById("id").value;
            var xhr = new XMLHttpRequest();
            xhr.open("POST", "checkId.jsp", true);
            xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
            xhr.send("id="+ id);

            console.log(id);
            xhr.onreadystatechange = function() {
                if (xhr.readyState == 4 && xhr.status == 200) {
                    var response = xhr.responseText;
                    var idError = document.getElementById("idError");
                    if (response.trim() === "exists") {
                        idError.textContent = "이미 존재하는 아이디입니다.";
                        document.getElementById("id").value = '';
                        document.getElementById("id").focus();
                    } 
                }
            };
        });
    };
    </script>
</body>
</html>