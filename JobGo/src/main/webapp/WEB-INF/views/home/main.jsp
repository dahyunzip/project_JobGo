<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="../include/Header.jsp"%>

<script>
$(document).ready(function(){
    var status = '${msg}';
    if(status === 'loginSuccess'){
        alert('로그인 성공!');
    }
    if(status === 'dropComplete'){
        alert('정상적으로 탈퇴처리 되었습니다.');
    }
});
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
	                        	<h5>${vo.rec_title}</h5>
	                            <p>${vo.companyName}</p>
	                            <%-- <div class="job-info">
	                                <span>작성자: ${vo.corpUserId}</span>
	                                <span>작성일: <fmt:formatDate value="${vo.rec_regdate}" pattern="yyyy-MM-dd"/></span>
	                                <span>조회수: ${vo.rec_viewcnt}</span>
	                            </div> --%>
	                        </div>
	                    </div>
	                </div>
	            </c:forEach>
	        </div>
	    </div>

	    <div class="container mt-5">
	        <h3 class="section-title">시선집중! 공고</h3>
	        <div class="row">
	            <c:forEach var="vo" items="${recMainListVW}">
	                <div class="col-lg-4 col-md-6 col-sm-12 mb-4">
	                    <div class="job-card" onclick="location.href='/recboard/recRead?rec_bno=${vo.rec_bno}'">
	                        <img src="/upload/recfile/${vo.thumbFileName}" 
	                             alt="${vo.rec_title}" class="job-thumb">
	                        <div class="job-body">
	                        	<h5>${vo.rec_title}</h5>
	                            <p>${vo.companyName}</p>
	                            <%-- <div class="job-info">
	                                <span>작성자: ${vo.corpUserId}</span>
	                                <span>작성일: <fmt:formatDate value="${vo.rec_regdate}" pattern="yyyy-MM-dd"/></span>
	                                <span>조회수: ${vo.rec_viewcnt}</span>
	                            </div> --%>
	                        </div>
	                    </div>
	                </div>
	            </c:forEach>
	        </div>
	    </div>
	</section>

	<div class="container">
		<!-- 리뷰 -->
		<div class="col-lg-12 mb-4">
			<div class="board-box">
				<h3 class="section-title">리뷰</h3>
				<ul>
					<c:forEach var="r" items="${reviewList}">
						<li><a href="/review/reviewDetail?reviewId=${r.reviewId}">
								<c:choose>
									<c:when test="${empty r.storedFileName}">
										<img src="/images/default-profile.png" class="profile-img">
									</c:when>
									<c:otherwise>
										<img src="/upload/${r.storedFileName}" class="profile-img">
									</c:otherwise>
								</c:choose> <span class="title">${r.revTitle }</span> <span class="text">${r.revContent}</p>
						</a> <span class="score">${r.revRate}점</span></li>
					</c:forEach>
				</ul>
			</div>
		</div>
	</div>

	<div class="board-wrapper">
	    <div class="container">
	    	<div class="row">
		        <!-- 공지사항 -->
		        <div class="col-lg-6 col-sm-12 mb-4">
		            <div class="board-box">
		                <h3 class="section-title">공지사항</h3>
		                <ul>
		                    <c:forEach var="n" items="${noticeList}">
		                        <li>
		                            <a href="/notice/detail?noticeId=${n.noticeId}">
		                                ${n.noticeTitle}
		                            </a>
		                            <span class="date">
		                                <fmt:formatDate value="${n.noticeRegdate}" pattern="yyyy-MM-dd"/>
		                            </span>
		                        </li>
		                    </c:forEach>
		                </ul>
		            </div>
		        </div>
	
		        <!-- 커뮤니티 -->
		        <div class="col-lg-6 col-sm-12 mb-4">
		            <div class="board-box">
		                <h3 class="section-title">커뮤니티</h3>
		                <ul>
		                    <c:forEach var="c" items="${communityList}">
		                        <li>
		                            <a href="/community/detail?postId=${c.com_bno}">
		                                ${c.com_title}
		                            </a>
		                            <span class="date">
		                                <fmt:formatDate value="${c.com_regdate}" pattern="yyyy-MM-dd"/>
		                            </span>
		                        </li>
		                    </c:forEach>
		                </ul>
		            </div>
		        </div>
	        </div>
        </div>
	</div>
</div>

<%@ include file="../include/Footer.jsp"%>