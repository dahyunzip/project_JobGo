<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../include/Header.jsp"%>
<section class="section fix-layout">
	<h2 class="pageTitle">기업리뷰</h2>
	<c:if test="${empty sessionScope.userid}">
		<p class="text-center">로그인 후 리뷰를 작성할 수 있습니다.</p>
	</c:if>
	<div class="container">
		<c:if test="${not empty successMsg}">
			<script>
				alert("${successMsg}");
			</script>
		</c:if>
		
		<!-- 키워드 검색 -->
		<form action="reviewList" method="get" style="margin-bottom: 20px;" id="searchForm">
			<div class="footSearch">
				<div id="subSearch">
					<input type="text" placeholder="검색어 입력" value="${param.search}"name="search" class="form-control">
					<a href="#" class="btn"><i class="lni lni-24 lni-search-1"></i></a>
				</div>
			</div>
		</form>
		
		<%-- <form method="get" action="reviewList" style="margin-bottom: 20px;">
			<input type="text" name="search" value="${param.search}"
				placeholder="검색어 입력" />
			<button type="submit">검색</button>
		</form> --%>

		<c:set var="rowNum"
			value="${pageVO.totalCount - ((pageVO.cri.page - 1) * pageVO.cri.pageSize)}" />

		<%-- <table border="1">
			<thead>
				<tr>
					<th>리뷰 번호</th>
					<th>제목</th>
					<th>작성자</th>
					<th>별점</th>
					<th>작성일</th>
					<th>조회수</th>
				</tr>
			</thead>
			<tbody>

				<!-- 리뷰 없을 때 표시 -->
				<c:if test="${empty reviewList}">
					<tr>
						<td colspan="5">등록된 리뷰가 없습니다.</td>
					</tr>
				</c:if>

				<c:forEach var="review" items="${reviewList}">
					<tr>
						<td>${rowNum}</td>
						<c:set var="rowNum" value="${rowNum - 1}" />
						<td><a
							href="${pageContext.request.contextPath}/review/reviewDetail?reviewId=${review.reviewId}">${review.revTitle}</a>
						</td>
						<td>${review.memberId}</td>
						<td><c:forEach begin="1" end="5" var="i">
								<c:choose>
									<c:when test="${i <= review.revRate}">★</c:when>
									<c:otherwise>☆</c:otherwise>
								</c:choose>
							</c:forEach></td>
						<td><fmt:formatDate value="${review.revRegdate}"
								pattern="yyyy-MM-dd HH:mm" /></td>
						<td>${review.revViewcnt}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table> --%>
		
		
		
		<ul class="reviewList">
			<c:forEach var="review" items="${reviewList}">
			<li>
				<a href="${pageContext.request.contextPath}/review/reviewDetail?reviewId=${review.reviewId}">
					<span class="rvScore">
						<c:forEach begin="1" end="5" var="i">
							<c:choose>
								<c:when test="${i <= review.revRate}">★</c:when>
								<c:otherwise>☆</c:otherwise>
							</c:choose>
						</c:forEach>
					</span>
					<span class="rvTitle">${review.revTitle}</span>
					<%-- <span class="rvComp">${review.companyName}</span> --%>
					<span class="rvDate"><fmt:formatDate value="${review.revRegdate}" pattern="yyyy-MM-dd HH:mm" /></span>
				</a>
			</li>
			</c:forEach>
		</ul>

		<div class="pagination" style="text-align: center; margin-top: 20px;">
			<ul class="pagination-list">
			<c:if test="${pageVO.prev}">
				<li><a href="?page=${pageVO.startPage - 1}"><i class="lni lni-arrow-left"></i></a></li>
			</c:if>

			<%-- <c:forEach var="num" begin="${pageVO.startPage}" end="${pageVO.endPage}">
				<c:choose>
					<c:when test="${pageVO.cri.page == num}">
						<strong>[${num}]</strong>
					</c:when>
					<c:otherwise>
						<a href="?page=${num}">${num}</a>
					</c:otherwise>
				</c:choose>
			</c:forEach> --%>
			
			<c:forEach var="i" begin="${pageVO.startPage}" end="${pageVO.endPage}" step="1">
				<li class="${pageVO.cri.page == i ? 'active' : ''}">
					<a href="?page=${i}">${i}</a>
				</li>
			</c:forEach>

			<c:if test="${pageVO.next}">
				<a href="?page=${pageVO.endPage + 1}">다음</a>
			</c:if>
			</ul>
		</div>

		<c:if test="${not empty sessionScope.userid}">
			<div class="text-right button">
			<button type="button"
				onclick="location.href='${pageContext.request.contextPath}/review/insertReview'" class="btn">
				리뷰 작성</button>
			</div>
		</c:if>
	</div>
</section>

<script>
$(document).ready(function(){
	$('.searchSub .btn').click(function(){
		$('#searchForm').submit();
	})
})
</script>
<%@ include file="../include/Footer.jsp"%>