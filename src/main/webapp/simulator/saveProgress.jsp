<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
    String jdbcURL = "jdbc:mysql://localhost:3306/fairytale";
    String jdbcUsername = "root";
    String jdbcPassword = "1234";

    HttpSession userSession = request.getSession(false);
    if (userSession == null) {
        response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
        response.getWriter().write("Unauthorized: No session found.");
        return;
    }

    String userId = (String) userSession.getAttribute("id");
    if (userId == null) {
        response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
        response.getWriter().write("Unauthorized: No user logged in.");
        return;
    }

    // Read the request parameters
    String storyProgress = request.getParameter("story_progress");
    String storyFriendshipParam = request.getParameter("story_friendship");

    // Debug logs for received parameters
    System.out.println("Received story_progress: " + storyProgress);
    System.out.println("Received story_friendship: " + storyFriendshipParam);

    if (storyProgress == null || storyFriendshipParam == null) {
        response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
        response.getWriter().write("Missing parameters.");
        return;
    }

    int storyFriendship = 0;

    try {
        storyFriendship = Integer.parseInt(storyFriendshipParam);
    } catch (NumberFormatException e) {
        response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
        response.getWriter().write("Invalid story_friendship parameter.");
        return;
    }

    Connection connection = null;
    PreparedStatement preparedStatement = null;
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);

        String sql = "UPDATE user SET story_progress = ?, story_friendship = ? WHERE id = ?";
        preparedStatement = connection.prepareStatement(sql);
        preparedStatement.setString(1, storyProgress);
        preparedStatement.setInt(2, storyFriendship);
        preparedStatement.setString(3, userId);
        int result = preparedStatement.executeUpdate();

        if (result > 0) {
            response.setStatus(HttpServletResponse.SC_OK);
            response.getWriter().write("Progress saved successfully.");
        } else {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("Failed to save progress.");
        }
    } catch (Exception e) {
        e.printStackTrace();
        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        response.getWriter().write("Error: " + e.getMessage());
    } finally {
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
