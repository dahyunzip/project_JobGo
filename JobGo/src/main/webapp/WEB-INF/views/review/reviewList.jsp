<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 목록</title>
</head>
<body>
	
	<h2>리뷰 목록</h2>
	
	<c:forEach var="review" items="${reviewList }">
		<div>
			<div>제목: ${review.rev_title }</div>
			<div>작성자: ${review.member_id }</div>
			<div>별점: 
				<c:forEach begin="1" end="${review.rev_rate }" var="i">
					★
				</c:forEach>
				<c:forEach begin="1" end="${5 - review.rev_rate }" var="i">
					☆
				</c:forEach>
			</div>
			<div>작성일: ${review.rev_regdate }</div>
			<div><a href="reviewDetail?review_id=${review.review_id }">상세보기</a></div>
			<hr>
		</div>
	</c:forEach>
	
	<a href="insertReview.jsp">리뷰 작성</a>
	

</body>
</html>