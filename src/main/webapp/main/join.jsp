<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<head>
    <meta charset="UTF-8">
    <title>회원가입</title> 
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
	<h1 style="font-size:40px; font-weight:700">회원가입해서 시작하세요.</h1>
    <form action="joinAction.jsp" method="post">
        <label for="ID" class="green">ID:</label><br>
        <input type="text" id="id" name="id" placeholder="Enter your ID" required>
        <span id="idError" style="color:red;"></span>
        <br>
        <br>
        <label for="pwd" class="green">비밀번호:</label><br>
        <input type="password" id="pwd" name="pwd" placeholder="Enter your password" required><br>
        <br>
        <label for="name" class="green">이름:</label><br>
        <input type="text" id="name" name="name" placeholder="Enter your name" required><br><br>
        <button class="transparent-button">회원가입</button>
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