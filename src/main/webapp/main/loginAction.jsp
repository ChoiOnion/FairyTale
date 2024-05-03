<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login Result</title>
     <script>
        function showAlert(message) {
            alert(message);
        }
        
        function redirectToLogin() {
            window.location.href = "login.jsp";
        }
        
        function Login() {
            window.location.href = "main.jsp";
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
        String username = "";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection(url, usernameDB, passwordDB);
            
            String sql = "SELECT * FROM user WHERE id=? AND pwd=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, id);
            pstmt.setString(2, pwd);
            rs = pstmt.executeQuery();
            //입력된 아이디와 비밀번호가 데이터베이스에 있는지 확인
            if(rs.next()) {
                HttpSession userSession  = request.getSession();
                userSession .setAttribute("id", id);
                
                username = rs.getString("name");
                userSession.setAttribute("username", username);
                
         	   out.println("<script>Login();</script>");
            } else {
                //로그인 실패 메시지 출력
            	   out.println("<script>showAlert('로그인에 실패하였습니다. 아이디와 비밀번호를 확인해 주세요.');</script>");
            	   out.println("<script>redirectToLogin();</script>");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if(rs != null) rs.close();
            if(pstmt != null) pstmt.close();
            if(conn != null) conn.close();
        }
    %>
</body>
</html>
