<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="header.jsp" %>
<div class="container-fluid">
	<h2 class="mb-4">리뷰 관리</h2>

	<c:if test="${not empty msg}">
		<div class="alert alert-success text-center">${msg}</div>
	</c:if>

	<table class="table table-bordered text-center">
		<thead class="bg-light">
			<tr>
				<th>리뷰ID</th>
				<th>회원ID</th>
				<th>기업ID</th>
				<th>제목</th>
				<th>별점</th>
				<th>공개여부</th>
				<th>작성일</th>
				<th>최근 수정일</th>
				<th>관리</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="review" items="${reviewList}">
				<tr>
					<td>${review.reviewId}</td>
					<td>${review.memberId}</td>
					<td>${review.corpId}</td>
					<td class="text-left">
						<a href="${pageContext.request.contextPath}/review/reviewDetail?reviewId=${review.reviewId}">
							${review.revTitle}
						</a>
					</td>
					<td>
						<c:forEach begin="1" end="5" var="i">
							<c:choose>
								<c:when test="${i <= review.revRate}">★</c:when>
								<c:otherwise>☆</c:otherwise>
							</c:choose>
						</c:forEach>
					</td>
					<td>
						<c:choose>
							<c:when test="${review.revPublic eq 'y'}">공개</c:when>
							<c:otherwise>비공개</c:otherwise>
						</c:choose>
					</td>
					<td>
						${fn:replace(review.revRegdate, 'T', ' ')}
					</td>
					<td>
						${fn:replace(review.revUpdatedate, 'T', ' ')}
					</td>
					<td>
						<form action="${pageContext.request.contextPath}/admin/deleteReview" 
							  method="post" style="display:inline;">
							<input type="hidden" name="reviewId" value="${review.reviewId}" />
							<button type="submit" 
									class="btn btn-sm btn-danger"
									onclick="return confirm('정말 삭제하시겠습니까?');">
								삭제
							</button>
						</form>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<div class="d-flex justify-content-center mt-4">
		<ul class="pagination">
	
			<!-- 이전 버튼 -->
			<c:if test="${pageVO.prev}">
				<li class="page-item">
					<a class="page-link"
					   href="?page=${pageVO.startPage - 1}&pageSize=${pageVO.cri.pageSize}">
						이전
					</a>
				</li>
			</c:if>
	
			<!-- 페이지 번호 -->
			<c:forEach var="num" begin="${pageVO.startPage}" end="${pageVO.endPage}">
				<li class="page-item ${pageVO.cri.page == num ? 'active' : ''}">
					<a class="page-link"
					   href="?page=${num}&pageSize=${pageVO.cri.pageSize}">
						${num}
					</a>
				</li>
			</c:forEach>
	
			<!-- 다음 버튼 -->
			<c:if test="${pageVO.next}">
				<li class="page-item">
					<a class="page-link"
					   href="?page=${pageVO.endPage + 1}&pageSize=${pageVO.cri.pageSize}">
						다음
					</a>
				</li>
			</c:if>
		</ul>
	</div>
</div>

<%@ include file="footer.jsp" %>