<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JobGo 기업회원 페이지</title>
	
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
								<h3>기업회원 페이지</h3>
								<%-- <img class="logo1" src="${pageContext.request.contextPath }/resources/images/logo/logo.svg" alt="Logo" /> --%>
							</a>
						</nav>
					</div>
					<div id="searchBar" class="col-lg-4 col-xs-12">
						<input type="text" placeholder="검색어를 입력하세요" name="search" class="form-control">
					</div>
				</div>
				<div class="col-lg-12">
					<nav class="navbar navbar-expand-lg">
						<div class="collapse navbar-collapse sub-menu-bar"
							id="navbarSupportedContent">
							<ul id="nav" class="navbar-nav">
								<li class="nav-item"><a href="#">채용 공고 관리</a></li>
								<li class="nav-item"><a href="#">지원자 현황</a></li>
								<li class="nav-item"><a href="#">공지사항</a></li>
								<li class="nav-item"><a href="#">기업리뷰</a></li>
							</ul>
						</div>
						<!-- navbar collapse -->
						<div class="button">
						    <c:choose>
						        <c:when test="${not empty corpUserId}">
						            <a href="/corp/logout" class="login">
						                <i class="lni lni-lock-alt"></i> 로그아웃
						            </a>
						        </c:when>
						        <c:otherwise>
						            <a href="/corp/login" class="login">
						                <i class="lni lni-lock-alt"></i> 로그인
						            </a>
						            <a href="/corp/join" class="btn">
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