<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/Header.jsp"%>
<style>
	.single-job {
	    position: relative;
	    border-radius: 30px;         /* 모서리 둥글게 */
	    overflow: hidden;            /* 이미지가 밖으로 삐져나오지 않게 */
	    margin: 10px 0;
	    cursor: pointer;
	    transition: transform 0.2s ease-in-out;
	    background: #000;            /* 여백 없이 꽉 차게 */
	}
	.single-job:hover {
	    transform: scale(1.02);
	}
	
	/* 이미지 영역 */
	.thumb-area {
	    position: relative;
	    width: 100%;
	    height: 180px;               /* 높이를 기존보다 살짝 낮게 */
	    border-radius: 30px;
	}
	.thumb-area img {
	    width: 100%;
	    height: 100%;
	    object-fit: cover;           /* 비율 유지하면서 꽉 채움 */
	    display: block;
	}
	
	/* 텍스트 오버레이 */
	.overlay-text {
	    position: absolute;
	    bottom: 0;
	    left: 0;
	    width: 100%;
	    padding: 15px 20px;
	    background: linear-gradient(to top, rgba(0,0,0,0.75), rgba(0,0,0,0));
	    color: #fff;
	}
	
	.overlay-text .company {
	    font-size: 18px;
	    font-weight: 700;
	    margin: 0;
	}
	.overlay-text .title {
	    font-size: 14px;
	    margin: 4px 0 8px;
	}
	.overlay-text .info {
	    font-size: 12px;
	    opacity: 0.9;
	}
	.overlay-text .info span {
	    margin-right: 8px;
	}
</style>
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
									<div class="single-job" onclick="location.href='/recboard/recRead?rec_bno=${vo.rec_bno}&page=${cri.page}'">
									 	<div class="thumb-area">
									        <img src="/upload/recfile/${vo.thumbFileName}">
									        <div class="overlay-text">
									            <h3 class="company">${vo.companyName}</h3>
									            <p class="title">${vo.rec_title}</p>
									            <div class="info">
									                <span>작성자: ${vo.corpUserId}</span>
									                <span>작성일: <fmt:formatDate value="${vo.rec_regdate}" pattern="yyyy.MM.dd"/></span>
									                <span>조회수: ${vo.rec_viewcnt}</span>
									            </div>
									        </div>
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
	                    <c:if test="${!empty recLoginInfo}">
							<div class="button mt-20 text-right">
								<a href="/recboard/recWrite">
								<button type="button"
										class="btn">글쓰기</button></a>
							</div>
						</c:if>
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