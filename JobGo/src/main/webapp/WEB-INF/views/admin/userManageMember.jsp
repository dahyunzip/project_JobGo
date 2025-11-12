<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="header.jsp" %>


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
				<tr>
					<td>${m.id}</td>
					<td>${m.userid}</td>
					<td>${m.name}</td>
					<td>${m.email}</td>
					<td>${m.phone}</td>
					<td>${m.membertype}</td>
					<td>
						<a href="${pageContext.request.contextPath}/admin/deleteMember?id=${m.id}"
						   onclick="return confirm('정말 삭제하시겠습니까?');"
						   class="btn btn-sm btn-danger">삭제</a>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>

<%@ include file="footer.jsp"%>