<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 작성</title>
</head>
<body>
<%@ include file="../include/Header.jsp"%>

	<h2>리뷰 작성</h2>
	<form action="${pageContext.request.contextPath}/review/insertReview" method="post">
		
		<div>
			<label>기업 ID</label>
			<input type="text" name="corpId"/>
		</div>
		<div>
			<label>직무</label>
	
			<!-- 대분류 -->
			<select id="topCategory" name="topId">
				<option value="">대분류 선택</option>
			</select>
	
			<!-- 소분류 -->
			<select id="bottomCategory" name="jobCode">
				<option value="">소분류 선택</option>
			</select>
		</div>
		<div>
			<label>근무 기간</label>
			<select name="workMonths">
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
			<input type="text" name="revTitle"/>
		</div>
		<div>
			<label>내용</label>
			<textarea name="revContent"></textarea>
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
    		<input type="hidden" name="revRate" id="revRate" value="0">
		</div>
		<div>
			<label>장점</label>
			<textarea name="revPros"></textarea>
		</div>
		<div>
			<label>단점</label>
			<textarea name="revCons"></textarea>
		</div>
		<div>
			<label>공개여부</label>
			<select name="revPublic">
				<option value="y">예</option>
				<option value="n">아니오</option>
			</select>
		</div>
		<div>
			<button type="submit">저장</button>
		</div>
	</form>
	
	<script>
	
	document.querySelector("#bottomCategory").disabled = true;
	
			const stars = document.querySelectorAll('#star-rating .star');
	    	const revRateInput = document.getElementById('revRate');
	
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
		    
		 // 대분류 로드
		    fetch("${pageContext.request.contextPath}/review/topCategory")
		    	.then(r => r.json())
		    	.then(data => {
		    		const top = document.querySelector("#topCategory");
		    		data.forEach(item => {
		    			const opt = document.createElement("option");
		    			opt.value = item.id || item.TOP_ID;
		    			opt.textContent = item.name || item.TOP_NAME;
		    			top.appendChild(opt);
		    		});
		    	});

		    // 소분류 로드
		    document.querySelector("#topCategory").addEventListener("change", function(){
		    	const topId = this.value;
		    	console.log("✅ 선택된 topId:", topId);
		    	const bottom = document.querySelector("#bottomCategory");
		    	bottom.innerHTML = "<option value=''>선택</option>";

		    	if (!topId) return;

		    	fetch("${pageContext.request.contextPath}/review/bottomCategory?topId=" + topId)
		    		.then(r => r.json())
		    		.then(data => {
		    			bottom.disabled = false;
		    			data.forEach(item => {
		    				const opt = document.createElement("option");
		    				opt.value = item.id || item.BOTTOM_ID;
		    				opt.textContent = item.name || item.BOTTOM_NAME;
		    				bottom.appendChild(opt);
		    			});
		    		});
		    });
		</script>
	
</body>
<%@ include file="../include/Footer.jsp"%>
</html>