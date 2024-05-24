<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true"%>
<%@ page import="java.sql.*, java.util.*, javax.servlet.http.*" %>
<%
    String url = "jdbc:mysql://localhost:3306/fairytale";
    String usernameDB = "root";
    String passwordDB = "1234";

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    String blank = "";
    String meaning = "";
    String answer = "";
    String proverb = "";

    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection(url, usernameDB, passwordDB);

        String sql = "SELECT * FROM proverb ORDER BY RAND() LIMIT 1";
        pstmt = conn.prepareStatement(sql);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            blank = rs.getString("proverb");
            meaning = rs.getString("meaning");
            answer = rs.getString("answer");
            proverb = rs.getString("sentence");
        }

        // 세션에 저장
        HttpSession proverbSession = request.getSession();
        session.setAttribute("blank", blank);
        session.setAttribute("meaning", meaning);
        session.setAttribute("answer", answer);
        session.setAttribute("proverb", proverb);

        out.print(blank);
        out.print("<br>");
        out.print(meaning);
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) rs.close();
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    }
%>
