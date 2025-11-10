<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@ include file="../include/Header.jsp"%>
<h2>기업별 리뷰 목록</h2>
    
    <c:if test="${empty corpReviewList}">
        <div>등록된 리뷰가 없습니다.</div>
    </c:if>
    
    <c:forEach var="review" items="${corpReviewList}">
        <div style="border:1px solid #ccc; padding:10px; margin-bottom:10px;">
            <div>
                <button type="button"
					onclick="location.href='${pageContext.request.contextPath}/review/reviewDetail?reviewId=${review.reviewId}&origin=corp&corpId=${corpId}'">
					${review.revTitle}
				</button>
            </div>
            <div>
                <label>별점: </label>
                <c:forEach begin="1" end="${review.revRate}" var="i">★</c:forEach>
                <c:forEach begin="1" end="${5 - review.revRate}" var="i">☆</c:forEach>
                <span style="margin-left:10px;">작성일: ${review.revRegdate}</span>
            </div>
            <div>작성자 ID: ${review.memberId}</div>
        </div>
    </c:forEach>

    <div style="margin-top:15px;">
        <button type="button" onclick="location.href='${pageContext.request.contextPath}/review/reviewList'">
            전체 리뷰 목록으로 돌아가기
        </button>
    </div>
    
</body>
<%@ include file="../include/Footer.jsp"%>
</html>