<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true"%>
<%@ page import="java.sql.*, java.util.*, javax.servlet.http.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>속담 빈칸 채우기</title>
    <link rel="stylesheet" href="style.css">
    <style>
    @font-face {
    font-family: 'TTHakgyoansimRikodeoR';
    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_2402_keris@1.0/TTHakgyoansimRikodeoR.woff2') format('woff2');
    font-weight: normal;
    font-style: normal;
	}
	
     #game {
    background-color: rgba(255, 255, 255, 0.7);
    border-radius: 10px; 
    padding: 20px;
    margin-bottom: 20px; 
    width: fit-content; 
     text-align: center;
}     #result {
    background-color: rgba(255, 255, 255, 0.7);
    border-radius: 10px; 
    padding: 20px;
    margin-bottom: 20px; 
    width: fit-content; 
     text-align: center;
}
     body{ 
    	font-family: 'TTHakgyoansimRikodeoR';
     	background-image: url('bgImage.png');
        background-size: cover;
        background-position: center; 
        background-attachment: fixed;
        display: flex; 
        flex-direction: column;
    	justify-content: center;
    	align-items: center; 
    	height: 100vh; 
    	margin: 0;
    	font-size: 25px;
        }
     }
     </style>
    <script>
        function loadNewBlank() {
            var xhttp = new XMLHttpRequest();
            xhttp.onreadystatechange = function() {
                if (this.readyState == 4 && this.status == 200) {
                    document.getElementById("blank").innerHTML = this.responseText;
                }
            };
            xhttp.open("GET", "getBlank.jsp", true);
            xhttp.send();
        }
        
        function checkAnswer() {
            var userInput = document.getElementById("userInput").value;
            var xhttp = new XMLHttpRequest();
            xhttp.onreadystatechange = function() {
                if (this.readyState == 4 && this.status == 200) {
                    document.getElementById("result").innerHTML = this.responseText;
                    document.getElementById("userInput").value = "";
                    loadNewBlank();
                }
            };
            xhttp.open("POST", "checkBlank.jsp", true);
            xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
            xhttp.send("userInput=" + userInput);
        }
        
        window.onload = function() {
        	loadNewBlank();
        };
    </script>
</head>
<body>
   <button onclick="location.href='gameMain.jsp'" class="transparent-button" 
   style=" position: fixed;
            top: 20px;
            left: 20px;">이전 화면</button>

    <h2 style="color: #4E4742;">속담 빈칸 채우기 게임</h2>
    <br>
    <div id="game">
      <div id="blank" style="text-align: center;"></div>
      
    	</div>
    	<div id="game">
    		<form onsubmit="event.preventDefault(); checkAnswer();">
        		<input type="text" id="userInput" style="width: 200px;" placeholder="알맞은 영어 단어를 입력하세요." required>
        		<button  class="transparent-button" type="submit">확인</button>
    		</form>
    	</div>
    <div id="result"></div>
    
        <%-- 세션이 없으면 로그인 페이지로 이동 --%>
    <% if(session.getAttribute("id") == null) { %>
        <script>
            alert("로그인이 필요합니다.");
            location.href='../main/login.jsp';
        </script>
    <% } %>
</body>
</html>
