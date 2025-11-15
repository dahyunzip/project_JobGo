<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="header.jsp" %>
<style>
/* 기존 스타일 유지 */

/* PDF 모달 추가 스타일 */
.pdf-modal {
    display: none;
    position: fixed;
    z-index: 1000;
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.7);
}

.pdf-modal-content {
    background-color: #fff;
    margin: 2% auto;
    padding: 0;
    width: 90%;
    height: 90%;
    border-radius: 8px;
    box-shadow: 0 8px 24px rgba(0,0,0,0.3);
    display: flex;
    flex-direction: column;
}

.pdf-modal-header {
    padding: 15px 20px;
    background-color: #f8f9fa;
    border-bottom: 1px solid #dee2e6;
    display: flex;
    justify-content: space-between;
    align-items: center;
    border-radius: 8px 8px 0 0;
}

.pdf-modal-header h3 {
    margin: 0;
    font-size: 1.2rem;
    font-weight: 600;
    color: #111827;
}

.pdf-modal-actions {
    display: flex;
    gap: 10px;
}

.pdf-modal-actions button {
    padding: 6px 12px;
    border-radius: 4px;
    border: 1px solid #d1d5db;
    background-color: #fff;
    cursor: pointer;
    font-size: 0.9rem;
}

.pdf-modal-actions button:hover {
    background-color: #f3f4f6;
}

.pdf-modal-actions .btn-download {
    background-color: #2563EB;
    color: white;
    border-color: #2563EB;
}

.pdf-modal-actions .btn-download:hover {
    background-color: #1d4ed8;
}

.pdf-modal-body {
    flex: 1;
    padding: 20px;
    overflow: hidden;
}

.pdf-modal-body iframe {
    width: 100%;
    height: 100%;
    border: none;
    border-radius: 4px;
}

.close-pdf {
    color: #6b7280;
    font-size: 28px;
    font-weight: bold;
    cursor: pointer;
    border: none;
    background: none;
    padding: 0;
    width: 30px;
    height: 30px;
    display: flex;
    align-items: center;
    justify-content: center;
}

.close-pdf:hover {
    color: #111827;
}
.row-deleted {
    opacity: 0.4; color: #888;}
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
					<td>
                        <button type="button" 
                                class="btn btn-sm btn-outline-primary view-pdf" 
                                data-corp-id="${corp.corpId}"
                                data-file-name="${corp.originalFileName}">
                            <i class="fas fa-file-pdf"></i> ${corp.originalFileName}
                        </button>
                    </td>
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
               						onclick="return confirm('해당 기업회원을 비활성화하시겠습니까?');"
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
					<a class="page-link" href="?page=${pageVO.startPage - 1}&pageSize=${pageVO.cri.pageSize}">
						<i class="lni lni-arrow-left"></i>
					</a>
				</li>
			</c:if>
	
			<!-- 페이지 번호 -->
			<c:forEach var="num" begin="${pageVO.startPage}" end="${pageVO.endPage}" step="1">
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
					<a class="page-link" href="?page=${pageVO.endPage + 1}&pageSize=${pageVO.cri.pageSize}">
						<i class="lni lni-arrow-right"></i>
					</a>
				</li>
			</c:if>
		</ul>
	</div>
</div>
<!-- PDF 뷰어 모달 -->
<div id="pdfModal" class="pdf-modal">
    <div class="pdf-modal-content">
        <div class="pdf-modal-header">
            <h3>사업자등록증</h3>
            <div class="pdf-modal-actions">
                <button type="button" class="btn-download" id="downloadBtn">
                    <i class="fas fa-download"></i> 다운로드
                </button>
                <button type="button" class="close-pdf">&times;</button>
            </div>
        </div>
        <div class="pdf-modal-body">
            <iframe id="pdfViewer"></iframe>
        </div>
    </div>
</div>
<script>
$(document).ready(function(){
    let currentCorpId = null;

    $('.view-pdf').click(function(){
        currentCorpId = $(this).data('corp-id');
        const fileName = $(this).data('file-name');
        
        const pdfUrl = '${pageContext.request.contextPath}/admin/viewBusinessLicense?corpId=' + currentCorpId;
        $('#pdfViewer').attr('src', pdfUrl);
        $('#pdfModal').fadeIn();
    });

    $('#downloadBtn').click(function(){
        if (currentCorpId) {
            window.location.href = '${pageContext.request.contextPath}/admin/downloadBusinessLicense?corpId=' + currentCorpId;
        }
    });

    $('.close-pdf').click(function(){
        $('#pdfModal').fadeOut();
        $('#pdfViewer').attr('src', '');
        currentCorpId = null;
    });

    
    $(window).click(function(e){
        if ($(e.target).is('#pdfModal')) {
            $('#pdfModal').fadeOut();
            $('#pdfViewer').attr('src', '');
            currentCorpId = null;
        }
    });
});
</script>
<%@ include file="footer.jsp"%>