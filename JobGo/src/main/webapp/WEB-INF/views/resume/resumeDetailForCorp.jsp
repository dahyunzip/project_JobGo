<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../include/Header.jsp"%>

<section class="section py-5">
  <div class="container">
    <h2>지원자 이력서 상세보기</h2>
    <hr>

    <h4>${resume.resumeTitle}</h4><%-- 
    <p><strong>이름:</strong> ${resume.name}</p>
    <p><strong>이메일:</strong> ${resume.email}</p> --%>
    <p><strong>자기소개:</strong> ${resume.selfIntro}</p>
    <hr>

    <div class="d-flex align-items-center gap-3">
      <label for="statusSelect" class="fw-bold">지원 상태 변경:</label>
      <select id="statusSelect" class="form-select w-auto">
        <option value="APPLIED">미열람</option>
        <option value="REVIEWING">서류 검토중</option>
        <option value="PASSED">합격</option>
        <option value="REJECTED">불합격</option>
        <option value="HIRED">채용완료</option>
      </select>
      <button id="saveStatus" class="btn btn-primary">변경</button>
    </div>
  </div>
</section>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
$(function() {
  $("#saveStatus").click(function() {
    const status = $("#statusSelect").val();
    const applicationId = "${application_id}";

    $.ajax({
      url: "/application/corp/updateStatus",
      type: "POST",
      data: { application_id: applicationId, status: status },
      success: function(res) {
        if (res === "success") {
          alert("상태가 변경되었습니다.");
        } else {
          alert("상태 변경 실패 😢");
        }
      },
      error: function() {
        alert("서버 통신 오류 ⚠️");
      }
    });
  });
});
</script>

<%@ include file="../include/Footer.jsp"%>