<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/Header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 작성</title>
</head>
<body>
	<h2>리뷰 작성</h2>
	<form action="${pageContext.request.contextPath}/review/insertReview" method="post">
		<div>
			<label>기업 ID</label>
			<input type="text" name="corp_id"/>
		</div>
		<div>
			<label>직무 코드</label>
			<input type="text" name="job_code"/>
		</div>
		<div>
			<label>근무 기간</label>
			<select name="work_months">
				<option value="">선택하세요</option>
				<option value="A">1개월 미만</option>
				<option value="B">1~3개월</option>
				<option value="C">3~6개월</option>
				<option value="D">6~12개월</option>
				<option value="E">1~2년</option>
				<option value="F">2~3년</option>
				<option value="G">3~5년</option>
				<option value="H">5년 이상</option>
			</select>
		</div>
		<div>
			<label>제목</label>
			<input type="text" name="rev_title"/>
		</div>
		<div>
			<label>내용</label>
			<textarea name="rev_content"></textarea>
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
    		<input type="hidden" name="rev_rate" id="rev_rate" value="0">
		</div>
		<div>
			<label>장점</label>
			<textarea name="rev_pros"></textarea>
		</div>
		<div>
			<label>단점</label>
			<textarea name="rev_cons"></textarea>
		</div>
		<div>
			<label>공개여부</label>
			<select name="rev_public">
				<option value="y">예</option>
				<option value="n">아니오</option>
			</select>
		</div>
		<div>
			<button type="submit">저장</button>
		</div>
	</form>
	
	<script>
			const stars = document.querySelectorAll('#star-rating .star');
	    	const revRateInput = document.getElementById('rev_rate');
	
		    stars.forEach(star => {
		        star.addEventListener('click', () => {
		            const value = parseInt(star.getAttribute('data-value'));
	
		            // 선택된 별점 저장
	    	        revRateInput.value = value;

		            // 별 채우기/비우기
		            stars.forEach((s, index) => {
	   	            if (index < value) {
	   	                 s.textContent = '★'; // 채워진 별
	   	            } else {
	   	                 s.textContent = '☆'; // 빈 별
	   	            }
	   	         	});
	    	    });
	    	});
		</script>
	
</body>
</html>
<%@ include file="../include/Footer.jsp"%>