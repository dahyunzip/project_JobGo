<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
    		<c:forEach begin="1" end="${reviewDetail.rev_rate}" var="i">★</c:forEach>
    		<c:forEach begin="1" end="${5 - reviewDetail.rev_rate}" var="i">☆</c:forEach>
		</div>
		<div>장점: ${reviewDetail.rev_pros }</div>
		<div>단점: ${reviewDetail.rev_cons }</div>
		<div>공개 여부: ${reviewDetail.rev_public }</div>
		<div>작성 일자: ${reviewDetail.rev_regdate }</div>
		<div>수정 일자: ${reviewDetail.rev_updatedate }</div>
	</div>
	<hr>
	<div>
		<form action="reviewUpdateForm" method="get">
			<input type="hidden" name="review_id" value="${reviewDetail.review_id }">
			<button type="submit">수정</button>
		</form>
		<form id="deleteForm" action="${pageContext.request.contextPath}/review/deleteReview" method="post" style="display:inline;">
    		<input type="hidden" name="review_id" value="${reviewDetail.review_id}" />
    		<button type="button" onclick="confirmDelete()">삭제</button>
		</form>
	</div>
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