<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기 결과 | JobGo</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" />
<style>
body { background:#f8f9fa; font-family:'Noto Sans KR'; }
.container { max-width:400px; margin-top:100px; background:white; padding:40px; border-radius:10px; box-shadow:0 2px 8px rgba(0,0,0,0.1);}
h4 { color:#0064FF; }
</style>
</head>
<body>
<div class="container text-center">
	<h3>아이디 찾기 결과</h3>
	<p>회원님의 아이디는</p>
	<c:choose>
		<c:when test="${userType eq 'general'}">
			<h4><strong>${userid}</strong></h4>
			<a href="/member/login" class="btn btn-primary mt-3">로그인하러 가기</a>
		</c:when>
		
		<c:when test="${userType eq 'corp'}">
			<h4><strong>${corpUserId}</strong></h4>
			<a href="/corp/login" class="btn btn-primary mt-3">로그인하러 가기</a>
		</c:when>
	</c:choose>
</div>
</body>
</html>