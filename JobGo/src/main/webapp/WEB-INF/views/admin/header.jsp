<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>잡고 관리자</title>
<!-- Custom fonts for this template-->
	<link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath }/resources/images/favicon.svg" />
    <link href="${pageContext.request.contextPath }/resources/css/all.min.css" rel="stylesheet" type="text/css">
    <link
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="${pageContext.request.contextPath }/resources/css/sb-admin-2.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/icons.css" />
    <link href="${pageContext.request.contextPath }/resources/css/adminSub.css" rel="stylesheet">
    
    <!-- ========================= JS here ========================= -->
    <script src="${pageContext.request.contextPath }/resources/js/all.min.js"></script>
</head>
<!-- Sidebar -->
<body id="page-top">
	<div id="wrapper">
		<ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">
		
		    <!-- Sidebar - Brand -->
		    <a class="sidebar-brand d-flex align-items-center justify-content-center" href="/admin/home">
		        <div class="sidebar-brand-text mx-3">JobGo<sup>Admin</sup></div>
		    </a>
		
		    <!-- Divider -->
		    <hr class="sidebar-divider my-0">
		
		    <!-- Nav Item - Dashboard -->
		    <li class="nav-item active">
		        <a class="nav-link" href="/admin/home">
		            <i class="fas fa-fw fa-tachometer-alt"></i>
		            <span>Dashboard</span></a>
		    </li>
		
		    <!-- Divider -->
		    <hr class="sidebar-divider">
		
		    <!-- Heading -->
		    <div class="sidebar-heading">
		        서비스 관리
		    </div>
		
		    <!-- Nav Item - Pages Collapse Menu -->
		    <li class="nav-item">
		        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseTwo"
		            aria-expanded="true" aria-controls="collapseTwo">
		            <i class="fas fa-fw fa-cog"></i>
		            <span>게시판 관리</span>
		        </a>
		        <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
		            <div class="bg-white py-2 collapse-inner rounded">
		                <h6 class="collapse-header">게시판관리</h6>
		                <a class="collapse-item" href="/admin/corpBoard">채용공고</a>
		                <a class="collapse-item" href="${pageContext.request.contextPath}/admin/reviewManage">리뷰관리</a>
		                <a class="collapse-item" href="${pageContext.request.contextPath}/admin/noticeManage">공지사항관리</a>
		            </div>
		        </div>
		    </li>
		
		    <!-- Nav Item - Utilities Collapse Menu -->
		    <li class="nav-item">
		        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseUtilities" aria-expanded="true" aria-controls="collapseUtilities">
		            <i class="fas fa-fw fa-wrench"></i>
		            <span>사용자관리</span>
		        </a>
		        <div id="collapseUtilities" class="collapse" aria-labelledby="headingUtilities" data-parent="#accordionSidebar">
		            <div class="bg-white py-2 collapse-inner rounded">
		                <h6 class="collapse-header">사용자관리</h6>
		                <a class="collapse-item" href="/admin/userManageMember">일반회원관리</a>
		                <a class="collapse-item" href="/admin/userManageCorp">기업회원관리</a>
		            </div>
		        </div>
		    </li>
		</ul>
	<!-- End of Sidebar -->
	<div id="content-wrapper" class="d-flex flex-column">
		<!-- Main Content -->
		<div id="content">
			<!-- Topbar -->
			<nav
				class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">
	
				<!-- Sidebar Toggle (Topbar) -->
				<button id="sidebarToggleTop"
					class="btn btn-link d-md-none rounded-circle mr-3">
					<i class="fa fa-bars"></i>
				</button>
	
				<!-- Topbar Navbar -->
				<ul class="navbar-nav ml-auto">
					<!-- Nav Item - User Information -->
					<li class="nav-item dropdown no-arrow">
						<a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
							<span class="mr-2 d-none d-lg-inline text-gray-600 small">${sessionScope.adminSession} 님</span>
						</a> 
						<!-- Dropdown - User Information -->
						<div class="dropdown-menu dropdown-menu-right shadow animated--grow-in" aria-labelledby="userDropdown" onclick="location.href='/admin/logout'">
							<a class="dropdown-item" href="/admin/logout" data-toggle="modal" data-target="#logoutModal">
								<i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
								Logout
							</a>
						</div>
					</li>
				</ul>
			</nav>
	
	
	
	
	
	
	
	<!-- Bootstrap core JavaScript-->
    <script src="${pageContext.request.contextPath }/resources/vendor/jquery/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath }/resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
    <script src="${pageContext.request.contextPath }/resources/vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Custom scripts for all pages-->
    <script src="${pageContext.request.contextPath }/resources/js/sb-admin-2.min.js"></script>

    <!-- Page level plugins -->
    <script src="${pageContext.request.contextPath }/resources/vendor/chart.js/Chart.min.js"></script>

    <!-- Page level custom scripts -->
    <script src="${pageContext.request.contextPath }/resources/js/demo/chart-area-demo.js"></script>
    <script src="${pageContext.request.contextPath }/resources/js/demo/chart-pie-demo.js"></script>