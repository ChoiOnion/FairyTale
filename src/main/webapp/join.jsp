<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<head>
    <meta charset="UTF-8">
    <title>회원가입</title>
</head>
 
<body>   
<h2>Join</h2>
    <form action="joinAction.jsp" method="post">
        <label for="id">id:</label><br>
        <input type="text" id="id" name="id" required>
        <span id="idError" style="color:red;"></span>
        <br>
        <label for="pwd">Password:</label><br>
        <input type="password" id="pwd" name="pwd" required><br>
        <label for="name">Name:</label><br>
        <input type="text" id="name" name="name" required><br><br>
        <input type="submit" value="Join">
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