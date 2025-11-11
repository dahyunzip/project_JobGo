<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 수정 </title>
</head>
<body>
<%@ include file="../include/Header.jsp"%>
    <h2>리뷰 수정</h2>
	
	
	<c:choose>
		<c:when test="${isOwner}">
		<!-- 본인일 때만 수정 가능  -->
    	<!-- 실전용 : 로그인 세션 기반으로 본인만 수정 가능 -->
    	<!-- 테스트 시에는 action만 동일하게 두고 세션 제거 가능 -->
    	<form action="${pageContext.request.contextPath}/review/updateReview" method="post">

        	
        	<input type="hidden" name="reviewId" value="${review.reviewId}" />

			<!--  <input type="hidden" name="memberId" value="${sessionScope.userid}" /> -->

        	<div>
            	<label>기업 ID</label>
            	<input type="text" name="corpId" value="${review.corpId}" readonly />
        	</div>
        	<div>
				<label>직무</label>

				<!-- 대분류 -->
				<select id="topCategory" name="topId">
					<option value="">대분류 선택</option>
				</select>
	
				<!-- 소분류 -->
				<select id="bottomCategory" name="jobCode" disabled="disabled">
					<option value="">소분류 선택</option>
				</select>
			</div>
        	<div>
        	    <label>근무 기간</label>
        	    <select name="workMonths">
        	        <option value="">선택하세요</option>
        	        <option value="A" <c:if test="${review.workMonths == 'A'}">selected</c:if>>1개월 미만</option>
        	        <option value="B" <c:if test="${review.workMonths == 'B'}">selected</c:if>>1~3개월</option>
        	        <option value="C" <c:if test="${review.workMonths == 'C'}">selected</c:if>>3~6개월</option>
        	        <option value="D" <c:if test="${review.workMonths == 'D'}">selected</c:if>>6~12개월</option>
        	        <option value="E" <c:if test="${review.workMonths == 'E'}">selected</c:if>>1~2년</option>
        	        <option value="F" <c:if test="${review.workMonths == 'F'}">selected</c:if>>2~3년</option>
        	        <option value="G" <c:if test="${review.workMonths == 'G'}">selected</c:if>>3~5년</option>
        	        <option value="H" <c:if test="${review.workMonths == 'H'}">selected</c:if>>5년 이상</option>
        	    </select>
        	</div>
	
    	    <div>
        	    <label>제목</label>
            	<input type="text" name="revTitle" value="${review.revTitle}" />
        	</div>

        	<div>
        	    <label>내용</label>
        	    <textarea name="revContent">${review.revContent}</textarea>
        	</div>
	
	        <div>
	            <label>별점</label>
	            <div id="star-rating">
	                <span class="star" data-value="1">☆</span>
	                <span class="star" data-value="2">☆</span>
	                <span class="star" data-value="3">☆</span>
	                <span class="star" data-value="4">☆</span>
	                <span class="star" data-value="5">☆</span>
	            </div>
	            <input type="hidden" name="revRate" id="revRate" value="${review.revRate}">
	        </div>
	
	        <div>
	            <label>장점</label>
	            <textarea name="revPros">${review.revPros}</textarea>
	        </div>
	
	        <div>
	            <label>단점</label>
	            <textarea name="revCons">${review.revCons}</textarea>
	        </div>
	
	        <div>
	            <label>공개 여부</label>
	            <select name="revPublic">
	                <option value="y" <c:if test="${review.revPublic eq 'y'}">selected</c:if>>예</option>
					<option value="n" <c:if test="${review.revPublic eq 'n'}">selected</c:if>>아니오</option>
				</select>
	        </div>
	
	        <div>
    	        <button type="submit">수정 완료</button>
    	    </div>
    	</form>
    </c:when>
		<c:otherwise>
			<p style="color:red;">본인만 수정할 수 있습니다.</p>
		</c:otherwise>
	</c:choose>
	
    <script>
        // 별점 초기값 설정 및 클릭 이벤트 처리
        const stars = document.querySelectorAll('#star-rating .star');
        const revRateInput = document.getElementById('revRate');
        const initialRate = parseInt(revRateInput.value) || 0;

        stars.forEach((s, i) => {
            s.textContent = i < initialRate ? '★' : '☆';
        });

        stars.forEach(star => {
            star.addEventListener('click', () => {
                const value = parseInt(star.getAttribute('data-value'));
                revRateInput.value = value;
                stars.forEach((s, i) => {
                    s.textContent = i < value ? '★' : '☆';
                });
            });
        });
        
        const topSelect = document.querySelector("#topCategory");
        const bottomSelect = document.querySelector("#bottomCategory");

        // DB에서 전달된 기존 선택값
        const topIdFromDB = "${review.topCategoryId}";
        const bottomIdFromDB = "${review.bottomCategoryId}";
        const jobCodeFromDB = "${review.jobCode}"; // 혹시 jobCode와 bottomId가 동일하게 쓰이는 경우 대비

        // 대분류 목록 불러오기
        fetch("${pageContext.request.contextPath}/review/topCategory")
        	.then(r => r.json())
        	.then(topList => {
        		topList.forEach(item => {
        			const opt = document.createElement("option");
        			opt.value = item.id;
        			opt.textContent = item.name;
        			if (item.id == topIdFromDB) opt.selected = true; // ✅ 기존 대분류 선택
        			topSelect.appendChild(opt);
        		});

        		// 기존 대분류가 있을 경우 소분류 자동 로드
        		if (topIdFromDB) {
        			loadBottomCategory(topIdFromDB, bottomIdFromDB || jobCodeFromDB);
        		}
        	});

        // 대분류 선택 시 소분류 다시 로드
        topSelect.addEventListener("change", () => {
        	const topId = topSelect.value;
        	loadBottomCategory(topId);
        });

        // 소분류 불러오기 함수
        function loadBottomCategory(topId, selectedBottomId = null) {
        	bottomSelect.innerHTML = "<option value=''>소분류 선택</option>";
        	if (!topId) {
        		bottomSelect.disabled = true;
        		return;
        	}

        	fetch("${pageContext.request.contextPath}/review/bottomCategory?topId=" + topId)
        		.then(r => r.json())
        		.then(bottomList => {
        			bottomSelect.disabled = false;
        			bottomList.forEach(b => {
        				const opt = document.createElement("option");
        				opt.value = b.id;
        				opt.textContent = b.name;
        				if (b.id == selectedBottomId) opt.selected = true; // ✅ 기존 소분류 자동 선택
        				bottomSelect.appendChild(opt);
        			});
        		});
        }
        
    </script>
</body>
<%@ include file="../include/Footer.jsp"%>
</html>
