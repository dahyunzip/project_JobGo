<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
        <div style="border:1px solid #ccc; padding:5px; margin-bottom:5px;">
            <div>
                <button type="button" onclick="location.href='/review/reviewDetail?review_id=${review.review_id}'">
                    ${review.rev_title}
                </button>
            </div>
            <div>별점: ${review.rev_rate} / 작성일: ${review.rev_regdate}</div>
        </div>
    </c:forEach>

</body>
</html>