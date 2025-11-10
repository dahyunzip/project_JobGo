<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/Header.jsp"%>
<section class="find-job job-list section">
        <div class="container">
        	<c:set var="cri" value="${pageVO.cri }" scope="page" />
            <div class="single-head">
                <div class="row">
                    <div class="col-12">
                        <!-- Single Job -->
			           	<div class="job-wrap">
							<form action="/recboard/recListCri" method="get">
								<div class="row">
									<div class="col-lg-6 col-xs-12"></div>
									<div id="searchBar" class="col-lg-6 col-xs-12">
										<label>키워드 검색</label> 
										<input type="text"
											   placeholder="글제목, 작성자, 등 관련 키워드 작성 후 enter 눌러주세요!"
											   value="${search}" name="search" class="form-control">
									</div>
								</div>
							</form>
							<hr>
							<div class="box-wrap">
								<c:forEach var="vo" items="${recBoardList }">
									<div class="single-job" onclick="">
										<div class="job-content">
											<h4>
												<%-- <a href="/comboard/comRead?com_bno=${vo.com_bno}&page=${cri.page}">${vo.com_title }</a> --%>
												${vo.companyName }
											</h4>
										</div>
										<hr>
										<div class="job-button">
											<ul>
												<li><img src="/upload/${vo.thumbFileName }" width="50"></li>
												<li>작성자: ${vo.corpUserId }</li>
												<li>작성일: <fmt:formatDate value="${vo.rec_regdate }" /></li>
												<li>조회수: <span>${vo.rec_viewcnt }</span></li>
											</ul>
										</div>
									</div>
								</c:forEach>
							</div>
						</div>
                        <!-- End Single Job -->
                </div>
                <!-- Pagination -->
                <div class="row">
                    <div class="col-12">
                        <div class="pagination center">
                            <ul class="pagination-list">
                                <c:if test="${pageVO.prev}">
								<!-- 이전 버튼 -->
								<li><a
									href="/recboard/recListCri?page=${pageVO.startPage - 1}"><i
										class="lni lni-arrow-left"></i></a></li>
							</c:if>
							<c:forEach var="i" begin="${pageVO.startPage }"
								end="${pageVO.endPage }" step="1">
								<li class="${cri.page == i ? 'active' : ''}"><a
									href="/recboard/recListCri?page=${i}">${i }</a>
								</li>
							</c:forEach>

							<c:if test="${pageVO.next}">
								<!-- 다음 버튼 -->
								<li><a
									href="/recboard/recListCri?page=${pageVO.endPage + 1}"><i
										class="lni lni-arrow-right"></i></a></li>
							</c:if>
                            </ul>
                        </div>
                    </div>
                </div>
                <!--/ End Pagination -->
            </div>
        </div>
   	</div>
</section>
<%@ include file="../include/Footer.jsp"%>