<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/Header.jsp"%>
<section class="hero-area">
	<!-- Single Slider -->
	<div class="hero-inner">
		<div class="container">
			<div class="row ">
				<div class="col-lg-6 co-12">
					<div class="inner-content">
						<div class="hero-text">
							<h1 class="wow fadeInUp" data-wow-delay=".3s"
								style="visibility: visible; animation-delay: 0.3s; animation-name: fadeInUp;">
								JobGo 메인 페이지 
							</h1>
							<c:choose>
						        <c:when test="${not empty id}">
						            <h2>${memberName }님 안녕하세요.</h2>


						        </c:when>
						        <c:otherwise>
						            <h2>로그인 후 이용하세요</h2>
						        </c:otherwise>
						    </c:choose>
							
							<p class="wow fadeInUp" data-wow-delay=".5s"
								style="visibility: visible; animation-delay: 0.5s; animation-name: fadeInUp;">
								제작중입니다.
							</p>
						</div>
						<div class="job-search-wrap-two mt-50 wow fadeInUp" data-wow-delay=".7s"
							style="visibility: visible; animation-delay: 0.7s; animation-name: fadeInUp;">
							
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!--/ End Single Slider -->
</section>
<%@ include file="../include/Footer.jsp"%>