<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title> 공지 목록 </title>
</head>
<body>
<%@ include file="../include/Header.jsp"%>
<div class="container">
	<h2>공지사항 게시판</h2>

	<div class="card">
		<div class="card-header">
			<h3>공지 목록</h3>
			<c:if test="${sessionScope.membertype eq 'A'}">
				<button type="button" onclick="location.href='${pageContext.request.contextPath}/notice/write'">
					글쓰기
				</button>
			</c:if>
		</div>

		<div class="card-body">
			<!-- 페이지 설정 -->
			<c:set var="pageSize" value="10"/>
			<c:set var="page" value="${param.page != null ? param.page : 1}"/>
			<c:set var="start" value="${(page - 1) * pageSize}"/>
			<c:set var="end" value="${start + pageSize}"/>
			
			<c:set var="visibleNotices" value="${0}"/>
			<table border="1" width="100%" cellspacing="0" cellpadding="8">
				<thead>
					<tr>
						<th>번호</th>
						<th>제목</th>
						<th>작성일</th>
						<th>조회수</th>
					</tr>
				</thead>
				<tbody>
					<c:set var="displayNum" value="${fn:length(noticeList) + 1}" />
					
					<c:forEach var="notice" items="${noticeList}">
						<c:set var="isCorpNotice" value="${fn:contains(notice.noticeTitle, '[기업공지]')}"/>
						<c:if test="${!isCorpNotice or (sessionScope.membertype eq 'A' or sessionScope.userType eq 'corp')}">
							<c:set var="displayNum" value="${displayNum - 1}" />
								<tr>
									<td align="center">${displayNum}</td>
									<td>
										<a href="${pageContext.request.contextPath}/notice/detail?noticeId=${notice.noticeId}">
											${notice.noticeTitle}
										</a>
									</td>
									<td align="center">
										<fmt:formatDate value="${notice.noticeRegdate}" pattern="yyyy-MM-dd"/>
									</td>
									<td align="center">${notice.noticeViewCnt}</td>
								</tr>
						</c:if>
					</c:forEach>
				</tbody>
			</table>

			<!-- 페이지 네비게이션 -->
			<div style="margin-top:20px; text-align:center;">
				<c:set var="totalPages" value="${(visibleNotices + pageSize - 1) / pageSize}" />

				<c:if test="${totalPages > 1}">
					<ul style="list-style:none; display:inline-flex; gap:8px; padding:0;">
			
						<!-- 이전 버튼 -->
						<c:choose>
							<c:when test="${currentPage > 1}">
								<li>
									<a href="?page=${currentPage - 1}" style="text-decoration:none;">&lt;</a>
								</li>
							</c:when>
							<c:otherwise>
								<li style="color:#aaa;">&lt;</li>
							</c:otherwise>
						</c:choose>

						<!-- 페이지 번호 -->
						<c:forEach var="i" begin="1" end="${totalPages}">
							<c:choose>
								<c:when test="${i eq currentPage}">
									<li style="font-weight:bold;">[${i}]</li>
								</c:when>
								<c:otherwise>
									<li>
										<a href="?page=${i}" style="text-decoration:none;">${i}</a>
									</li>
								</c:otherwise>
							</c:choose>
						</c:forEach>
	
						<!-- 다음 버튼 -->
						<c:choose>
							<c:when test="${currentPage < totalPages}">
								<li>
									<a href="?page=${currentPage + 1}" style="text-decoration:none;">&gt;</a>
								</li>
							</c:when>
							<c:otherwise>
								<li style="color:#aaa;">&gt;</li>
							</c:otherwise>
						</c:choose>
	
					</ul>
				</c:if>
			</div>
		</div>
	</div>
</div>
</body>
<%@ include file="../include/Footer.jsp"%>
</html>