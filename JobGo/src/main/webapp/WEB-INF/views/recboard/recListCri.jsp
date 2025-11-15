<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/Header.jsp"%>
<style>
	.job-wrap {
	    display: flex;
	    flex-wrap: wrap;
	    gap: 20px;
	    justify-content: flex-start;
	}
	
	.single-job {
	    position: relative;
	    width: calc(50% - 10px);
	    border-radius: 30px;
	    overflow: hidden;
	    margin: 10px 0;
	    cursor: pointer;
	    transition: transform 0.2s ease-in-out;
	    background: #000;
	}
	
	.single-job:hover { 
		transform: scale(1.02); 
	}

	.thumb-area {
	    position: relative;
	    width: 100%;
	    height: 180px;
	    border-radius: 30px;
	}
	.thumb-area img {
	    width: 100%;
	    height: 100%;
	    object-fit: cover;
	    display: block;
	}

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
	
	.filter-section select { 
		border-radius: 10px; 
	}
</style>
<section class="find-job job-list section">
  <div class="container">
    <c:set var="cri" value="${recPageVO.cri}" scope="page" />  
    <div class="single-head">
      <div class="row">
        <div class="col-12">

          <!-- 필터 영역 -->
          <div class="filter-section mb-4">
  			<form id="filterForm" action="/recboard/recListCri" method="get" class="row g-3">

              <!-- 지역 선택 -->
		     <div class="col-lg-6">
			    <label for="toplct" class="form-label fw-bold">지역 선택</label>
			      <select id="toplct" name="toplct_id" class="form-select">
			        <option value="">-- 지역 선택 --</option>
			        <c:forEach var="loc" items="${topLocationList}">
			          <option value="${loc.toplct_id}" ${loc.toplct_id == param.toplct_id ? 'selected' : ''}>
			            ${loc.toplct_name}
			          </option>
			        </c:forEach>
			      </select>
		     </div>

              <!-- 직무 선택 -->
              <div class="col-lg-6">
                <label for="topctg" class="form-label fw-bold">직무 선택</label>
                <select id="topctg" name="topctg_id" class="form-select">
                  <option value="">-- 직무 대분류 선택 --</option>
                  <c:forEach var="top" items="${topCategoryList}">
                    <option value="${top.topctg_id}" ${top.topctg_id == param.topctg_id ? 'selected' : ''}>
                      ${top.topctg_name}
                    </option>
                  </c:forEach>
                </select>
              </div>

              <div class="col-12 text-end mt-3">
                <button type="submit" class="btn btn-primary">검색</button>
                <button type="button" id="resetBtn" class="btn btn-outline-secondary">초기화</button>
              </div>
            </form>
          </div>
          <hr>

          <!-- 키워드 검색 -->
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
          <!-- 게시글 리스트 -->
			<div class="box-wrap">
				<div class="job-wrap">
					<c:forEach var="vo" items="${recBoardList}">
						<div class="single-job" onclick="location.href='/recboard/recRead?rec_bno=${vo.rec_bno}&recPage=${cri.recPage}'">
						 	<div class="thumb-area">
						        <img src="/upload/recfile/${vo.thumbFileName}">
						        <div class="overlay-text">
						            <h3 class="company">${vo.rec_title}</h3>
						            <p class="title">${vo.companyName}</p>
						            <div class="info">
						                <span>근무지: ${vo.rec_inputlct}</span>
						                <span>작성일: <fmt:formatDate value="${vo.rec_regdate}" pattern="yyyy.MM.dd"/></span>
						                <span>조회수: ${vo.rec_viewcnt}</span>
						            </div>
						        </div>
						    </div>
						</div>
					</c:forEach>
				</div>
			</div>
        </div>
      </div>

     <!-- 페이지네이션 -->
      <div class="row">
        <div class="col-12">
          <c:if test="${not empty recLoginInfo and empty loginUserId}">
            <div class="button mt-20 text-right">
              <a href="/recboard/recWrite"><button type="button" class="btn">글쓰기</button></a>
            </div>
          </c:if>
          <div class="pagination center">
            <ul class="pagination-list">
              <c:if test="${recPageVO.prev}">
                <li><a href="/recboard/recListCri?recPage=${recPageVO.startPage - 1}"><i class="lni lni-arrow-left"></i></a></li>
              </c:if>

              <c:forEach var="i" begin="${recPageVO.startPage}" end="${recPageVO.endPage}" step="1">
                <li class="${cri.recPage == i ? 'active' : ''}">
                  <a href="/recboard/recListCri?recPage=${i}">${i}</a>
                </li>
              </c:forEach>

              <c:if test="${recPageVO.next}">
                <li><a href="/recboard/recListCri?recPage=${recPageVO.endPage + 1}"><i class="lni lni-arrow-right"></i></a></li>
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