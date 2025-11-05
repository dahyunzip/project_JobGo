<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지 상세 보기</title>
</head>
<body>
<%@ include file="../include/Header.jsp"%>
<div style="width:80%; margin:40px auto;">
	<p style="color:red;">DEBUG storedFileName = [${notice.storedFileName}]</p>

	<p style="font-size:22px; font-weight:700; margin-bottom:25px; color:#222;">공지 상세 보기</p>

	<h2 style="margin-bottom:15px; padding-left:10px; border-left:4px solid #007bff; font-size:22px; font-weight:600; color:#222;">
		${notice.noticeTitle }
	</h2>
	
	<p style="font-weight:600; margin-bottom:6px;">내용</p>
	<div style="
		border: 1px solid #ddd;
		padding: 14px;
		width: 100%;
		min-height: 250px;
		background-color: #fafafa;
		white-space: pre-wrap;
		overflow-y: auto;
		font-size: 15px;
		line-height: 1.6;
		border-radius: 6px;
		color:#333;
	">${fn:escapeXml(notice.noticeContent)}</div>
	
	<div style="font-size:14px; color:#666; margin-top:12px; margin-bottom:15px;">
		<p style="margin:4px 0;">
			<b>작성일:</b>
    		<fmt:formatDate value="${notice.noticeRegdate}" pattern="yyyy-MM-dd"/>
		</p>
	
		<p style="margin:4px 0;">
			<b>조회수:</b> ${notice.noticeViewCnt }
		</p>
	</div>

	<c:if test="${fn:length(fn:trim(notice.storedFileName)) > 0}">
		<p style="font-weight:600; margin-bottom:6px;">첨부파일</p>
		<c:forEach var="file" items="${fn:split(fn:trim(notice.storedFileName), ',')}">
			<a href="${pageContext.request.contextPath}/resources/upload/${file}" download
			   style="color:#007bff; text-decoration:none; font-size:14px; display:inline-block; margin-bottom:3px;">
				${file}
			</a><br>
		</c:forEach>
	</c:if>
	
	<br>

	<c:if test="${sessionScope.membertype eq 'A' }">
		<form action="/notice/edit" method="get" style="display:inline-block; margin-right:6px;">
			<input type="hidden" name="noticeId" value="${notice.noticeId}">
			<input type="submit" value="수정" 
			style="padding:8px 14px; background:#ffc107; border:none; border-radius:4px; cursor:pointer; font-weight:600;">
		</form>
		
		<form action="/notice/delete" method="post" style="display:inline-block; margin-right:6px;">
			<input type="hidden" name="noticeId" value="${notice.noticeId}">
			<input type="submit" value="삭제"
			style="padding:8px 14px; background:#dc3545; border:none; color:#fff; border-radius:4px; cursor:pointer; font-weight:600;">
		</form>
	</c:if>
	
	<button onclick="location.href='/notice/list'"
		style="padding:8px 14px; background:#6c757d; border:none; border-radius:4px; cursor:pointer; color:#fff; font-weight:600;">
		목록으로
	</button>
</div>
</body>
<%@ include file="../include/Footer.jsp"%>
</html>