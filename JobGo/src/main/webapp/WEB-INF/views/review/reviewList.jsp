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
	
	<table border="1">
    	<thead>
        	<tr>
        	    <th>리뷰 번호</th>
        	    <th>제목</th>
        	    <th>작성자</th>
        	    <th>별점</th>
        	    <th>작성일</th>
        	    <th>수정/삭제</th>
        	</tr>
    	</thead>
    	<tbody>
    	    <c:forEach var="review" items="${reviewList}">
    	        <tr>
    	            <td>${review.review_id}</td>
    	            <td>
    	            	<a href="/review/reviewDetail?review_id=${review.review_id}">${review.rev_title}</a>
    	            </td>
    	            <td>${review.member_id}</td>
    	            <td>
    	                <c:forEach begin="1" end="${review.rev_rate}" var="i">★</c:forEach>
    	                <c:forEach begin="1" end="${5 - review.rev_rate}" var="i">☆</c:forEach>
    	            </td>
    	            <td>${review.rev_regdate}</td>
    	            <td>
     	            	<button type="button" onclick="location.href='/review/updateReview?review_id=${review.review_id}'">수정</button>
      	            	<form action="/review/deleteReview" method="post" style="display:inline;">
                        	<input type="hidden" name="review_id" value="${review.review_id}">
                        	<button type="submit">삭제</button>
                    	</form>
                	</td>
            	</tr>
        	</c:forEach>
    	</tbody>
	</table>
	<button type="button" onclick="location.href='/review/insertReview'">
    리뷰 작성
	</button>
	<a href="/review/memberReviewList?member_id=${review.member_id}">회원 리뷰 보기</a>
	<a href="/review/corpReviewList?corp_id=${review.corp_id}">기업 리뷰 보기</a>
	

</body>
</html>
<%@ include file="../include/Footer.jsp"%>