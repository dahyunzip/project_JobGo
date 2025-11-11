<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 목록</title>
</head>
<%@ include file="../include/Header.jsp"%>
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
        	</tr>
    	</thead>
    	<tbody>
    		
    		<!-- 리뷰 없을 때 표시 -->
			<c:if test="${empty reviewList}">
				<tr>
					<td colspan="5">등록된 리뷰가 없습니다.</td>
				</tr>
			</c:if>
    	
    	    <c:forEach var="review" items="${reviewList}">
    	        <tr>
    	            <td>${review.reviewId}</td>
    	            <td>
    	            	<a href="${pageContext.request.contextPath}/review/reviewDetail?reviewId=${review.reviewId}">${review.revTitle}</a>
    	            	<!-- <input type="hidden" name="reviewId" value="${reviewDetail.reviewId}">-->
    	            </td>
    	            <td>${review.memberId}</td>
    	            <td>
    	                <c:forEach begin="1" end="5" var="i">
							<c:choose>
								<c:when test="${i <= review.revRate}">★</c:when>
								<c:otherwise>☆</c:otherwise>
							</c:choose>
						</c:forEach>
    	            </td>
    	            <td>${review.revRegdate}</td>
            	</tr>
        	</c:forEach>
    	</tbody>
	</table>
	
	<c:if test="${not empty sessionScope.userid}">
		<button type="button" onclick="location.href='${pageContext.request.contextPath}/review/insertReview'">
			리뷰 작성
		</button>
	</c:if>
	<c:if test="${empty sessionScope.userid}">
		<p>로그인 후 리뷰를 작성할 수 있습니다.</p>
	</c:if>
	
	
	

</body>
<%@ include file="../include/Footer.jsp"%>
</html>