<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원별 리뷰 조회</title>
</head>
<body>
<%@ include file="../include/Header.jsp"%>
	<h2>회원별 리뷰 목록</h2>
	
	<form method="get" action="${pageContext.request.contextPath}/review/memberReviewList">
		<input type="hidden" name="memberId" value="${memberId}">
		<input type="text" name="search" value="${param.search}" placeholder="검색어 입력">
		<button type="submit">검색</button>
	</form>
    
    <c:if test="${empty reviewList}">
        <div>등록한 리뷰가 없습니다.</div>
    </c:if>
    
    <c:set var="rowNum" value="${pageVO.totalCount - ((pageVO.cri.page - 1) * pageVO.cri.pageSize)}" />
    
    <c:forEach var="review" items="${reviewList}">
		<div style="border:1px solid #ccc; padding:10px; margin-bottom:10px;">
			
			<div><strong>번호: ${rowNum}</strong></div>
        	<c:set var="rowNum" value="${rowNum - 1}" />
			
			<div>
				<button type="button"
					onclick="location.href='${pageContext.request.contextPath}/review/reviewDetail?reviewId=${review.reviewId}&origin=member&memberId=${memberId}'">
					${review.revTitle}
				</button>
			</div>

			<div>
				<label>별점: </label>
				<c:forEach begin="1" end="${review.revRate}" var="i">★</c:forEach>
				<c:forEach begin="1" end="${5 - review.revRate}" var="i">☆</c:forEach>
				<span style="margin-left:10px;">
    				작성일: <fmt:formatDate value="${review.revRegdate}" pattern="yyyy-MM-dd HH:mm"/>
				</span>
				<span style="margin-left:10px;">조회수: ${review.revViewcnt}</span>
			</div>

			<div>기업 ID: ${review.corpId}</div>
		</div>
	</c:forEach>
	
	<div class="pagination" style="text-align:center; margin-top:20px;">
		<c:if test="${pageVO.prev}">
			<a href="?page=${pageVO.startPage - 1}&memberId=${memberId}">이전</a>
		</c:if>

		<c:forEach var="num" begin="${pageVO.startPage}" end="${pageVO.endPage}">
			<c:choose>
				<c:when test="${pageVO.cri.page == num}">
            		<strong>[${num}]</strong>
        		</c:when>
        		<c:otherwise>
            		<a href="?page=${num}&memberId=${memberId}">${num}</a>
				</c:otherwise>
			</c:choose>
		</c:forEach>
	
		<c:if test="${pageVO.next}">
			<a href="?page=${pageVO.endPage + 1}&memberId=${memberId}">다음</a>
		</c:if>
	</div>

	<div style="margin-top:15px;">
		<button type="button" onclick="location.href='${pageContext.request.contextPath}/review/reviewList'">
			전체 리뷰 목록으로 돌아가기
		</button>
	</div>

</body>
<%@ include file="../include/Footer.jsp"%>
</html>