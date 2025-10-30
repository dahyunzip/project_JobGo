<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../include/Header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 상세</title>
</head>
<body>
	<h2>리뷰 상세</h2>
	
	<div>
		<div>리뷰 번호: ${reviewDetail.review_id }</div>
		<div>회원 ID: ${reviewDetail.member_id }</div>
		<div>기업 ID: ${reviewDetail.corp_id }</div>
		<div>직무 코드: ${reviewDetail.job_code }</div>
		<div>근무 기간: 
    		<c:choose>
    		    <c:when test="${reviewDetail.work_months == 'A'}">1개월 미만</c:when>
    	    	<c:when test="${reviewDetail.work_months == 'B'}">1~3개월</c:when>
   	    		<c:when test="${reviewDetail.work_months == 'C'}">3~6개월</c:when>
        		<c:when test="${reviewDetail.work_months == 'D'}">6~12개월</c:when>
        		<c:when test="${reviewDetail.work_months == 'E'}">1~2년</c:when>
        		<c:when test="${reviewDetail.work_months == 'F'}">2~3년</c:when>
        		<c:when test="${reviewDetail.work_months == 'G'}">3~5년</c:when>
        		<c:when test="${reviewDetail.work_months == 'H'}">5년 이상</c:when>
        		<c:otherwise>미정</c:otherwise>
    		</c:choose>
		</div>
		<div>내용: ${reviewDetail.rev_content }</div>
		<div>별점: 
    		<c:forEach begin="1" end="5" var="i">
				<c:choose>
					<c:when test="${i <= reviewDetail.rev_rate}">★</c:when>
					<c:otherwise>☆</c:otherwise>
				</c:choose>
			</c:forEach>
		</div>
		<div>장점: ${reviewDetail.rev_pros }</div>
		<div>단점: ${reviewDetail.rev_cons }</div>
		<div>공개 여부: ${reviewDetail.rev_public }</div>
		<div>작성 일자: ${reviewDetail.rev_regdate }</div>
		<div>수정 일자: ${reviewDetail.rev_updatedate }</div>
	</div>
	<hr>
		<div style="margin-top:15px;">
			<c:choose>
				<c:when test="${param.origin eq 'member'}">
					<button type="button"
						onclick="location.href='${pageContext.request.contextPath}/review/memberReviewList?member_id=${param.member_id}'">
						회원별 리뷰 목록으로 돌아가기
					</button>
				</c:when>

				<c:when test="${param.origin eq 'corp'}">
					<button type="button"
						onclick="location.href='${pageContext.request.contextPath}/review/corpReviewList?corp_id=${param.corp_id}'">
						기업별 리뷰 목록으로 돌아가기
					</button>
				</c:when>

				<c:otherwise>
					<button type="button"
						onclick="location.href='${pageContext.request.contextPath}/review/reviewList'">
						전체 리뷰 목록으로 돌아가기
					</button>
				</c:otherwise>
			</c:choose>
		</div>
	<hr>
	<c:if test="${sessionScope.userid == reviewDetail.member_id}">
		<div>
			<form action="${pageContext.request.contextPath}/review/updateReview" method="get" style="display:inline;">
				<input type="hidden" name="review_id" value="${reviewDetail.review_id}">
				<button type="submit">수정</button>
			</form>

			<form id="deleteForm" action="${pageContext.request.contextPath}/review/deleteReview" method="post" style="display:inline;">
				<input type="hidden" name="review_id" value="${reviewDetail.review_id}" />
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
</html>
<%@ include file="../include/Footer.jsp"%>