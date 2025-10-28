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
		<div>근무 기간: ${reviewDetail.work_months }</div>
		<div>내용: ${reviewDetail.rev_content }</div>
		<div>별점: ${reviewDetail.rev_rate }</div>
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
		<form action="${pageContext.request.contextPath}/review/deleteReview" method="post">
    		<input type="hidden" name="review_id" value="${reviewDetail.review_id}" />
    		<button type="submit">삭제</button>
		</form>
	</div>
	

</body>
</html>