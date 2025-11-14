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
	<h2 class="mb-4">기업회원 관리</h2>

	<table class="table table-bordered text-center">
		<thead class="bg-light">
			<tr>
				<th>ID</th>
				<th>아이디</th>
				<th>회사명</th>
				<th>사업자번호</th>
				<th>사업자등록증</th>
				<th>이메일</th>
				<th>전화번호</th>
				<th>산업분류</th>
				<th>상태</th>
				<th>관리</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="corp" items="${corpList}">
				<tr class="${corp.corpCheckDeleted ? 'row-deleted' : ''}">
					<td>${corp.corpId}</td>
					<td>${corp.corpUserId}</td>
					<td>${corp.companyName}</td>
					<td>${corp.businessRno}</td>
					<td>사업자등록증?</td>
					<td>${corp.managerEmail}</td>
					<td>${corp.managerTel}</td>
					<td>${corp.industryType}</td>
					<td>
    					<c:choose>
    						<c:when test="${corp.corpCheckDeleted}">
            					<span class="text-muted">삭제됨</span>
        					</c:when>
        					<c:when test="${corp.status eq 'A'}">
            					<a href="${pageContext.request.contextPath}/admin/denyCorp?id=${corp.corpId}"
               						onclick="return confirm('해당 기업을 비활성화하시겠습니까?');"
               						class="btn btn-sm btn-warning">
                					비활성화
            					</a>
	        				</c:when>
        					<c:when test="${corp.status eq 'D'}">
            					<a href="${pageContext.request.contextPath}/admin/approveCorp?id=${corp.corpId}"
               					onclick="return confirm('해당 기업을 승인(활성화)하시겠습니까?');"
               					class="btn btn-sm btn-success">
                					활성화
            					</a>
        					</c:when>
        					<c:otherwise>
            					<span class="text-muted">대기중</span>
        					</c:otherwise>

    					</c:choose>
					</td>
					<td>
						<c:choose>
							<c:when test="${corp.status eq 'W'}">
            					<a href="${pageContext.request.contextPath}/admin/approveCorp?id=${corp.corpId}"
								   class="btn btn-sm btn-success">승인</a>
            					<a href="${pageContext.request.contextPath}/admin/denyCorp?id=${corp.corpId}"
               					   class="btn btn-sm btn-warning">거절</a>
        					</c:when>

        					
        					<c:when test="${corp.status eq 'A'}">
        					    <a href="${pageContext.request.contextPath}/admin/deleteCorp?id=${corp.corpId}"
        					       onclick="return confirm('정말 삭제하시겠습니까?');"
            					   class="btn btn-sm btn-danger">삭제</a>
        					</c:when>

					       
        					<c:when test="${corp.status eq 'D'}">
        					    <span class="text-muted">거절됨</span>
    					    </c:when>
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