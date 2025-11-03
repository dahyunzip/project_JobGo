<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title> 공지 목록 </title>
</head>
<body>
<%@ include file="../include/Header.jsp"%>
	<c:if test="${sessionScope.membertype eq 'A'}">
		<a href="${pageContext.request.contextPath}/notice/write">글쓰기</a>
	</c:if>
	<br>
	
	<table border="1" width="600">
		<tr>
			<th>공지 번호</th>
			<th>공지 제목</th>
			<th>작성일</th>
			<th>조회수</th>
		</tr>
		
		<c:forEach var="notice" items="${noticeList }">
			<tr>
				<td>${notice.noticeId }</td>
				<td>
					<a href="/notice/detail?noticeId=${notice.noticeId }">
						${notice.noticeTitle }
					</a>
				</td>
				<td>${notice.noticeRegdate }</td>
				<td>${notice.noticeViewCnt }</td>
			</tr>
		</c:forEach>
	</table>
	
</body>
<%@ include file="../include/Footer.jsp"%>
</html>