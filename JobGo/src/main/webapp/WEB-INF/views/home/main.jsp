<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/Header.jsp"%>
<script>
$(document).ready(function(){
	var status = '${msg }';
	if(status == 'loginSuccess'){
		alert('로그인 성공!');
	}
	if(status == 'dropComplete'){
		alert('정상적으로 탈퇴처리 되었습니다. 이용해 주셔서 감사합니다.');
	}
	
})
</script>
<div id="main-contents">
	<section class="job-section">
	    <div class="container">
	        <h3 class="section-title">최신 채용공고</h3>
	        <div class="row">
	            <c:forEach var="vo" items="${recMainList}">
	                <div class="col-lg-4 col-md-6 col-sm-12 mb-4">
	                    <div class="job-card" onclick="location.href='/recboard/recRead?rec_bno=${vo.rec_bno}'">
	                        <img src="/upload/recfile/${vo.thumbFileName}" 
	                             alt="${vo.rec_title}" class="job-thumb">
	                        <div class="job-body">
	                            <h5>${vo.companyName}</h5>
	                            <p>${vo.rec_title}</p>
	                            <div class="job-info">
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
	    <div class="container">
	        <h3 class="section-title">시선집중! 공고</h3>
	        <div class="row">
	            <c:forEach var="vo" items="${recMainListVW}">
	                <div class="col-lg-4 col-md-6 col-sm-12 mb-4">
	                    <div class="job-card" onclick="location.href='/recboard/recRead?rec_bno=${vo.rec_bno}'">
	                        <img src="/upload/recfile/${vo.thumbFileName}" 
	                             alt="${vo.rec_title}" class="job-thumb">
	                        <div class="job-body">
	                            <h5>${vo.companyName}</h5>
	                            <p>${vo.rec_title}</p>
	                            <div class="job-info">
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
	</section>
</div>
<%@ include file="../include/Footer.jsp"%>