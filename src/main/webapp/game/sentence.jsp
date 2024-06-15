<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true"%>
<%@ page import="java.sql.*, java.util.*, javax.servlet.http.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>문장 완성 게임</title>
    <link rel="stylesheet" href="style.css">
    <style>
        @font-face {
            font-family: 'TTHakgyoansimRikodeoR';
            src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_2402_keris@1.0/TTHakgyoansimRikodeoR.woff2') format('woff2');
            font-weight: normal;
            font-style: normal;
        }

        .word {
            cursor: pointer;
            display: inline-block;
            margin: 5px;
            padding: 5px;
            border: 2px solid #026873;
            border-radius: 5px;
            background-color:rgba(255, 255, 255, 0.6);
        }

        .word.selected {
            background-color:rgba(173, 173, 173, 0.6);
        }

        #game {
            background-color: rgba(255, 255, 255, 0.7);
            border-radius: 10px; 
            padding: 20px;
            margin-bottom: 20px; 
            width: fit-content; 
            text-align: center;
        }

        #result {
            background-color: rgba(255, 255, 255, 0.7);
            border-radius: 10px; 
            padding: 20px;
            margin-bottom: 20px; 
            width: fit-content; 
            text-align: center;
        }

        body { 
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
    </style>
    <script>
    var userInputArray = []; // 사용자 입력을 저장할 배열

    function loadNewSentence() {
        var xhttp = new XMLHttpRequest();
        xhttp.onreadystatechange = function() {
            if (this.readyState == 4 && this.status == 200) {
                document.getElementById("sentence").innerHTML = this.responseText;
                addClickHandlers(); // 새 문장을 불러온 후 클릭 핸들러 추가
            }
        };
        xhttp.open("GET", "getSentence.jsp", true);
        xhttp.send();
    }

    function checkAnswer() {
        var userInput = userInputArray.join(" "); // 배열을 공백으로 구분된 문자열로 변환
        var xhttp = new XMLHttpRequest();
        xhttp.onreadystatechange = function() {
            if (this.readyState == 4 && this.status == 200) {
                document.getElementById("result").innerHTML = this.responseText;
                document.getElementById("userInput").value = "";
                loadNewSentence();
                userInputArray = []; // 사용자 입력 배열 초기화
            }
        };
        xhttp.open("POST", "checkSentence.jsp", true);
        xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
        xhttp.send("userInput=" + encodeURIComponent(userInput));
    }

    function addClickHandlers() {
        var words = document.getElementsByClassName("word");
        for (var i = 0; i < words.length; i++) {
            words[i].addEventListener("click", function() {
                if (this.classList.contains("selected")) {
                    this.classList.remove("selected");
                    var index = userInputArray.indexOf(this.textContent);
                    if (index !== -1) {
                        userInputArray.splice(index, 1); // 배열에서 클릭된 단어 제거
                    }
                } else {
                    this.classList.add("selected");
                    userInputArray.push(this.textContent); // 배열에 클릭된 단어 추가
                }
                updateTextInput(); // userInput를 업데이트하여 표시
            });
        }
    }

    function updateTextInput() {
        var userInputText = userInputArray.join(" "); // 배열을 공백으로 구분된 문자열로 변환
        document.getElementById("userInput").value = userInputText;
    }

    window.onload = function() {
        loadNewSentence();
    };
    </script>
</head>
<body>
    <button onclick="location.href='gameMain.jsp'" class="transparent-button" 
        style=" position: fixed;
                top: 20px;
                left: 20px;">이전 화면</button>

    <h2 style="color: #4E4742;">문장 완성 게임</h2>
    <br>
    <div id="game">
        <div id="sentence" style="text-align: center;"></div>
    </div>
    <div id="game">
        <form onsubmit="event.preventDefault(); checkAnswer();">
            <input type="text" id="userInput" style="width: 400px;" placeholder="문장을 완성해보세요." required readonly>
            <button class="transparent-button" type="submit">확인</button>
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

    <script>
        addClickHandlers(); // 페이지 로드 시 클릭 핸들러 추가
    </script>
</body>
</html>
