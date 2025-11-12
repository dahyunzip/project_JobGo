<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
				<th>관리</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="review" items="${reviewList}">
				<tr>
					<td>${review.reviewId}</td>
					<td>${review.memberId}</td>
					<td>${review.corpId}</td>
					<td class="text-left">${review.revTitle}</td>
					<td>${review.revRate}</td>
					<td>
						<c:choose>
							<c:when test="${review.revPublic eq 'Y'}">공개</c:when>
							<c:otherwise>비공개</c:otherwise>
						</c:choose>
					</td>
					<td>
						<fmt:formatDate value="${review.revCreated}" pattern="yyyy-MM-dd" />
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
</div>

<%@ include file="footer.jsp" %>