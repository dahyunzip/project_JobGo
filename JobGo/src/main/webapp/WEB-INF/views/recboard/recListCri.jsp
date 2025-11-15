<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/Header.jsp"%>
<section class="find-job job-list section">
	<h2 class="pageTitle">채용공고</h2>
	<div class="container">
		<c:set var="cri" value="${recPageVO.cri}" scope="page" />
		<div class="single-head">
			<div class="row">
				<div class="col-12">
					<!-- 필터 영역 -->
					<div class="filter-section mb-4">
						<form id="filterForm" action="/recboard/recListCri" method="get"
							class="row g-3">
							<!-- 지역 선택 -->
							<div class="col-lg-6">
								<label for="toplct" class="form-label fw-bold">지역 선택</label> <select
									id="toplct" name="toplct_id" class="form-select">
									<option value="">지역 선택</option>
									<c:forEach var="loc" items="${topLocationList}">
										<option value="${loc.toplct_id}"
											${loc.toplct_id == param.toplct_id ? 'selected' : ''}>
											${loc.toplct_name}</option>
									</c:forEach>
								</select>
							</div>

							<!-- 직무 선택 -->
							<div class="col-lg-6">
								<label for="topctg" class="form-label fw-bold">직무 선택</label> <select
									id="topctg" name="topctg_id" class="form-select">
									<option value="">직무 선택</option>
									<c:forEach var="top" items="${topCategoryList}">
										<option value="${top.topctg_id}"
											${top.topctg_id == param.topctg_id ? 'selected' : ''}>
											${top.topctg_name}</option>
									</c:forEach>
								</select>
							</div>

							<div class="col-12 text-center mt-3">
								<button type="submit" class="btn btn-primary">검색</button>
								<button type="button" id="resetBtn"
									class="btn btn-secondary">초기화</button>
							</div>
						</form>
					</div>
					<!-- 게시글 리스트 -->
					<div class="box-wrap">
						<div class="job-wrap">
							<c:forEach var="vo" items="${recBoardList}">
								<div class="single-job"
									onclick="location.href='/recboard/recRead?rec_bno=${vo.rec_bno}&recPage=${cri.recPage}'">
									<div class="thumb-area">
										<img src="/upload/recfile/${vo.thumbFileName}">
									</div>
									<div class="overlay-text">
										<h3 class="company">${vo.rec_title}</h3>
										<p class="title">${vo.companyName}</p>
										<div class="info">
											<%-- <span>작성자: ${vo.corpUserId}</span> --%>
											<span>공고 게시일 <fmt:formatDate value="${vo.rec_regdate}"
													pattern="yyyy.MM.dd" /></span> <span>조회수 ${vo.rec_viewcnt}</span>
										</div>
									</div>
								</div>
							</c:forEach>
						</div>
					</div>
				</div>
			</div>

			<!-- 키워드 검색 -->
			<form action="/recboard/recListCri" method="get">
				<div class="footSearch">
					<div id="subSearch">
						<input type="text" placeholder="검색어 입력" value="${search}"
							name="search" class="form-control"> <a href="#"
							class="btn"><i class="lni lni-24 lni-search-1"></i></a>
					</div>
				</div>
			</form>

			<!-- 페이지네이션 -->
			<div class="row">
				<div class="col-12">
					<c:if test="${not empty recLoginInfo and empty loginUserId}">
						<div class="button mt-20 text-right">
							<a href="/recboard/recWrite"><button type="button"
									class="btn">글쓰기</button></a>
						</div>
					</c:if>
					<div class="pagination center">
						<ul class="pagination-list">
							<c:if test="${recPageVO.prev}">
								<li><a
									href="/recboard/recListCri?recPage=${recPageVO.startPage - 1}"><i
										class="lni lni-arrow-left"></i></a></li>
							</c:if>

							<c:forEach var="i" begin="${recPageVO.startPage}"
								end="${recPageVO.endPage}" step="1">
								<li class="${cri.recPage == i ? 'active' : ''}"><a
									href="/recboard/recListCri?recPage=${i}">${i}</a></li>
							</c:forEach>

							<c:if test="${recPageVO.next}">
								<li><a
									href="/recboard/recListCri?recPage=${recPageVO.endPage + 1}"><i
										class="lni lni-arrow-right"></i></a></li>
							</c:if>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>
<script>
	$(document).ready(function() {

		// 초기화 버튼
		$("#resetBtn").click(function() {
			location.href = "/recboard/recListCri";
		});

	});
</script>
<%@ include file="../include/Footer.jsp"%>