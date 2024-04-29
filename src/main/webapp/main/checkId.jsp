<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    String url = "jdbc:mysql://localhost:3306/fairytale";
    String usernameDB = "root";
    String passwordDB = "1234";
    
    String id = request.getParameter("id");
    
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    
    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection(url, usernameDB, passwordDB);
        
        //아이디 중복 체크
        String checkSql = "SELECT * FROM user WHERE id=?";
        pstmt = conn.prepareStatement(checkSql);
        pstmt.setString(1, id);
        rs = pstmt.executeQuery();
        
        if(rs.next()) {
            out.println("exists");
        } else {
            out.println("not_exists");
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if(rs != null) rs.close();
        if(pstmt != null) pstmt.close();
        if(conn != null) conn.close();
    }
%>
