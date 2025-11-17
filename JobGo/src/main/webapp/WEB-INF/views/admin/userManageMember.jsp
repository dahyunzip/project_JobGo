<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="header.jsp" %>

<style>
	.row-deleted {
		opacity: 0.4;
		color: #888;
	}
</style>

<div class="container-fluid">
	<h2 class="mb-4">일반회원 관리</h2>

	<table class="table table-bordered text-center">
		<thead class="bg-light">
			<tr>
				<th>ID</th>
				<th>아이디</th>
				<th>이름</th>
				<th>이메일</th>
				<th>전화번호</th>
				<th>회원유형</th>
				<th>관리</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="m" items="${memberList}">
				<tr class="${m.deleted ? 'row-deleted' : ''}">
					<td>${m.id}</td>
					<td>${m.userid}</td>
					<td>${m.name}</td>
					<td>${m.email}</td>
					<td>${m.phone}</td>
					<td>${m.membertype}</td>
					<td>
						<c:choose>
							<c:when test="${m.deleted}">
								<span class="text-muted">삭제됨</span>
							</c:when>
							<c:otherwise>
								<a href="${pageContext.request.contextPath}/admin/deleteMember?id=${m.id}"
				   				onclick="return confirm('정말 삭제하시겠습니까?');"
				   				class="btn btn-sm btn-danger">
									삭제
								</a>
							</c:otherwise>
						</c:choose>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<div class="d-flex justify-content-center mt-4">
		<ul class="pagination">
	
			<!-- 이전 버튼 -->
			<c:if test="${pageVO.prev}">
				<li class="page-item">
					<a class="page-link"
					   href="?page=${pageVO.startPage - 1}&pageSize=${pageVO.cri.pageSize}">
						이전
					</a>
				</li>
			</c:if>
	
			<!-- 페이지 번호 -->
			<c:forEach var="num" begin="${pageVO.startPage}" end="${pageVO.endPage}">
				<li class="page-item ${pageVO.cri.page == num ? 'active' : ''}">
					<a class="page-link"
					   href="?page=${num}&pageSize=${pageVO.cri.pageSize}">
						${num}
					</a>
				</li>
			</c:forEach>
	
			<!-- 다음 버튼 -->
			<c:if test="${pageVO.next}">
				<li class="page-item">
					<a class="page-link"
					   href="?page=${pageVO.endPage + 1}&pageSize=${pageVO.cri.pageSize}">
						다음
					</a>
				</li>
			</c:if>
		</ul>
	</div>
</div>

<%@ include file="footer.jsp"%>