<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기 | JobGo</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" />
<style>
body { background:#f8f9fa; font-family:'Noto Sans KR'; }
.container { max-width:400px; margin-top:100px; background:white; padding:40px; border-radius:10px; box-shadow:0 2px 8px rgba(0,0,0,0.1);}
.btn { width:100%; margin-top:15px; }
p.msg { color:red; text-align:center; }
</style>
</head>
<body>
<div class="container">
	<c:choose>
		<c:when test="${userType eq 'general'}">
			<h2>일반회원 아이디 찾기</h2>
			<form action="/member/findId" method="post">
				<div class="form-group mb-3">
		            <label>가입 시 이메일</label>
		            <input type="email" class="form-control" name="email" placeholder="example@jobgo.com" required />
		        </div>
		        <button type="submit" class="btn btn-primary">아이디 찾기</button>
			</form>
			<div class="text-center mt-3">
		        <a href="${pageContext.request.contextPath}/member/login">로그인으로 돌아가기</a>
		    </div>
		</c:when>

		<c:when test="${userType eq 'corp'}">
			<h2>기업회원 아이디 찾기</h2>
			<form action="/corp/findId" method="post">
				<div class="form-group mb-3">
		            <label>가입 시 이메일</label>
		            <input type="email" class="form-control" name="managerEmail" placeholder="example@jobgo.com" required />
		        </div>
		        <button type="submit" class="btn btn-primary">아이디 찾기</button>
			</form>
			<div class="text-center mt-3">
		        <a href="${pageContext.request.contextPath}/corp/login">로그인으로 돌아가기</a>
		    </div>
		</c:when>
	</c:choose>

    <c:if test="${not empty msg}">
        <p class="msg">${msg}</p>
    </c:if>
    
</div>
</body>
</html>