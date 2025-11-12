<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>/gpt/startGPT.jsp</h1>
	<fieldset>
		<form action="/sendAsk" method="post">
		    <textarea rows="5" cols="50" name="prompt" placeholder="자기소개 문항을 입력하세요."></textarea><br>
		    <input type="submit" value="GPT에게 첨삭 받기">
		</form>
		
		<c:if test="${not empty result}">
		    <hr>
		    <h3>GPT 첨삭 결과</h3>
		    <p><strong>질문:</strong> ${prompt}</p>
		    <p><strong>답변:</strong> ${result}</p>
		</c:if>
	</fieldset>
	
</body>
</html>