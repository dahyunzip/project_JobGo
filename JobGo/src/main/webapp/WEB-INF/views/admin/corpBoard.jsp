<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
					<div class="row">
						<div class="col-sm-12 col-md-6">
							<div id="dataTable_filter" class="dataTables_filter">
								<label>Search:<input type="search"
									class="form-control form-control-sm" placeholder=""
									aria-controls="dataTable"></label>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-12">
							<table class="table table-bordered dataTable" id="dataTable"
								width="100%" cellspacing="0" role="grid"
								aria-describedby="dataTable_info" style="width: 100%;">
								<colgroup>
									<col width="8%">
									<col width="40%">
									<col width="*">
									<col width="*">
									<col width="*">
									<col width="*">
									<col width="*">
								</colgroup>
								<thead>
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
									<tr class="odd">
										<td>2</td>
										<td><a href="#">채용공고명</a></td>
										<td>회사명</td>
										<td>공고시작날짜</td>
										<td>공고마감날짜</td>
										<td>지원수</td>
										<td>
											<a href="#" class="btn btn-info">
	                                        	<span class="text">수정</span>
	                                    	</a>
											<a href="#" class="btn btn-danger ">
	                                        	<span class="text">삭제</span>
	                                    	</a>
                                    	</td>
									</tr>
									<tr class="even">
										<td>2</td>
										<td>채용공고명</td>
										<td>회사명</td>
										<td>공고시작날짜</td>
										<td>공고마감날짜</td>
										<td>지원수</td>
										<td>
											<a href="#" class="btn btn-info">
	                                        	<span class="text">수정</span>
	                                    	</a>
											<a href="#" class="btn btn-danger ">
	                                        	<span class="text">삭제</span>
	                                    	</a>
                                    	</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-12 col-md-7">
							<div class="dataTables_paginate paging_simple_numbers"
								id="dataTable_paginate">
								<ul class="pagination">
									<li class="paginate_button page-item previous disabled"
										id="dataTable_previous"><a href="#"
										aria-controls="dataTable" data-dt-idx="0" tabindex="0"
										class="page-link">Previous</a></li>
									<li class="paginate_button page-item active"><a href="#"
										aria-controls="dataTable" data-dt-idx="1" tabindex="0"
										class="page-link">1</a></li>
									<li class="paginate_button page-item "><a href="#"
										aria-controls="dataTable" data-dt-idx="2" tabindex="0"
										class="page-link">2</a></li>
									<li class="paginate_button page-item "><a href="#"
										aria-controls="dataTable" data-dt-idx="3" tabindex="0"
										class="page-link">3</a></li>
									<li class="paginate_button page-item "><a href="#"
										aria-controls="dataTable" data-dt-idx="4" tabindex="0"
										class="page-link">4</a></li>
									<li class="paginate_button page-item "><a href="#"
										aria-controls="dataTable" data-dt-idx="5" tabindex="0"
										class="page-link">5</a></li>
									<li class="paginate_button page-item next" id="dataTable_next"><a
										href="#" aria-controls="dataTable" data-dt-idx="7"
										tabindex="0" class="page-link">Next</a></li>
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