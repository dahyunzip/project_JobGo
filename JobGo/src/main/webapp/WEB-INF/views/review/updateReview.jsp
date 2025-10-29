<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 수정</title>
</head>
<body>
	<form action="${pageContext.request.contextPath}/review/updateReview" method="post">
	<!-- <form action="/review/insertReview" method="post"> -->
		<input type="hidden" name="review_id" value="${reviewDetail.review_id}"/>
		<!-- <input type="hidden" name="member_id" value="${sessionScope.loginMember.id}" /> -->
		<div>
        	<label>회원 ID</label>
        	<input type="text" name="member_id" value="${review.member_id}" readonly />
    	</div>
		<div>
			<label>기업 ID</label>
			<input type="text" name="corp_id" value="${reviewDetail.corp_id }"/>
		</div>
		<div>
			<label>직무 코드</label>
			<input type="text" name="job_code" value="${reviewDetail.job_code }"/>
		</div>
		<div>
            <label>근무 기간</label>
            <select name="work_months">
                <option value="">선택하세요</option>
                <option value="A" <c:if test="${review.work_months == 'A'}">selected</c:if>>1개월 미만</option>
                <option value="B" <c:if test="${review.work_months == 'B'}">selected</c:if>>1~3개월</option>
                <option value="C" <c:if test="${review.work_months == 'C'}">selected</c:if>>3~6개월</option>
                <option value="D" <c:if test="${review.work_months == 'D'}">selected</c:if>>6~12개월</option>
                <option value="E" <c:if test="${review.work_months == 'E'}">selected</c:if>>1~2년</option>
                <option value="F" <c:if test="${review.work_months == 'F'}">selected</c:if>>2~3년</option>
                <option value="G" <c:if test="${review.work_months == 'G'}">selected</c:if>>3~5년</option>
                <option value="H" <c:if test="${review.work_months == 'H'}">selected</c:if>>5년 이상</option>
            </select>
        </div>
		<div>
			<label>제목</label>
			<input type="text" name="rev_title" value="${reviewDetail.rev_title }"/>
		</div>
		<div>
			<label>내용</label>
			<textarea name="rev_content">${reviewDetail.rev_content}</textarea>
		</div>
		<div>
            <label>별점: </label>
            <div id="star-rating">
                <span class="star" data-value="1">☆</span>
                <span class="star" data-value="2">☆</span>
                <span class="star" data-value="3">☆</span>
                <span class="star" data-value="4">☆</span>
                <span class="star" data-value="5">☆</span>
            </div>
            <input type="hidden" name="rev_rate" id="rev_rate" value="${review.rev_rate}">
        </div>
		<div>
			<label>장점</label>
			<textarea name="rev_pros">${reviewDetail.rev_pros}</textarea>
		</div>
		<div>
			<label>단점</label>
			<textarea name="rev_cons">${reviewDetail.rev_cons}</textarea>
		</div>
		<div>
			<label>공개여부</label>
			<select name="rev_public">
				<option value="y" ${reviewDetail.rev_public == 'y' ? 'selected' : ''}>예</option>
                <option value="n" ${reviewDetail.rev_public == 'n' ? 'selected' : ''}>아니오</option>
            </select>
		</div>
		<div>
            <button type="submit">수정 완료</button>
        </div>
	</form>
	
	<script>
        const stars = document.querySelectorAll('#star-rating .star');
        const revRateInput = document.getElementById('rev_rate');

        // 페이지 로딩 시 기존 별점 적용
        const initialRate = parseInt(revRateInput.value);
        stars.forEach((s, index) => {
            s.textContent = index < initialRate ? '★' : '☆';
        });

        // 클릭 이벤트로 별점 수정
        stars.forEach(star => {
            star.addEventListener('click', () => {
                const value = parseInt(star.getAttribute('data-value'));
                revRateInput.value = value;

                stars.forEach((s, index) => {
                    s.textContent = index < value ? '★' : '☆';
                });
            });
        });
    </script>
	
</body>
</html>