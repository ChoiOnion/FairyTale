<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Story</title>
    <style>
        @font-face {
            font-family: 'TTHakgyoansimRikodeoR';
            src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_2402_keris@1.0/TTHakgyoansimRikodeoR.woff2') format('woff2');
            font-weight: normal;
            font-style: normal;
        }
        body {
            font-family: 'TTHakgyoansimRikodeoR', sans-serif;
            font-size: 20px;
            font-weight: 400;
            background-color: #FCFBED;
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .title {
            font-size: 36px;
            color: #026873;
            margin-bottom: 20px;
        }
        .container {
            background: rgba(255, 255, 255, 0.9);
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            text-align: center;
            max-width: 400px;
            width: 100%;
        }
        .welcome-message {
            font-size: 24px;
            margin-bottom: 20px;
            color: #615B57;
        }
        .game-data {
            font-size: 18px;
            color: #615B57;
            margin-bottom: 20px;
        }
        .button-container {
            display: flex;
            justify-content: center;
            gap: 20px;
        }
        .button {
            font-family: 'TTHakgyoansimRikodeoR', sans-serif;
            font-size: 18px;
            padding: 10px 20px;
            background-color: white;
            color: #026873;
            border: 2px solid #026873;
            cursor: pointer;
            border-radius: 5px;
            transition: background-color 0.3s, color 0.3s;
        }
        .button:hover {
            background-color: #026873;
            color: white;
        }
    </style>
</head>
<body>
    <div class="title">불러오기</div>
    <div class="container">
        <%
            String url = "jdbc:mysql://localhost:3306/fairytale?useUnicode=true&characterEncoding=UTF-8";
            String usernameDB = "root";
            String passwordDB = "1234";

            String id = (String) session.getAttribute("id");
            String username = (String) session.getAttribute("username");

            // Check if session ID is null and handle encoding
            if (id == null) {
                out.println("<h2>Session ID is null. Please log in.</h2>");
                out.println("<script>location.href='../main/login.jsp';</script>");
            } else {
                // username의 인코딩을 변환하지 않음
                out.println("<div class='welcome-message'>어서오세요, " + username + " 님.</div>");
            }

            Connection conn = null;
            PreparedStatement pstmt = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection(url, usernameDB, passwordDB);

                String sql = "SELECT progress, friendship FROM story_user WHERE id=?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, id);

                ResultSet rs = pstmt.executeQuery();

                if (rs.next()) {
                    String storyProgress = rs.getString("progress");
                    int storyFriendship = rs.getInt("friendship");

                    if (storyProgress != null && storyFriendship != 0) {
                        out.println("<div class='game-data'>현재 진행도: " + storyProgress + "</div>");
                        out.println("<script>const savedBranch = '" + storyProgress + "';</script>");
                        out.println("<script>const savedFriendship = " + storyFriendship + ";</script>");
                        out.println("<div class='button-container'><button class='button load-game' onclick='loadGame()'>불러오기</button></div>");
                    } else {
                        out.println("<div class='game-data'>저장된 게임 데이터가 없습니다.</div>");
                        out.println("<div class='button-container'><button class='button start-new-game' onclick=\"location.href='index.html'\">새로 시작하기</button></div>");
                    }
                } else {
                    out.println("<div class='game-data'>저장된 게임 데이터가 없습니다.</div>");
                    out.println("<div class='button-container'><button class='button start-new-game' onclick=\"location.href='index.html'\">새로 시작하기</button></div>");
                }
            } catch (Exception e) {
                e.printStackTrace();
                out.println("<div class='game-data'>Error: " + e.getMessage() + "</div>");
            } finally {
                try {
                    if (pstmt != null) pstmt.close();
                    if (conn != null) conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                    out.println("<div class='game-data'>자원을 닫는 중 오류 발생: " + e.getMessage() + "</div>");
                }
            }
        %>
    </div>
    <script>
        function loadGame() {
            localStorage.setItem('progress', savedBranch);
            localStorage.setItem('friendship', savedFriendship);
            location.href = 'index.html';
        }
    </script>
</body>
</html>
