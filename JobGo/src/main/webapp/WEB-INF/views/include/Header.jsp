<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JobGo</title>
	
	<link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath }/resources/images/favicon.svg" />
	<!-- Web Font -->
	<link href="https://fonts.googleapis.com/css2?family=Inter:wght@100;200;300;400;500;600;700;800;900&display=swap" rel="stylesheet">
	
	<!-- ========================= CSS here ========================= -->
	<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/bootstrap.min.css" />
	<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/LineIcons.2.0.css" />
	<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/animate.css" />
	<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/tiny-slider.css" />
	<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/glightbox.min.css" />
	<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/reset.css" />
	<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/common.css" />
	<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/template.css" />
	<c:if test='${pageContext.request.requestURI != "/"}'>
		<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/sub.css" />
	</c:if>
	
	<!-- ========================= JS here ========================= -->
	<script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.1.js" type="text/javascript"></script>
</head>
<body>
	<c:set var="uri" value="${requestScope['javax.servlet.forward.request_uri']}" />
	<div id="loading-area"></div>
	<!-- Start Header Area -->
	<header class="header <c:if test='${uri != "/"}'>other-page</c:if>">
		<div class="navbar-area">
			<div class="fix-layout">
				<div class="row mt-10">
					<div class="col-lg-8 col-xs-12">
						<nav class="navbar navbar-expand-lg">
							<a class="navbar-brand logo" href="/">
								<h3>
								<c:choose>
									<c:when test="${not empty sessionScope.corpUserId}">기업회원</c:when>
									<c:when test="${not empty sessionScope.userid}">일반회원</c:when>
									<c:otherwise>JobGo</c:otherwise>
								</c:choose>
								&nbsp;페이지
								</h3>
							</a>
						</nav>
					</div>
					<div id="searchBar" class="col-lg-4 col-xs-12" style="display:flex; gap:5px;">
					    <!-- 검색 종류 선택 -->
					    <select id="searchType" class="form-control" style="max-width:120px;">
					        <option value="com">커뮤니티</option>
					        <option value="rec">채용공고</option>
					    </select>
					
					    <!-- 검색창 -->
					    <input type="text" id="headerSearchInput" placeholder="<= 게시판 선택 후 검색어 입력" class="form-control">
					</div>
				</div>
				<div class="col-lg-12">
					<nav class="navbar navbar-expand-lg">
						<div class="collapse navbar-collapse sub-menu-bar" id="navbarSupportedContent">
							<ul id="nav" class="navbar-nav">
								<c:choose>
									<%-- 기업회원 메뉴 --%>
									<c:when test="${not empty sessionScope.corpUserId}">
										<li class="nav-item"><a href="${pageContext.request.contextPath }/recboard/recListCri">채용 공고 관리</a></li>
										<li class="nav-item"><a href="#">지원자 현황</a></li>
										<li class="nav-item"><a href="${pageContext.request.contextPath }/review/reviewList">기업리뷰</a></li>
										<li class="nav-item"><a href="${pageContext.request.contextPath }/comboard/comListCri">커뮤니티</a>
											<ul class="sub-menu">
												<li><a href="${pageContext.request.contextPath }/notice/list">공지사항</a></li>
												<li><a href="${pageContext.request.contextPath }/comboard/comListCri">커뮤니티</a></li>
											</ul>
										</li>
									</c:when>
									
									<%-- 일반회원 메뉴 --%>
									<c:when test="${not empty sessionScope.userid}">
										<li class="nav-item"><a href="${pageContext.request.contextPath }/recboard/recListCri">채용공고</a></li>
										<li class="nav-item"><a href="${pageContext.request.contextPath }/resume/list?memberId=${sessionScope.memberId}">커리어관리</a></li>
										<li class="nav-item"><a href="${pageContext.request.contextPath }/review/reviewList">기업리뷰</a></li>
										<li class="nav-item"><a href="${pageContext.request.contextPath }/comboard/comListCri">커뮤니티</a>
											<ul class="sub-menu">
												<li><a href="${pageContext.request.contextPath }/notice/list">공지사항</a></li>
												<li><a href="${pageContext.request.contextPath }/comboard/comListCri">커뮤니티</a></li>
											</ul>
										</li>
									</c:when>
	
									<%-- 비로그인 회원 공용 메뉴 --%>
									<c:otherwise>
										<li class="nav-item"><a href="${pageContext.request.contextPath }/recboard/recListCri">채용공고</a></li>
										<li class="nav-item"><a href="${pageContext.request.contextPath }/review/reviewList">기업리뷰</a></li>
										<li class="nav-item"><a href="${pageContext.request.contextPath }/comboard/comListCri">커뮤니티</a>
											<ul class="sub-menu">
												<li><a href="${pageContext.request.contextPath }/notice/list">공지사항</a></li>
												<li><a href="${pageContext.request.contextPath }/comboard/comListCri">커뮤니티</a></li>
											</ul>
										</li>
									</c:otherwise>
								</c:choose>
							</ul>
						</div>
						<div class="button">
							<c:choose>
								<%-- 기업회원 로그인 상태 --%>
								<c:when test="${not empty sessionScope.corpUserId}">
									<a href="${pageContext.request.contextPath }/corp/logout" class="login">
										<i class="lni lni-lock-alt"></i> 로그아웃
									</a>
									<a href="${pageContext.request.contextPath }/corp/mypage" class="btn">
										마이페이지
									</a>
								</c:when>
	
								<%-- 일반회원 로그인 상태 --%>
								<c:when test="${not empty sessionScope.userid}">
									<a href="${pageContext.request.contextPath }/member/logout" class="login">
										<i class="lni lni-lock-alt"></i> 로그아웃
									</a>
									<a href="${pageContext.request.contextPath }/member/mypage" class="btn">
										마이페이지
									</a>
								</c:when>
	
								<%-- 비로그인 상태 --%>
								<c:otherwise>
									<a href="${pageContext.request.contextPath }/member/login" class="login">
										<i class="lni lni-lock-alt"></i> 로그인
									</a>
									<a href="${pageContext.request.contextPath }/member/join" class="btn">
										회원가입
									</a>
								</c:otherwise>
							</c:choose>
						</div>
					</nav>
					<!-- navbar -->
				</div>
				<!-- row -->
			</div>
			<!-- container -->
		</div>
		<!-- navbar area -->
	</header>
	<!-- End Header Area -->
	<div id="contents">
	<script>
		$(document).ready(function(){
		
		    // 검색 실행 함수
		    function doSearch() {
		        const type = $("#searchType").val(); 
		        const keyword = $("#headerSearchInput").val().trim();
		
		        if(keyword == "") {
		            alert("검색어를 입력하세요.");
		            return;
		        }
		
		        let url = "";
		
		        if(type == "com") {
		            // 커뮤니티 게시판
		            url = "/comboard/comListCri?search=" + encodeURIComponent(keyword);
		        } else if(type == "rec") {
		            // 채용공고 게시판
		            url = "/recboard/recListCri?search=" + encodeURIComponent(keyword);
		        }
		
		        location.href = url;
		    }
		
		    // 엔터키 검색
		    $("#headerSearchInput").keypress(function(e){
		        if(e.keyCode == 13){
		            doSearch();
		        }
		    });
		
		});
	</script>