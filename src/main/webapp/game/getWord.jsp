<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true"%>
<%@ page import="java.sql.*, java.util.*, javax.servlet.http.*" %>
<%
    String url = "jdbc:mysql://localhost:3306/fairytale";
    String usernameDB = "root";
    String passwordDB = "1234";

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    String engWord = "";
    String korWord = "";

    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection(url, usernameDB, passwordDB);

        String sql = "SELECT * FROM word ORDER BY RAND() LIMIT 1";
        pstmt = conn.prepareStatement(sql);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            engWord = rs.getString("eng");
            korWord = rs.getString("kor");
        }

        // 영어 단어와 한국어 번역을 세션에 저장
        HttpSession wordSession = request.getSession();
        session.setAttribute("engWord", engWord);
        session.setAttribute("korWord", korWord);

        // 한국어 단어 출력
        out.print(korWord);
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) rs.close();
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    }
%>
