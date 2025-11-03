<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title> 공지 수정 </title>
</head>
<body>
<%@ include file="../include/Header.jsp"%>
	<h2> 공지 수정 </h2>
	
	<form action="/notice/edit" method="post">
		<input type="hidden" name="noticeId" value="${notice.noticeId }">
		제목 : <input type="text" name="noticeTitle" value="${notice.noticeTitle }"><br>
		내용 : <br>
		<textarea name="noticeContent" rows="8" cols="50">${notice.noticeContent}</textarea>
		<input type="submit" value="수정">
	</form>
	
	<a href="/notice/detail?noticeId=${notice.noticeId }">취소</a>
</body>
<%@ include file="../include/Footer.jsp"%>
</html>