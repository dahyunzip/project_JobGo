<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../include/Header.jsp"%>
<section class="reviewDetail section">
	<h2 class="pageTitle">리뷰 상세</h2>
	<div class="container">
		
		<c:if test="${not empty flash.errorMsg or not empty errorMsg}">
			<script>
	    		alert("${errorMsg}");
			</script>
		</c:if>
		
		<%-- <div>
			<div>리뷰 번호: ${reviewDetail.reviewId }</div>
			<div>회원 ID: ${reviewDetail.memberId }</div>
			<div>기업명: ${companyName}</div>
			<div>직무 대분류: ${reviewDetail.topCategoryName}</div>
			<div>직무 소분류: ${reviewDetail.bottomCategoryName}</div>
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
			<div>조회수: ${reviewDetail.revViewcnt}</div>
			<div>작성 일자: ${reviewDetail.revRegdate }</div>
			<div>수정 일자: ${reviewDetail.revUpdatedate }</div>
		</div> --%>
		
		
		<div class="detailView">
			<dl>
				<dt>리뷰번호</dt>
				<dd>${reviewDetail.reviewId }</dd>
			</dl>
			<dl>
				<dt>기업명</dt>
				<dd>${companyName}</dd>
			</dl>
			<dl>
				<dt>기업 평균 별점</dt>
				<dd>
					<span id="avgRateText">${avgRate}</span> / 5
				</dd>
			</dl>

			<div style="width: 200px; margin-top:20px;">
				<canvas id="avgRateChart"></canvas>
			</div>
			<dl>
				<dt>별점</dt>
				<dd class="rvScore">
					<c:forEach begin="1" end="5" var="i">
						<c:choose>
							<c:when test="${i <= reviewDetail.revRate}">★</c:when>
							<c:otherwise>☆</c:otherwise>
						</c:choose>
					</c:forEach>
				</dd>
			</dl>
			<dl>
				<dt>직무 대분류</dt>
				<dd> ${reviewDetail.topCategoryName}</dd>
			</dl>
			<dl>
				<dt>직무 소분류</dt>
				<dd>${reviewDetail.bottomCategoryName}</dd>
			</dl>
			<dl>
				<dt>근무 기간</dt>
				<dd>
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
				</dd>
			</dl>
			
			<dl class="w100">
				<dt>내용</dt>
				<dd>${reviewDetail.revContent }</dd>
			</dl>
			<dl class="w100">
				<dt>장점</dt>
				<dd>${reviewDetail.revPros }</dd>
			</dl>
			<dl class="w100">
				<dt>단점</dt>
				<dd>${reviewDetail.revCons }</dd>
			</dl>
			<dl class="w100">
				<dt>작성 일자</dt>
				<dd><fmt:formatDate value="${reviewDetail.revRegdate}" pattern="yyyy-MM-dd HH:mm" /></dd>
			</dl>
			<dl class="w100">
				<dt>수정 일자</dt>
				<dd><fmt:formatDate value="${reviewDetail.revUpdatedate}" pattern="yyyy-MM-dd HH:mm" /></dd>
			</dl>
			<dl>
				<dt>조회수</dt>
				<dd>${reviewDetail.revViewcnt}</dd>
			</dl>
		</div>
		<div class="button mt-30 text-right">
			
			<!-- 작성자 본인일 때만 수정/삭제 버튼 -->
			<c:if test="${isOwner}">
				<!-- 수정 버튼 -->
				<form action="${pageContext.request.contextPath}/review/updateReview" method="get" style="display:inline;">
					<input type="hidden" name="reviewId" value="${reviewDetail.reviewId}"/>
					<button type="submit" class="btn btn2">수정</button>
				</form>
			
				<!-- 삭제 버튼 -->
				<button type="button" onclick="openDeleteModal(${reviewDetail.reviewId})" class="btn btn3">삭제</button>
			</c:if>
			
			<!-- 작성자 리뷰로 이동 -->
			<button type="button" class="btn"
    			onclick="location.href='${pageContext.request.contextPath}/review/memberReviewList?memberId=${reviewDetail.memberId}'">
    			작성자 리뷰 보기
			</button>

			<!-- 기업 리뷰로 이동 -->
			<button type="button" class="btn"
			    onclick="location.href='${pageContext.request.contextPath}/review/corpReviewList?corpId=${reviewDetail.corpId}'">
			    기업 리뷰 보기
			</button>
			
			<c:if test="${param.origin eq 'member'}">
    			<button type="button" class="btn"
    			    onclick="location.href='${pageContext.request.contextPath}/review/memberReviewList?memberId=${param.memberId}'">
    			    목록으로
    			</button>
			</c:if>

			<c:if test="${param.origin eq 'corp'}">
    			<button type="button" class="btn"
        			onclick="location.href='${pageContext.request.contextPath}/review/corpReviewList?corpId=${param.corpId}'">
        			목록으로
    			</button>
			</c:if>

			<!-- 기본: 전체 목록 -->
			<button type="button" class="btn"
    			onclick="location.href='${pageContext.request.contextPath}/review/reviewList'">
    			목록으로
			</button>
			
		</div>
		
		
	
		<!-- 모달 템플릿 -->
		<div id="deleteModal" class="modal-overlay">
			<div class="modal-container">
				<h3>리뷰 삭제 확인</h3>
				<form id="deleteForm" method="post" action="${pageContext.request.contextPath}/review/deleteReview">
					<input type="hidden" id="modalReviewId" name="reviewId">
					<div class="modal-body">
						<label>비밀번호를 입력하세요:</label><br>
						<input type="password" id="modalPassword" name="password" required>
					</div>
					<div class="modal-footer">
						<button type="button" onclick="closeDeleteModal()">취소</button>
						<button type="submit">삭제</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</section>	
	<style>
	.modal-overlay {
		display: none;
		position: fixed;
		top: 0;
		left: 0;
		width: 100%;
		height: 100%;
		background: rgba(0,0,0,0.6);
		z-index: 1000;
		justify-content: center;
		align-items: center;
	}
	.modal-container {
		background: white;
		padding: 20px;
		border-radius: 8px;
		width: 350px;
		box-shadow: 0 4px 10px rgba(0,0,0,0.3);
	}
	.modal-body {
		margin: 15px 0;
	}
	.modal-footer {
		text-align: right;
	}
	.modal-footer button {
		margin-left: 10px;
		padding: 6px 10px;
		cursor: pointer;
	}
	</style>
		
	<script>
		function openDeleteModal(reviewId) {
			document.getElementById("modalReviewId").value = reviewId;
			document.getElementById("deleteModal").style.display = "flex";
		}
		function closeDeleteModal() {
			document.getElementById("deleteModal").style.display = "none";
		}
		window.addEventListener("click", function(e) {
			const modal = document.getElementById("deleteModal");
			if (e.target === modal) modal.style.display = "none";
		});
	</script>
	<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
	<script>
	window.addEventListener("DOMContentLoaded", function() {
	
		const avg = Number("${avgRate == null ? 0 : avgRate}");
	
		const ctx = document.getElementById('avgRateChart');
	
		new Chart(ctx, {
			type: 'bar',
			data: {
				labels: ['기업 평균 별점'],
				datasets: [{
					label: '평균 별점',
					data: [avg],
					backgroundColor: 'rgba(54,162,235,0.5)',
					borderColor: 'rgba(54,162,235,1)',
					borderWidth: 1
				}]
			},
			options: {
				scales: {
					y: {
						beginAtZero: true,
						max: 5
					}
				}
			}
		});
	});
	</script>
<%@ include file="../include/Footer.jsp"%>