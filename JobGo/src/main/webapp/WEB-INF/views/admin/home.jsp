<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="header.jsp"%>
<!-- Begin Page Content -->
<div class="container-fluid mb-5">
	<div class="container mt-4">
		<h2>
			<strong>관리자 대시보드</strong>
		</h2>

		<!-- ================== 회원 현황 ================== -->
		<div class="section-title">회원 현황</div>
		<div class="dashboard-grid">

			<div class="stat-card">
				<div class="stat-icon bg-blue">
					<i class="lni lni-user-4"></i>
				</div>
				<div>
					<div class="stat-title">전체 회원</div>
					<div class="stat-value">${totalMembers}명</div>
				</div>
			</div>

			<div class="stat-card">
				<div class="stat-icon bg-green">
					<i class="lni lni-user-4"></i>
				</div>
				<div>
					<div class="stat-title">일반 회원</div>
					<div class="stat-value">${generalMembers}명</div>
				</div>
			</div>

			<div class="stat-card">
				<div class="stat-icon bg-purple">
					<i class="lni lni-user-4"></i>
				</div>
				<div>
					<div class="stat-title">기업 회원</div>
					<div class="stat-value">${corpMembers}명</div>
				</div>
			</div>
		</div>


		<!-- ================== 채용공고 현황 ================== -->
		<div class="section-title">채용공고 현황</div>
		<div class="dashboard-grid">

			<div class="stat-card">
				<div class="stat-icon bg-orange">
					<i class="lni lni-buildings-1"></i>
				</div>
				<div>
					<div class="stat-title">전체 공고</div>
					<div class="stat-value">${totalRecruits}건</div>
				</div>
			</div>

			<div class="stat-card">
				<div class="stat-icon bg-green">
					<i class="lni lni-buildings-1"></i>
				</div>
				<div>
					<div class="stat-title">이번 주 신규 공고</div>
					<div class="stat-value">${weeklyRecruits}건</div>
				</div>
			</div>
		</div>


		<!-- ================== 공지사항 ================== -->
		<div class="section-title">공지사항</div>
		<div class="dashboard-grid">

			<div class="stat-card">
				<div class="stat-icon bg-purple">
					<i class="lni lni-bell-1"></i>
				</div>
				<div>
					<div class="stat-title">전체 공지</div>
					<div class="stat-value">${totalNotice}개</div>
				</div>
			</div>

			<div class="stat-card">
				<div class="stat-icon bg-gray">
					<i class="lni lni-bell-1"></i>
				</div>
				<div>
					<div class="stat-title">최근 공지</div>
					<div class="stat-value" style="font-size: 16px;">
						<c:if test="${not empty latestNotice}">
                        ${latestNotice}
                    </c:if>
						<c:if test="${empty latestNotice}">
                        등록된 공지가 없습니다.
                    </c:if>
					</div>
				</div>
			</div>
		</div>


		<!-- ================== 리뷰 현황 ================== -->
		<div class="section-title">리뷰 현황</div>
		<div class="dashboard-grid">

			<div class="stat-card">
				<div class="stat-icon bg-orange">
					<i class="lni lni-pencil-1"></i>
				</div>
				<div>
					<div class="stat-title">전체 리뷰</div>
					<div class="stat-value">${totalReview}개</div>
				</div>
			</div>

			<div class="stat-card">
				<div class="stat-icon bg-green">
					<i class="lni lni-pencil-1"></i>
				</div>
				<div>
					<div class="stat-title">오늘 등록 리뷰</div>
					<div class="stat-value">${todayReview}개</div>
				</div>
			</div>
		</div>

	</div>
</div>
<!-- /.container-fluid -->

<!-- #wrapper 끝 -->
<%@ include file="footer.jsp"%>