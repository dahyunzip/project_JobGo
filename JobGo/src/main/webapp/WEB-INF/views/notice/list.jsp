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
<div style="width:80%; margin:40px auto;">
	<h2 style="margin-bottom:20px;">공지사항</h2>
	
	<c:if test="${sessionScope.membertype eq 'A'}">
		<div style="text-align:right; margin-bottom:15px;">
			<a href="${pageContext.request.contextPath}/notice/write"
			   style="display:inline-block; padding:8px 16px; background:#007bff; color:white;
			          border-radius:4px; text-decoration:none;">
				공지 작성
			</a>
		</div>
	</c:if>
	
	<form method="get" action="list" style="margin-bottom:20px;">
		<input type="text" name="search" value="${search}" placeholder="검색어 입력" />
		<button type="submit">검색</button>
	</form>

	<table border="1" cellspacing="0" cellpadding="8" style="width:100%;">
		<thead style="background:#f3f3f3;">
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>작성일</th>
				<th>조회수</th>
			</tr>
		</thead>

		<tbody>
			<c:if test="${empty noticeList}">
				<tr><td colspan="4" style="text-align:center;">등록된 공지가 없습니다.</td></tr>
			</c:if>
		
			<c:forEach var="notice" items="${noticeList}" varStatus="status">
				<tr>
					<td>
						${pageVO.totalCount - ((pageVO.cri.page - 1) * pageVO.cri.pageSize) - status.index}
					</td>
					<td>
						<a href="${pageContext.request.contextPath}/notice/detail?noticeId=${notice.noticeId}">
							${notice.noticeTitle}
						</a>
					</td>
					<td><fmt:formatDate value="${notice.noticeRegdate}" pattern="yyyy-MM-dd"/></td>
					<td>${notice.noticeViewCnt}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>

	<!-- 페이징 영역 -->
	<div style="margin-top:20px; text-align:center;">
		<c:if test="${pageVO.prev}">
			<a href="?page=${pageVO.startPage - 1}&search=${search}" style="margin:0 4px;">이전</a>
		</c:if>

		<c:forEach var="num" begin="${pageVO.startPage}" end="${pageVO.endPage}">
			<a href="?page=${num}&search=${search}" 
		    	style="margin:0 3px; ${num == pageVO.cri.page ? 'font-weight:bold; color:red;' : ''}">
				${num}
			</a>
		</c:forEach>

		<c:if test="${pageVO.next}">
			<a href="?page=${pageVO.endPage + 1}&search=${search}" style="margin:0 4px;">다음</a>
		</c:if>
	</div>
</div>
</body>
<%@ include file="../include/Footer.jsp"%>
</html>