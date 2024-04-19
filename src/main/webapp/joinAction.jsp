<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<head>
    <meta charset="UTF-8">
     <script>
        function showAlert(message) {
            alert(message);
        }
        
        function redirectToJoin() {
            window.location.href = "join.jsp";
        }
        
        function Login() {
            window.location.href = "login.jsp";
        }
    </script>
</head>
<body>
    <%
        String url = "jdbc:mysql://localhost:3306/fairytale";
        String usernameDB = "root";
        String passwordDB = "1234";
        
        String id = request.getParameter("id");
        String pwd = request.getParameter("pwd");
        String name = request.getParameter("name");
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection(url, usernameDB, passwordDB);
            
            //아이디 중복 체크
            String checkSql = "SELECT * FROM user WHERE id=?";
            pstmt = conn.prepareStatement(checkSql);
            pstmt.setString(1, id);
            ResultSet rs = pstmt.executeQuery();
            
            if(rs.next()) {
                //이미 존재하는 아이디인 경우
                out.println("<script>showAlert('이미 존재하는 아이디입니다.');</script>");
         	   out.println("<script>redirectToJoin();</script>");
               } else {
                //존재하지 않는 아이디인 경우 데이터베이스에 저장
                String insertSql = "INSERT INTO user (id, pwd, name) VALUES (?, ?, ?)";
                pstmt = conn.prepareStatement(insertSql);
                pstmt.setString(1, id);
                pstmt.setString(2, pwd);
                pstmt.setString(3, name);
                pstmt.executeUpdate();
                
               out.println("<script>showAlert('회원가입이 완료되었습니다.');</script>");
         	   out.println("<script>Login();</script>");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if(pstmt != null) pstmt.close();
            if(conn != null) conn.close();
        }
    %>
</body>
</html>
