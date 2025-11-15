<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../include/Header.jsp"%>
<section class="section resume-list-section py-5">
	<div class="container">
		<h2>우리 회사 지원자 현황</h2>
		<table class="table table-bordered text-center">
		    <thead>
		        <tr>
		            <th>공고명</th>
		            <th>지원자 이름</th>
		            <th>이메일</th>
		            <th>이력서 제목</th>
		            <!-- <th>상태</th> -->
		            <th>관리</th>
		        </tr>
		    </thead>
		    <tbody>
		        <c:forEach var="a" items="${applicants}">
		            <tr id="row-${a.application_id}">
		                <td>${a.rec_title}</td>
		                <td>${a.applicant_name}</td>
		                <td>${a.applicant_email}</td>
		                <td><a href="/resume/corp/view?resume_id=${a.resume_id}&application_id=${a.application_id}" class="resume-link">${a.resume_title}</a></td>
		                <%-- <td class="status-text">
		                	<c:choose>
								<c:when test="${a.status eq 'APPLIED'}">미열람</c:when>
								<c:when test="${a.status eq 'REVIEWING'}">서류 검토중</c:when>
								<c:when test="${a.status eq 'REJECTED'}">불합격</c:when>
								<c:when test="${a.status eq 'PASSED'}">합격</c:when>
								<c:when test="${a.status eq 'HIRED'}">채용완료</c:when>
							</c:choose>
		                </td> --%>
		                <td>
		                    <select class="statusChange" data-id="${a.application_id}">
		                        <option value="APPLIED" ${a.status eq 'APPLIED' ? 'selected' : ''}>지원완료</option>
		                        <option value="REVIEWING" ${a.status eq 'REVIEWING' ? 'selected' : ''}>검토중</option>
		                        <option value="PASSED" ${a.status eq 'PASSED' ? 'selected' : ''}>합격</option>
		                        <option value="REJECTED" ${a.status eq 'REJECTED' ? 'selected' : ''}>불합격</option>
		                        <option value="HIRED" ${a.status eq 'HIRED' ? 'selected' : ''}>채용완료</option>
		                    </select>
		                </td>
		            </tr>
		        </c:forEach>
		    </tbody>
		</table>
	</div>
</section>

<script>
$(function() {
	$(".statusChange").change(function() {
	    const id = $(this).data("id");
	    const status = $(this).val();
	    const row = $("#row-" + id);
	    const statusText = row.find(".status-text");
	    
	    // 한글 매핑 객체
	    const statusMap = {
	        "APPLIED": "지원완료",
	        "REVIEWING": "서류 검토중",
	        "REJECTED": "불합격",
	        "PASSED": "합격",
	        "HIRED": "채용완료"
	    };
	    
	    // 색상 피드백 (선택사항)
	    const colorMap = {
	        "APPLIED": "#6c757d",   // gray
	        "REVIEWING": "#3db2f7", // yellow
	        "REJECTED": "#dc3545",  // red
	        "PASSED": "#198754",    // green
	        "HIRED": "#0d6efd"      // blue
	    };

	    $.ajax({
	        url: "/application/corp/updateStatus",
	        type: "POST",
	        data: { application_id: id, status: status },
	        success: function(res) {
	            if (res === "success") {
	                statusText.text(statusMap[status])
	                          .css("color", colorMap[status])
	                          .hide().fadeIn(200);
	                alert("상태가 '" + statusMap[status] + "' 으로 변경되었습니다.");
	            } else {
	                alert("상태 변경 실패");
	            }
	        },
	        error: function() {
	            alert("서버 통신 오류 발생");
	        }
	    });
	});
	/* 
	$(".resume-link").click(function(e){
	  const resume = $(this).data("resume");
	  const app = $(this).data("app");
	  console.log(resume);
	  if(!resume){
	    alert("이력서 정보가 존재하지 않습니다.");
	    e.preventDefault();
	    return;
	  }
	  location.href = `/resume/corp/view?resume_id=${a.resume_id}&application_id=${a.application_id}`;
	}); */
});
</script>
<%@ include file="../include/Footer.jsp"%>