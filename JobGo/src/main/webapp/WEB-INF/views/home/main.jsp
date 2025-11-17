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
    
    var slider = tns({
        container: '.my-slider',
        items: 1,               // 한 화면에 1개
        slideBy: 1,             // 1개씩 이동
        autoplay: true,         // 자동 슬라이드
        autoplayTimeout: 5000,  // 3초 간격
        autoplayButtonOutput: false,  // 자동재생 버튼 숨기기
        mouseDrag: true,        // 드래그 가능
        controls: true,         // Prev/Next 버튼
        //nav: true,              // 점 네비게이션
        speed: 1000,             // 슬라이드 전환 속도
        loop: true,             // 무한반복
        gutter: 0               // 슬라이드 간격 없음
      });
    
    $(".tns-controls button[data-controls='prev']").html('<i class="lni lni-arrow-left"></i>');

    $(".tns-controls button[data-controls='next']").html('<i class="lni lni-arrow-right"></i>');
});
</script>

<div id="main-contents">

	<section class="mainTop">
		<div class="fix-layout">
			<div class="banner ">
				<div class="my-slider">
					<div>
						<img src="/resources/images/banner_img01.png" class="slide-img">
					</div>
					<div>
						<img src="/resources/images/banner_img02.png" class="slide-img">
					</div>
					<div>
						<img src="/resources/images/banner_img03.png" class="slide-img">
					</div>
				</div>
			</div>
			<div class="mypage">
				<c:choose>
				    <c:when test="${not empty loginMember}">
				        <div class="user-dashboard">
				            <h4>${loginMember.name} 님 환영합니다!</h4>
				            <div class="mem">
				                <span>📄 등록한 이력서</span>
				                <span><strong onclick="location.href='/resume/list?memberId=${loginMember.id}'">${resumeCount}</strong> 개</span>
				            </div>
				            <div class="mem">
				                <span>📝 지원한 채용공고</span>
				                <span><strong onclick="location.href='/application/list'">${applyCount}</strong> 건</span>
				            </div>
				        </div>
				        <ul class="quickMenu">
				        	<li>
				        		<a href="/application/list"><i>📝</i>지원현황</a>
				        	</li>
				        	<li>
				        		<a href="/resume/list?memberId=${loginMember.id}"><i>📄</i>이력서관리</a>
				        	</li>
				        	<li>
				        		<a href="/member/mypage"><i>⚙️</i>마이페이지</a>
				        	</li>
				        </ul>
				    </c:when>
				
				    <c:otherwise>
				        <div class="user-dashboard guest">
				            <h4>반가워요! 👋</h4>
				            <p>더 많은 기능을 이용하려면 로그인 해주세요.</p>
				            <a href="/member/login" class="login-btn">로그인 하러가기</a>
				        </div>
				    </c:otherwise>
				</c:choose>
			</div>
		</div>
	</section>

	
	<section class="job-section">
	    <div class="fix-layout">
	        <h3 class="section-title wow fadeInUp">최신 채용공고</h3>
	        <p class="mtitle wow fadeInUp" data-wow-delay=".2s">가장 빠르게 올라온 공고들을 모아 보여드려요.<br>놓치지 말고 지금 바로 지원하세요.</p>
	        <p class="more wow fadeInUp" data-wow-delay=".4s">
	        	<a href="/recboard/recListCri" class="moreBtn"><i class="lni lni-plus"></i></a>
	        </p>
	        <div class="jobBoardWrap  wow fadeInUp" data-wow-delay=".6s">
	            <c:forEach var="vo" items="${recMainList}">
	                <div class="list">
	                    <div class="job-card" onclick="location.href='/recboard/recRead?rec_bno=${vo.rec_bno}'">
	                        <c:choose>
								<c:when test="${empty vo.thumbFileName}">
									<img src="/resources/images/default_image.jpg" class="job-thumb">
								</c:when>
								<c:otherwise>
									<img src="/upload/${vo.thumbFileName}" alt="${vo.rec_title}" class="job-thumb" onerror="this.onerror=null; this.src='/resources/images/default_image.jpg'">
								</c:otherwise>
							</c:choose>
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

	    <div class="fix-layout mt-80">
	        <h3 class="section-title wow fadeInUp">시선집중! 인기 채용공고</h3>
	        <p class="mtitle wow fadeInUp mb-50" data-wow-delay=".2s">지원자들이 가장 많이 주목하고 있는 공고예요.<br>지금 가장 ‘핫’한 기회를 확인해보세요!</p>
	        <div class="jobBoardWrap wow fadeInUp" data-wow-delay=".4s">
	            <c:forEach var="vo" items="${recMainListVW}">
	                <div class="list">
	                    <div class="job-card" onclick="location.href='/recboard/recRead?rec_bno=${vo.rec_bno}'">
	                        <c:choose>
								<c:when test="${empty vo.thumbFileName}">
									<img src="/resources/images/default_image.jpg" class="job-thumb">
								</c:when>
								<c:otherwise>
									<img src="/upload/recfile/${vo.thumbFileName}" alt="${vo.rec_title}" class="job-thumb" onerror="this.onerror=null; this.src='/resources/images/default_image.jpg'">
								</c:otherwise>
							</c:choose>
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
	
	<div id="reviewSec" class="mt-80">
		<div class="fix-layout">
			<!-- 리뷰 -->
			<div class="col-lg-12 mb-4">
				<div class="boardWrap">
					<h3 class="section-title wow fadeInUp">생생한 이용자 리뷰</h3>
					<p class="mtitle wow fadeInUp">구직자들이 직접 남긴 평가와 경험을 확인해보세요.<br>신뢰할 수 있는 커뮤니티의 목소리를 담았습니다.</p>
			        <p class="more wow fadeInUp">
			        	<a href="/review/reviewList" class="moreBtn"><i class="lni lni-plus"></i></a>
			        </p>
					<ul class="rvBoard">
						<c:forEach var="r" items="${reviewList}">
							<li class="wow fadeInUp">
								<a href="/review/reviewDetail?reviewId=${r.reviewId}">
									<span class="userProf">
										<c:choose>
											<c:when test="${empty r.storedFileName}">
												<img src="/resources/images/default_image.jpg" class="profile-img" onerror="this.onerror=null; this.src='/resources/images/default_image.jpg'">
											</c:when>
											<c:otherwise>
												<img src="/upload/${r.storedFileName}" class="profile-img" onerror="this.onerror=null; this.src='/resources/images/default_image.jpg'">
											</c:otherwise>
										</c:choose>
									</span>
									<span class="score">
										<c:forEach begin="1" end="5" var="i">
											<c:choose>
												<c:when test="${i <= r.revRate}">★</c:when>
												<c:otherwise>☆</c:otherwise>
											</c:choose>
										</c:forEach>
									</span>
									<span class="title">${r.revTitle }</span>
									<span class="text">${r.revContent}</span>
								</a> 
							</li>
						</c:forEach>
					</ul>
				</div>
			</div>
		</div>
	</div>

	<div class="board-wrapper mt-80">
	    <div class="fix-layout">
	    	<div class="row">
		        <!-- 공지사항 -->
		        <div class="col-lg-6 col-md-12 col-sm-12 mb-4 ">
		        	<div class="listhead wow fadeInUp">
			        	<h3 class="section-title text-left">공지사항</h3>
			        	<p class="more">
				        	<a href="/notice/list" class="moreBtn"><i class="lni lni-plus"></i></a>
				        </p>
		        	</div>
		            <div class="board-box">
		                <ul>
		                    <c:forEach var="n" items="${noticeList}">
		                        <li class="wow fadeInUp">
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
		        <div class="col-lg-6 col-md-12 col-sm-12 mb-4">
		        	<div class="listhead wow fadeInUp">
			        	<h3 class="section-title text-left">커뮤니티</h3>
			        	<p class="more">
				        	<a href="/comboard/comListCri" class="moreBtn"><i class="lni lni-plus"></i></a>
				        </p>
		        	</div>
		            <div class="board-box">
		                <ul>
		                    <c:forEach var="c" items="${communityList}">
		                        <li class="wow fadeInUp">
		                            <a href="/comboard/comRead?com_bno=${c.com_bno}">
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