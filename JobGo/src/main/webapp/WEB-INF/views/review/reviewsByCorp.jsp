<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../include/Header.jsp"%>
<section class="section fix-layout">
	<div class="container">
		<h2 class="pageTitle">기업별 리뷰 목록</h2>

		<c:if test="${empty reviewList}">
			<div>등록된 리뷰가 없습니다.</div>
		</c:if>

		<c:set var="rowNum"
			value="${pageVO.totalCount - ((pageVO.cri.page - 1) * pageVO.cri.pageSize)}" />

		<ul class="reviewList">
		<c:forEach var="review" items="${reviewList}">
			<li>
				<a href="${pageContext.request.contextPath}/review/reviewDetail?reviewId=${review.reviewId}&origin=corp&corpId=${corpId}">
				<%-- <span class="rvTitle">
					<strong>번호: ${rowNum}</strong>
				</span> --%>
				<c:set var="rowNum" value="${rowNum - 1}" />

				<span class="rvTitle">
					${review.revTitle}
				</span>
				<!-- <label>별점: </label> -->
				<span class="rvScore">
					<c:forEach begin="1" end="${review.revRate}" var="i">★</c:forEach>
					<c:forEach begin="1" end="${5 - review.revRate}" var="i">☆</c:forEach>
				</span>
				<span class="rvDate">
					작성일: <fmt:formatDate value="${review.revRegdate}" pattern="yyyy-MM-dd HH:mm" />
				</span>
				<span class="rvDate">조회수: ${review.revViewcnt}</span>
				<span>작성자 ID: ${review.memberId}</span>
				</a>
			</li>
		</c:forEach>
		</ul>
		
		<div class="pagination" style="text-align: center; margin-top: 20px;">
			<ul class="pagination-list">
			<c:if test="${pageVO.prev}">
				<li><a href="?page=${pageVO.startPage - 1}&corpId=${corpId}">&lt;</a></li>
			</c:if>

			<c:forEach var="num" begin="${pageVO.startPage}"
				end="${pageVO.endPage}">
				<c:choose>
					<c:when test="${pageVO.cri.page == num}">
						<li class="active"><a href="#">${num}</a></li>
					</c:when>
					<c:otherwise>
						<li><a href="?page=${num}&corpId=${corpId}">${num}</a></li>
					</c:otherwise>
				</c:choose>
			</c:forEach>

			<c:if test="${pageVO.next}">
				<a href="?page=${pageVO.endPage + 1}&corpId=${corpId}">다음</a>
			</c:if>
			</ul>
		</div>

		<div class="text-right mt-20 button">
			<button type="button" onclick="location.href='${pageContext.request.contextPath}/review/reviewList'" class="btn btn-info">
				전체 리뷰 목록으로 돌아가기</button>
		</div>
	</div>
</section>
<%@ include file="../include/Footer.jsp"%>