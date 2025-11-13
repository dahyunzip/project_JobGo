<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../include/Header.jsp"%>

<section class="section resume-detail-section py-5">
  <div class="container">

    <h2 class="mb-4">지원자 상세 이력서</h2>

    <!-- 지원자 프로필 -->
    <div class="applicant-profile mb-4 d-flex align-items-center">
      <c:choose>
        <c:when test="${not empty resume.storedFileName}">
          <img src="/upload/${resume.storedFileName}" 
               alt="프로필" 
               style="width:120px;height:120px;border-radius:50%;object-fit:cover;margin-right:20px;">
        </c:when>
        <c:otherwise>
          <img src="/upload/default_profile.png" 
               alt="기본 프로필" 
               style="width:120px;height:120px;border-radius:50%;object-fit:cover;margin-right:20px;">
        </c:otherwise>
      </c:choose>

      <div>
        <p><strong>이름:</strong> ${resume.userName}</p>
        <p><strong>이메일:</strong> ${resume.userEmail}</p>
        <p><strong>연락처:</strong> ${resume.userPhone}</p>
      </div>
    </div>

    <!-- 지원 상태 변경 -->
    <div class="status-section mb-4 p-3 border rounded">
      <h5 class="mb-3">입사지원 상태 변경</h5>
      <p>현재 상태: <span id="currentStatus">
		  <c:choose>
		    <c:when test="${resume.status eq 'APPLIED'}">지원완료</c:when>
		    <c:when test="${resume.status eq 'REVIEWING'}">검토중</c:when>
		    <c:when test="${resume.status eq 'PASSED'}">합격</c:when>
		    <c:when test="${resume.status eq 'REJECTED'}">불합격</c:when>
		    <c:when test="${resume.status eq 'HIRED'}">채용완료</c:when>
		  </c:choose>
		</span></p>
      <div class="d-flex align-items-center">
        <select id="statusSelect" class="form-select w-auto me-3" style="min-width:180px;">
          <option value="APPLIED"  ${resume.status eq 'APPLIED' ? 'selected' : ''}>지원완료</option>
          <option value="REVIEWING" ${resume.status eq 'REVIEWING' ? 'selected' : ''}>검토중</option>
          <option value="PASSED" ${resume.status eq 'PASSED' ? 'selected' : ''}>합격</option>
          <option value="REJECTED" ${resume.status eq 'REJECTED' ? 'selected' : ''}>불합격</option>
          <option value="HIRED" ${resume.status eq 'HIRED' ? 'selected' : ''}>채용완료</option>
        </select>
        <button id="saveStatus" class="btn btn-primary">상태 저장</button>
      </div>
    </div>

    <!-- 이력서 제목 -->
    <h4>${resume.resumeTitle}</h4>
    <%-- <p>이력서 상태: ${resume.status}</p> --%>
    <hr>

    <!-- 학력 -->
    <h5>학력사항</h5>
    <c:if test="${not empty resume.educationList}">
      <table class="table table-bordered">
        <tr><th>학교명</th><th>전공</th><th>기간</th><th>졸업여부</th></tr>
        <c:forEach var="edu" items="${resume.educationList}">
          <tr>
            <td>${edu.schoolName}</td>
            <td>${edu.major}</td>
            <td>${edu.fromDate} ~ ${edu.toDate}</td>
            <td>${edu.isGraduated}</td>
          </tr>
        </c:forEach>
      </table>
    </c:if>

    <!-- 경력 -->
    <h5>경력사항</h5>
    <c:if test="${not empty resume.careerList}">
      <table class="table table-bordered">
        <tr><th>회사명</th><th>담당업무</th><th>근무기간</th></tr>
        <c:forEach var="car" items="${resume.careerList}">
          <tr>
            <td>${car.companyName}</td>
            <td>${car.responsibility}</td>
            <td>${car.fromDate} ~ ${car.toDate}</td>
          </tr>
        </c:forEach>
      </table>
    </c:if>

    <!-- 교육이력 -->
    <h5>교육이력</h5>
    <c:if test="${not empty resume.trainingList}">
      <table class="table table-bordered">
        <tr><th>기관</th><th>내용</th><th>기간</th></tr>
        <c:forEach var="tr" items="${resume.trainingList}">
          <tr>
            <td>${tr.institution}</td>
            <td>${tr.content}</td>
            <td>${tr.fromDate} ~ ${tr.toDate}</td>
          </tr>
        </c:forEach>
      </table>
    </c:if>

    <!-- 자격증 -->
    <h5>자격사항</h5>
    <c:if test="${not empty resume.certificationList}">
      <table class="table table-bordered">
        <tr><th>자격증명</th><th>취득일자</th></tr>
        <c:forEach var="cert" items="${resume.certificationList}">
          <tr>
            <td>${cert.certificationName}</td>
            <td>${cert.acquiredDate}</td>
          </tr>
        </c:forEach>
      </table>
    </c:if>

    <!-- 자기소개 -->
    <h5>자기소개서</h5>
    <c:if test="${not empty resume.selfIntro}">
      <div class="card card-body">
        <p><strong>지원동기:</strong> ${resume.selfIntro.motivation}</p>
        <p><strong>강점 및 역량:</strong> ${resume.selfIntro.strengths}</p>
        <p><strong>주요 경험:</strong> ${resume.selfIntro.keyExperience}</p>
        <p><strong>입사 후 포부:</strong> ${resume.selfIntro.futurePlan}</p>
      </div>
    </c:if>

    <!-- 하단 버튼 -->
    <div class="mt-5 text-center">
      <a href="/application/corp/applicants" class="btn btn-secondary">← 지원자 목록으로 돌아가기</a>
    </div>

  </div>
</section>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
$(function() {
  $("#saveStatus").click(function() {
	let status = $("#statusSelect").val().trim().toUpperCase();
    const applicationId = "${application_id}";

    const statusMap = {
	      "APPLIED": "지원완료",
	      "REVIEWING": "검토중",
	      "PASSED": "합격",
	      "REJECTED": "불합격",
	      "HIRED": "채용완료"
	};
    
    $.ajax({
      url: "/application/corp/updateStatus",
      type: "POST",
      data: { application_id: applicationId, status: status },
      success: function(res) {
        if (res === "success") {
        	const statusText = statusMap[status] || status;
          alert(`상태가 '${statusMap[status]}'으로 변경되었습니다`);
          $("#currentStatus").text(statusMap[status]);
          $("#statusSelect").css("border-color", "#28a745");
        } else {
          alert("상태 변경 실패");
        }
      },
      error: function() {
        alert("서버 통신 오류");
      }
    });
  });
});
</script>

<%@ include file="../include/Footer.jsp"%>