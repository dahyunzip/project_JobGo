<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="header.jsp" %>

<div class="container-fluid">
	<h2 class="mb-4">기업회원 관리</h2>

	<table class="table table-bordered text-center">
		<thead class="bg-light">
			<tr>
				<th>ID</th>
				<th>아이디</th>
				<th>회사명</th>
				<th>이메일</th>
				<th>전화번호</th>
				<th>산업분류</th>
				<th>관리</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="corp" items="${corpList}">
				<tr>
					<td>${corp.corpId}</td>
					<td>${corp.corpUserid}</td>
					<td>${corp.companyName}</td>
					<td>${corp.managerEmail}</td>
					<td>${corp.managerTel}</td>
					<td>${corp.industryType}</td>
					<td>
						<a href="${pageContext.request.contextPath}/admin/deleteCorp?id=${corp.corpId}"
						   onclick="return confirm('정말 삭제하시겠습니까?');"
						   class="btn btn-sm btn-danger">삭제</a>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>

<%@ include file="footer.jsp"%>