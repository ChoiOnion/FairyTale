<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true"%>
<%
    String userInput = request.getParameter("userInput");
    String engWord = (String) session.getAttribute("engWord");
    String message = "";

    if (userInput != null && engWord != null) {
        if (userInput.trim().equalsIgnoreCase(engWord)) {
            int score = session.getAttribute("score") != null ? (Integer) session.getAttribute("score") : 0;
            score++;
            session.setAttribute("score", score);
            message = "정답이에요!";
        } else {
            message = "틀렸어요! 답은 <span style=\"color: #026873;\">" + engWord + "</span>입니다.";
        }
    } else {
        message = "Error";
    }

    // 결과 메시지 출력
    out.print(message);
%>
