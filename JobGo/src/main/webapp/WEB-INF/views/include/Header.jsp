<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JobGo</title>

<link rel="shortcut icon" type="image/x-icon"
	href="${pageContext.request.contextPath }/resources/images/favicon.svg" />
<!-- Web Font -->
<link
	href="https://fonts.googleapis.com/css2?family=Inter:wght@100;200;300;400;500;600;700;800;900&display=swap"
	rel="stylesheet">

<!-- ========================= CSS here ========================= -->
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/bootstrap.min.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/LineIcons.2.0.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/animate.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/tiny-slider.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/glightbox.min.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/main.css" />
</head>
<body>
	<div id="loading-area"></div>
	<!-- Start Header Area -->
	<header class="header">
		<div class="navbar-area">
			<div class="container">
				<div class="row align-items-center">
					<div class="col-lg-12">
						<nav class="navbar navbar-expand-lg">
							<a class="navbar-brand logo" href="/"> <img
								class="logo1" src="${pageContext.request.contextPath }/resources/images/logo/logo.svg" alt="Logo" />
							</a>
						</nav>
						<!-- navbar -->
					</div>
					<div class="col-lg-12">
						<nav class="navbar navbar-expand-lg">
							<div class="collapse navbar-collapse sub-menu-bar"
								id="navbarSupportedContent">
								<ul id="nav" class="navbar-nav">
									<li class="nav-item"><a href="#">채용공고</a>
										<ul class="sub-menu">
											<li><a href="about-us.html">About Us</a></li>
										</ul>
									</li>
									<li class="nav-item"><a href="#">커리어관리</a></li>
									<li class="nav-item"><a href="#">기업리뷰</a></li>
									<li class="nav-item"><a href="#">커뮤니티</a></li>
								</ul>
							</div>
							<!-- navbar collapse -->
							<div class="button">
								<a href="/member/login" class="login">
									<i class="lni lni-lock-alt"></i>
									로그인
								</a>
								<a href="/member/join" class="btn">회원가입</a>
							</div>
						</nav>
						<!-- navbar -->
					</div>
				</div>
				<!-- row -->
			</div>
			<!-- container -->
		</div>
		<!-- navbar area -->
	</header>
	<!-- End Header Area -->
	<div id="contents">