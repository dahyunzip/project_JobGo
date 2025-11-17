<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="header.jsp"%>
<div class="container-fluid">
	<!-- 페이지 제목 -->
	<h1 class="h3 mb-4 text-gray-800">채용공고 게시판</h1>

	<div class="card shadow mb-4">
		<div class="card-header py-3">
			<h6 class="m-0 font-weight-bold text-primary">채용공고 게시판</h6>
		</div>
		<div class="card-body">
			<div class="table-responsive">
				<div id="dataTable_wrapper" class="dataTables_wrapper dt-bootstrap4">
					<!-- 검색창 -->
					<div class="row">
						<div class="col-sm-12 col-md-6">
							<form action="${pageContext.request.contextPath}/admin/corpBoard" method="get" class="d-flex align-items-center">
								<label>Search:</label>
								<input type="text" name="search" value="${pageVO.cri.search}"
									   class="form-control form-control-sm" placeholder="제목 또는 회사명 입력" style="width:200px;">
								<button type="submit" class="btn btn-primary btn-sm ml-2">검색</button>
							</form>
						</div>
					</div>
					<!-- 테이블 -->
					<div class="row">
						<div class="col-sm-12">
							<table class="table table-bordered dataTable" id="dataTable"
								width="100%" cellspacing="0" role="grid"
								aria-describedby="dataTable_info" style="width: 100%;">
								<colgroup>
									<col width="8%">
									<col width="35%">
									<col width="15%">
									<col width="15%">
									<col width="15%">
									<col width="7%">
									<col width="10%">
								</colgroup>
								<thead class="thead-light text-center">
									<tr role="row">
										<th>글 번호</th>
										<th>채용공고명</th>
										<th>회사명</th>
										<th>공고시작날짜</th>
										<th>공고마감날짜</th>
										<th>지원수</th>
										<th>기능</th>
									</tr>
								</thead>
								<tbody>
									<c:choose>
										<c:when test="${empty recList}">
											<tr>
												<td colspan="7" class="text-center text-muted">
													등록된 채용공고가 없습니다.
												</td>
											</tr>
										</c:when>
										<c:otherwise>
											<c:forEach var="rec" items="${recList}">
												<tr>
													<td class="text-center">${rec.rec_bno}</td>
													<td>
														<a href="${pageContext.request.contextPath}/recboard/recRead?rec_bno=${rec.rec_bno}">
															${rec.rec_title}
														</a>
													</td>
													<td>${rec.companyName}</td>
													<td>${fn:replace(rec.rec_regdate, 'T', ' ')}</td>
													<td><fmt:formatDate value="${rec.rec_deadline}" pattern="yyyy-MM-dd"/></td>
													<td class="text-center">${rec.rec_viewcnt}</td>
													
													<td class="text-center">
														<a href="${pageContext.request.contextPath}/admin/deleteRecBoard?rec_bno=${rec.rec_bno}"
															class="btn btn-danger btn-sm"
															onclick="return confirm('정말 삭제하시겠습니까?');">삭제</a>
													</td>
												</tr>
											</c:forEach>
										</c:otherwise>
									</c:choose>
								</tbody>
							</table>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-12 col-md-7">
							<div class="dataTables_paginate paging_simple_numbers" id="dataTable_paginate">
								<ul class="pagination">

									<!-- 이전 버튼 -->
									<c:if test="${pageVO.prev}">
										<li class="paginate_button page-item previous">
											<a href="?page=${pageVO.startPage - 1}&search=${pageVO.cri.search}"
											   class="page-link">Previous</a> <!-- ★추가 -->
										</li>
									</c:if>

									<!-- 페이지 번호 -->
									<c:forEach var="num" begin="${pageVO.startPage}" end="${pageVO.endPage}">
										<li class="paginate_button page-item ${pageVO.cri.page == num ? 'active' : ''}">
											<a href="?page=${num}&search=${pageVO.cri.search}"
											   class="page-link">${num}</a> <!-- ★추가 -->
										</li>
									</c:forEach>

									<!-- 다음 버튼 -->
									<c:if test="${pageVO.next}">
										<li class="paginate_button page-item next">
											<a href="?page=${pageVO.endPage + 1}&search=${pageVO.cri.search}"
											   class="page-link">Next</a> <!-- ★추가 -->
										</li>
									</c:if>

								</ul>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<%@ include file="footer.jsp"%>