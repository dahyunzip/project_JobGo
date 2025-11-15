<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../include/Header.jsp"%>
<script>
	$(document).ready(function(){
		var status = '${msg}';
		if(status == 'drawSuccess'){
			alert('입사지원이 취소되었습니다.');
		}else if(status == 'drawFail'){
			alert('취소 실패. 다시 시도해주세요.');
		}
	});
</script>
<section class="section">
	<h2 class="pageTitle">나의 지원 내역</h2>
	<div class="container">
		<p class="mb-10">총 <strong>${totalCount}</strong>건의 지원 내역이 있습니다.</p>
		<!-- 지원공고 테이블 -->
		<!-- 이력서 목록 테이블 -->
		<table class="table-responsive table-default">
			<colgroup>
				<col width="30%">
				<col width="*%">
				<col width="20%">
				<col width="*%">
				<col width="*%">
				<col width="20%">
			</colgroup>
			<thead>
				<tr>
					<th>채용공고</th>
					<th>기업명</th>
					<th>제출 이력서 제목</th>
					<th>지원일</th>
					<th>상태</th>
					<th>기능</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="app" items="${applications}">
					<tr>
						<td><a href="/recboard/recRead?rec_bno=${app.rec_bno }">${app.rec_title}</a></td>
						<td>${app.corp_name}</td>
						<td>${app.resume_title}</td>
						<td><fmt:formatDate value="${app.applied_at}" pattern="yyyy.MM.dd"/></td>
						<td>
							<c:choose>
								<c:when test="${app.status eq 'APPLIED'}">지원완료</c:when>
								<c:when test="${app.status eq 'REVIEWING'}">서류 검토중</c:when>
								<c:when test="${app.status eq 'REJECTED'}">불합격</c:when>
								<c:when test="${app.status eq 'PASSED'}">합격</c:when>
								<c:when test="${app.status eq 'HIRED'}">채용완료</c:when>
							</c:choose>
						</td>
						<td>
							<c:if test="${app.status eq 'APPLIED'}">
								<form method="post" action="/application/withdraw">
									<input type="hidden" name="application_id"
										value="${app.application_id}">
									<button type="submit">지원 취소</button>
								</form>
							</c:if>
						</td>
					</tr>
				</c:forEach>
				<c:if test="${empty applications}">
					<tr>
						<td colspan="6">지원한 공고가 없습니다.</td>
					</tr>
				</c:if>
			</tbody>
		</table>
		<!-- Pagination -->
		<div class="row">
			<div class="col-12">
				<div class="pagination center">
				    <ul class="pagination-list">
				        <c:if test="${pageVO.prev}">
				            <li><a href="/application/list?page=${pageVO.startPage - 1}"><i class="lni lni-arrow-left"></i></a></li>
				        </c:if>
				
				        <c:forEach var="i" begin="${pageVO.startPage}" end="${pageVO.endPage}" step="1">
				            <li class="${cri.page == i ? 'active' : ''}">
				                <a href="/application/list?page=${i}">${i}</a>
				            </li>
				        </c:forEach>
				
				        <c:if test="${pageVO.next}">
				            <li><a href="/application/list?page=${pageVO.endPage + 1}"><i class="lni lni-arrow-right"></i></a></li>
				        </c:if>
				    </ul>
				</div>
			</div>
		</div>
		<!--/ End Pagination -->
	</div>
</section>
<%@ include file="../include/Footer.jsp"%>