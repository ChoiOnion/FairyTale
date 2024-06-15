<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>

<%
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    String sentence = "";
    String kor = "";
    int sentenceId = 0;
    
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/fairytale", "root", "1234");

        String sql = "SELECT id, sentence, kor FROM sentence ORDER BY RAND() LIMIT 1";
        pstmt = conn.prepareStatement(sql);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            sentenceId = rs.getInt("id");
            sentence = rs.getString("sentence");
            kor = rs.getString("kor");
        }

        HttpSession sentenceSession = request.getSession();
        session.setAttribute("sentence", sentence);
        session.setAttribute("sentenceKor", kor);
        
        List<String> words = Arrays.asList(sentence.split(" "));
        Collections.shuffle(words);
        
        StringBuilder shuffledWords = new StringBuilder();
        for (String word : words) {
            shuffledWords.append("<span class='word' style='cursor: pointer; color: #026873; margin: 5px;'>" + word + "</span>");
        }
%>

<div>
    <p>단어를 올바르게 배열하세요:</p>
    <p><%= shuffledWords.toString() %></p>
    <p><%= kor %></p>
    <script>
        var currentSentenceId = <%= sentenceId %>;
    </script>
</div>

<%
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException e) {}
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) {}
        if (conn != null) try { conn.close(); } catch (SQLException e) {}
    }
%>
