<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../include/Header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원별 리뷰 조회</title>
</head>
<body>
	<h2>회원별 리뷰 목록</h2>
    
    <c:if test="${empty memberReviewList}">
        <div>등록한 리뷰가 없습니다.</div>
    </c:if>
    
    <c:forEach var="review" items="${memberReviewList}">
		<div style="border:1px solid #ccc; padding:10px; margin-bottom:10px;">
			<div>
				<button type="button"
					onclick="location.href='${pageContext.request.contextPath}/review/reviewDetail?review_id=${review.review_id}&origin=member&member_id=${member_id}'">
					${review.rev_title}
				</button>
			</div>

			<div>
				<label>별점: </label>
				<c:forEach begin="1" end="${review.rev_rate}" var="i">★</c:forEach>
				<c:forEach begin="1" end="${5 - review.rev_rate}" var="i">☆</c:forEach>
				<span style="margin-left:10px;">작성일: ${review.rev_regdate}</span>
			</div>

			<div>기업 ID: ${review.corp_id}</div>
		</div>
	</c:forEach>

	<div style="margin-top:15px;">
		<button type="button" onclick="location.href='${pageContext.request.contextPath}/review/reviewList'">
			전체 리뷰 목록으로 돌아가기
		</button>
	</div>

</body>
</html>
<%@ include file="../include/Footer.jsp"%>