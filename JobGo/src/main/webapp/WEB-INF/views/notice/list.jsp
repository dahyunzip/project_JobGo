<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title> 공지 목록 </title>
</head>
<body>
<%@ include file="../include/Header.jsp"%>
<div style="width:80%; margin:40px auto">
	<div style="display:flex; justify-content: space-between; align-items: center; margin-bottom: 20px;">
		<h2 style="margin:0;">공지사항</h2>
		<c:if test="${sessionScope.membertype eq 'A'}">
			<button type="button" onclick="location.href='${pageContext.request.contextPath}/notice/write'">
				글쓰기
			</button>
		</c:if>
	</div>
	
	<table style="width:100%; border-collapse:collapse; font-size:15px;">
		<tr style="background:#f5f5f5; border-bottom:2px solid #ccc;">
			<th style="padding:10px;">공지 번호</th>
			<th style="padding:10px;">공지 제목</th>
			<th style="padding:10px;">작성일</th>
			<th style="padding:10px;">조회수</th>
		</tr>
		
		<c:forEach var="notice" items="${noticeList }">
			<tr style="border-bottom:1px solid #ddd; cursor:pointer;">
				<td style="padding:10px; text-align:center;">${notice.noticeId }</td>
				<td style="padding:10px;">
					<button onclick="location.href='/notice/detail?noticeId=${notice.noticeId}'" 
        					style="background:none;border:none;color:blue;cursor:pointer;">
						${notice.noticeTitle}
					</button>
				</td>
				<td style="padding:10px; text-align:center;"><fmt:formatDate value="${notice.noticeRegdate}" pattern="yyyy-MM-dd"/></td>
				<td style="padding:10px; text-align:center;">${notice.noticeViewCnt }</td>
			</tr>
		</c:forEach>
	</table>
</div>
</body>
<%@ include file="../include/Footer.jsp"%>
</html>