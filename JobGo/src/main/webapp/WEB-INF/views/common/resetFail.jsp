<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 재설정 실패 | JobGo</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" />
<style>
body { background:#f8f9fa; font-family:'Noto Sans KR'; }
.container { max-width:400px; margin-top:100px; background:white; padding:40px; border-radius:10px; box-shadow:0 2px 8px rgba(0,0,0,0.1);}
.btn { width:100%; margin-top:15px; }
p.msg { color:#555; margin-top:20px; }
</style>
</head>
<body>
<div class="container text-center">
    <h3>비밀번호 재설정 실패</h3>
    <p class="msg">${msg}</p>

    <c:choose>
        <c:when test="${userType eq 'corp'}">
            <a href="${pageContext.request.contextPath}/corp/findPw" class="btn btn-primary mt-3">
                다시 시도하기
            </a>
        </c:when>
        <c:otherwise>
            <a href="${pageContext.request.contextPath}/member/findPw" class="btn btn-primary mt-3">
                다시 시도하기
            </a>
        </c:otherwise>
    </c:choose>

    <div class="mt-3">
        <c:choose>
            <c:when test="${userType eq 'corp'}">
                <a href="${pageContext.request.contextPath}/corp/login">로그인으로 돌아가기</a>
            </c:when>
            <c:otherwise>
                <a href="${pageContext.request.contextPath}/member/login">로그인으로 돌아가기</a>
            </c:otherwise>
        </c:choose>
    </div>
</div>
</body>
</html>
