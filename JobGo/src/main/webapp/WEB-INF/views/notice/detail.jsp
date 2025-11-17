<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../include/Header.jsp"%>
<section class="section">
	<div class="container">
		<h2 class="pageTitle">공지사항</h2>
		<div class="boardHeader">
			<h2>${notice.noticeTitle }</h2>
			<div>
				<p>
					<b>작성일:</b>
		    		<fmt:formatDate value="${notice.noticeRegdate}" pattern="yyyy-MM-dd"/>
				</p>
				<p style="margin:4px 0;">
					<b>조회수:</b> ${notice.noticeViewCnt }
				</p>
			</div>
		</div>
		<div class="boardBody">${fn:escapeXml(notice.noticeContent)}</div>
		<div class="boardFile">
			<c:if test="${notice.storedFileName != null && fn:length(fn:trim(notice.storedFileName)) > 0}">
				<p style="font-weight:600; margin-bottom:6px;">첨부파일</p>
				<c:forEach var="file" items="${fn:split(fn:trim(notice.storedFileName), ',')}">
					<a href="${pageContext.request.contextPath}/resources/upload/${file}" download
					   style="color:#007bff; text-decoration:none; font-size:14px; display:inline-block; margin-bottom:3px;">
						${file}
					</a><br>
				</c:forEach>
			</c:if>
		</div>
		<hr>
		<div class="button text-right">
			<c:if test="${sessionScope.membertype eq 'A'}">
				<form action="/notice/edit" method="get" style="display:inline-block; margin-right:6px;">
					<input type="hidden" name="noticeId" value="${notice.noticeId}">
					<input type="submit" value="수정" class="btn btn2">
				</form>
			
				<form action="/notice/delete" method="post" style="display:inline-block; margin-right:6px;">
					<input type="hidden" name="noticeId" value="${notice.noticeId}">
					<input type="submit" value="삭제" class="btn btn2" onclick="return confirm('삭제하시겠습니까?');">
				</form>
			</c:if>
			<button onclick="location.href='/notice/list'" class="btn btn2">
				목록으로
			</button>
		</div>
	</div>
</section>
<%@ include file="../include/Footer.jsp"%>