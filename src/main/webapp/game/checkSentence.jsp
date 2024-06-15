<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true"%>
<%
    String userInput = request.getParameter("userInput");
    String answer = (String) session.getAttribute("sentence");
    String sentenceKor = (String) session.getAttribute("sentenceKor");
    String message = "";
    boolean a = false;

    if (userInput != null && answer != null) {
        if (userInput.trim().equalsIgnoreCase(answer)) {
            int score = session.getAttribute("score") != null ? (Integer) session.getAttribute("score") : 0;
            score++;
            session.setAttribute("score", score);
            message = "정답이에요!";
            a=true;
        } else {
            message = "틀렸어요!";
            a=false;
        }
    } else {
        message = "Error";
    }

    out.print(message);
    if(a==false){
    out.print("<br>");
    out.print("<br>");
    out.print("<span style=\"color: #026873;\">" + answer);
    out.print("<br>");
    out.print("<span style=\"color: black;\">" +sentenceKor);
    out.print("<br>");
    out.print("<br>");
    out.print("입력 내용: " +userInput);
    }
    
%>
