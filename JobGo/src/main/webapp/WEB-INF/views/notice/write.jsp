<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지 작성</title>
</head>
<body>
<%@ include file="../include/Header.jsp"%>
	<h2> 공지 작성 </h2>
	
	<form action="/notice/write" method="post">
		제목 : <input type="text" name="noticeTitle"><br>
		내용 : <br>
		<textarea name="noticeContent" rows="8" cols="50"></textarea>
		<input type="submit" value="등록">
	</form>
	
</body>
<%@ include file="../include/Footer.jsp"%>
</html>