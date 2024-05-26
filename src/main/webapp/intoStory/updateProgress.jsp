<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
String title = request.getParameter("title");
String id = request.getParameter("id");

try {
    Class.forName("com.mysql.jdbc.Driver");
    Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/fairytale", "root", "1234");
    PreparedStatement psmt = connection.prepareStatement("UPDATE fairytale_user SET progress = progress + 1 WHERE id = ? AND title = ?");
    psmt.setString(1, id);
    psmt.setString(2, title);
    psmt.executeUpdate();
    psmt.close();
    connection.close();
} catch (Exception e) {
    e.printStackTrace();
}
%>
