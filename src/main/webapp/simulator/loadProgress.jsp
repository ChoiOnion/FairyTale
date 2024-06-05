<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
    String jdbcURL = "jdbc:mysql://localhost:3306/fairytale";
    String jdbcUsername = "root";
    String jdbcPassword = "1234";

    HttpSession userSession = request.getSession(false);
    if (userSession == null) {
        response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
        response.getWriter().write("{\"error\": \"Unauthorized: No session found.\"}");
        return;
    }

    String userId = (String) userSession.getAttribute("id");
    if (userId == null) {
        response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
        response.getWriter().write("{\"error\": \"Unauthorized: No user logged in.\"}");
        return;
    }

    Connection connection = null;
    PreparedStatement preparedStatement = null;
    ResultSet resultSet = null;
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);

        String sql = "SELECT progress, friendship FROM story_user WHERE id = ?";
        preparedStatement = connection.prepareStatement(sql);
        preparedStatement.setString(1, userId);
        resultSet = preparedStatement.executeQuery();
        
        
        if (resultSet.next()) {
            String storyProgress = resultSet.getString("progress");
            int storyFriendship = resultSet.getInt("friendship");

            response.setStatus(HttpServletResponse.SC_OK);
            response.getWriter().write("{\"progress\": \"" + storyProgress + "\", \"friendship\": " + storyFriendship + "}");
        } else {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\": \"Failed to load progress.\"}");
        }
    } catch (Exception e) {
        e.printStackTrace();
        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        response.getWriter().write("{\"error\": \"" + e.getMessage() + "\"}");
    } finally {
        if (resultSet != null) {
            try {
                resultSet.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        if (preparedStatement != null) {
            try {
                preparedStatement.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        if (connection != null) {
            try {
                connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
%>
