<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/Header.jsp"%>
<c:if test="${not empty msg}">
	<script type="text/javascript">
		alert("${msg}");
	</script>
</c:if>
<section class="section">
	<h2 class="pageTitle">커뮤니티</h2>
	<div class="container">
		<c:set var="cri" value="${pageVO.cri }" scope="page" />
		<form method="get" action="/comboard/comListCri" style="margin-bottom:20px;" id="searchForm">
			<div id="subSearch" style="float:right;">
				<input type="text" name="search" value="${search}" placeholder="검색어 입력"  class="form-control"/>
				<a href="#" class="btn"><i class="lni lni-24 lni-search-1"></i></a>
			</div>
		</form>
		
		<table class="table-responsive table-default">
			<colgroup>
				<col width="8%">
				<col width="*%">
				<col width="15%">
				<col width="8%">
				<col width="15%">
			</colgroup>
			<thead>
				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>작성자</th>
					<th>조회수</th>
					<th>작성일</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="vo" items="${cboardList }">
				<tr>
					<td>${vo.com_bno}</td>
					<td class="text-left"><a href="/comboard/comRead?com_bno=${vo.com_bno}&page=${cri.page}">${vo.com_title }</a></td>
					<td>${vo.userid }</td>
					<td>${vo.com_viewcnt }</td>
					<td><fmt:formatDate value="${vo.com_regdate }" /></td>
				</tr>
				</c:forEach>
			</tbody>
		</table>
		
		<%-- <div class="col-12">
			<!-- Single Job -->
			<div class="job-wrap">
				<form action="/comboard/comListCri" method="get">
					<div class="row">
						<div class="col-lg-6 col-xs-12"></div>
						<div id="searchBar" class="col-lg-6 col-xs-12">
							<input type="text" placeholder="검색어 입력" value="${search}" name="search" class="form-control">
						</div>
					</div>
				</form>
				<hr>
				<div class="box-wrap">
					<c:forEach var="vo" items="${cboardList }">
						<div class="single-job" onclick="location.href='/comboard/comRead?com_bno=${vo.com_bno}&page=${cri.page}'">
							<div class="job-content">
								<h4>
									<a href="/comboard/comRead?com_bno=${vo.com_bno}&page=${cri.page}">${vo.com_title }</a>
									${vo.com_title }
								</h4>
							</div>
							<hr>
							<div class="job-button">
								<ul>
									<li>${vo.email }</li>
									<li>작성자: ${vo.userid }</li>
									<li>작성일: <fmt:formatDate value="${vo.com_regdate }" /></li>
									<li>조회수: <span>${vo.com_viewcnt }</span></li>
								</ul>
							</div>
						</div>
					</c:forEach>
				</div>
			</div> --%>
			<!-- Pagination -->
			<div class="row">
				<div class="col-12">
					<c:if test="${!empty loginInfo }">
						<div class="button mt-20 text-right">
							<a href="/comboard/comRegist"><button type="button"
									class="btn">글쓰기</button></a>
						</div>
					</c:if>
					<div class="pagination center">
						<ul class="pagination-list">
							<c:if test="${pageVO.prev}">
								<!-- 이전 버튼 -->
								<li><a
									href="/comboard/comListCri?page=${pageVO.startPage - 1}&search=${search}"><i
										class="lni lni-arrow-left"></i></a></li>
							</c:if>
							<c:forEach var="i" begin="${pageVO.startPage }"
								end="${pageVO.endPage }" step="1">
								<li class="${cri.page == i ? 'active' : ''}"><a
									href="/comboard/comListCri?page=${i}&search=${search}">${i }</a>
								</li>
							</c:forEach>

							<c:if test="${pageVO.next}">
								<!-- 다음 버튼 -->
								<li><a
									href="/comboard/comListCri?page=${pageVO.endPage + 1}&search=${search}"><i
										class="lni lni-arrow-right"></i></a></li>
							</c:if>
						</ul>
					</div>
				</div>
			</div>
			<!--/ End Pagination -->
		</div>
	</div>
</section>
<%@ include file="../include/Footer.jsp"%>