<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<%@ include file="../include/Header.jsp"%>
<head>
<meta charset="UTF-8">
<title>리뷰 상세</title>
</head>
<body>
<p>세션 userid: ${sessionScope.userid}</p>
<p>세션 id: ${sessionScope.id}</p>
<p>리뷰 작성자: ${reviewDetail.memberId}</p>
	<h2>리뷰 상세</h2>
	
	<div>
		<div>리뷰 번호: ${reviewDetail.reviewId }</div>
		<div>회원 ID: ${reviewDetail.memberId }</div>
		<div>기업 ID: ${reviewDetail.corpId }</div>
		<div>직무 코드: ${reviewDetail.jobCode }</div>
		<div>근무 기간: 
    		<c:choose>
    		    <c:when test="${reviewDetail.workMonths == 'A'}">1개월 미만</c:when>
    	    	<c:when test="${reviewDetail.workMonths == 'B'}">1~3개월</c:when>
   	    		<c:when test="${reviewDetail.workMonths == 'C'}">3~6개월</c:when>
        		<c:when test="${reviewDetail.workMonths == 'D'}">6~12개월</c:when>
        		<c:when test="${reviewDetail.workMonths == 'E'}">1~2년</c:when>
        		<c:when test="${reviewDetail.workMonths == 'F'}">2~3년</c:when>
        		<c:when test="${reviewDetail.workMonths == 'G'}">3~5년</c:when>
        		<c:when test="${reviewDetail.workMonths == 'H'}">5년 이상</c:when>
        		<c:otherwise>미정</c:otherwise>
    		</c:choose>
		</div>
		<div>내용: ${reviewDetail.revContent }</div>
		<div>별점: 
    		<c:forEach begin="1" end="5" var="i">
				<c:choose>
					<c:when test="${i <= reviewDetail.revRate}">★</c:when>
					<c:otherwise>☆</c:otherwise>
				</c:choose>
			</c:forEach>
		</div>
		<div>장점: ${reviewDetail.revPros }</div>
		<div>단점: ${reviewDetail.revCons }</div>
		<div>공개 여부: ${reviewDetail.revPublic }</div>
		<div>작성 일자: ${reviewDetail.revRegdate }</div>
		<div>수정 일자: ${reviewDetail.revUpdatedate }</div>
	</div>
	<hr>
		<div style="margin-top:15px;">
			<c:if test="${param.origin eq 'member'}">
    			<button type="button"
    			    onclick="location.href='${pageContext.request.contextPath}/review/memberReviewList?memberId=${param.memberId}'">
    			    회원별 리뷰 목록으로 돌아가기
    			</button>
			</c:if>

			<c:if test="${param.origin eq 'corp'}">
    			<button type="button"
        			onclick="location.href='${pageContext.request.contextPath}/review/corpReviewList?corpId=${param.corpId}'">
        			기업별 리뷰 목록으로 돌아가기
    			</button>
			</c:if>

			<!-- 기본: 전체 목록 -->
			<button type="button"
    			onclick="location.href='${pageContext.request.contextPath}/review/reviewList'">
    			전체 리뷰 목록으로 돌아가기
			</button>
		</div>
	<hr>
	<c:if test="${isOwner}">
		<div>
			<form action="${pageContext.request.contextPath}/review/updateReview" method="get" style="display:inline;">
				<input type="hidden" name="reviewId" value="${reviewDetail.reviewId}">
				<button type="submit">수정</button>
			</form>

			<form id="deleteForm" action="${pageContext.request.contextPath}/review/deleteReview" method="post" style="display:inline;">
				<input type="hidden" name="reviewId" value="${reviewDetail.reviewId}" />
				<button type="button" onclick="confirmDelete()">삭제</button>
			</form>
		</div>
	</c:if>
	<script>
		function confirmDelete() {
   			if (confirm("정말 이 리뷰를 삭제하시겠습니까?")) {
        		document.getElementById("deleteForm").submit();
    		} else {
        		alert("삭제가 취소되었습니다.");
    		}
		}
	</script>

</body>
<%@ include file="../include/Footer.jsp"%>
</html>