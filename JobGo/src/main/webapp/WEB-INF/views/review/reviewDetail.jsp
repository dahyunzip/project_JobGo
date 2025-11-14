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
	<h2>리뷰 상세</h2>
	
	<c:if test="${not empty errorMsg}">
    	<p style="color:red; font-weight:bold; margin-top:10px;">
     	   ${errorMsg}
    	</p>
	</c:if>
	
	<div>
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
	
	<!-- 작성자 본인일 때만 수정/삭제 버튼 -->
	<c:if test="${isOwner}">
		<!-- 수정 버튼 -->
		<form action="${pageContext.request.contextPath}/review/updateReview" method="get" style="display:inline;">
			<input type="hidden" name="reviewId" value="${reviewDetail.reviewId}"/>
			<button type="submit">수정</button>
		</form>
	
		<!-- 삭제 버튼 -->
		<button type="button" onclick="openDeleteModal(${reviewDetail.reviewId})">삭제</button>
	</c:if>

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
</body>
<%@ include file="../include/Footer.jsp"%>
</html>