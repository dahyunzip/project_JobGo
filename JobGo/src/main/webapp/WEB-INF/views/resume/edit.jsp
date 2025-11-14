<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="../include/Header.jsp"%>

<section class="add-resume section">
    <div class="section-title">
        <h2>이력서 수정</h2>
    </div>
    <div class="container my-5">
        <div class="row">
            <div class="col-lg-10 offset-lg-1 col-12">
                <div class="add-resume-inner box p-4 shadow-sm bg-white rounded">
                    <div class="post-header text-center mb-4">
                        <h3>이력서 수정</h3>
                        <p>기존 정보를 수정하거나 새로운 내용을 추가하세요.</p>
                    </div>

                    <!-- FORM -->
                    <form class="form-ad" action="/resume/edit" method="post">
                        <input type="hidden" name="resumeId" value="${resume.resumeId}" />
                        <input type="hidden" name="memberId" value="${resume.memberId}" />
	                    <input type="hidden" name="status" value="${resume.status}" />

                        <!-- 기본 정보 -->
                        <h4 class="mb-3">기본 정보</h4>
                        <div class="row">
                            <div class="col-lg-12 col-12">
                                <div class="form-group">
                                    <label class="control-label">이력서 제목</label>
                                    <input type="text" class="form-control" name="resumeTitle" 
                                           value="${resume.resumeTitle}" required>
                                </div>
                            </div>
                        </div>

                        <hr>

                        <!-- 학력사항 -->
                        <h4 class="single-section-title mt-4">학력사항</h4>
                        <div id="educationSection">
                            <c:forEach var="edu" items="${resume.educationList}" varStatus="st">
                                <div class="edu-item border p-3 rounded mb-3 bg-light">
                                    <div class="form-row">
                                        <div class="form-group col-md-6">
                                            <label>학교명</label>
                                            <input type="text" class="form-control" 
                                                   name="educationList[${st.index}].schoolName" 
                                                   value="${edu.schoolName}">
                                        </div>
                                        <div class="form-group col-md-6">
                                            <label>전공</label>
                                            <input type="text" class="form-control" 
                                                   name="educationList[${st.index}].major" 
                                                   value="${edu.major}">
                                        </div>
                                    </div>
                                    <div class="form-row">
                                        <div class="form-group col-md-6">
                                            <label>입학일</label>
                                            <input type="date" class="form-control"
                                                   name="educationList[${st.index}].fromDate"
                                                   value="<fmt:formatDate value='${edu.fromDate}' pattern='yyyy-MM-dd'/>">
                                        </div>
                                        <div class="form-group col-md-6">
                                            <label>졸업일</label>
                                            <input type="date" class="form-control"
                                                   name="educationList[${st.index}].toDate"
                                                   value="<fmt:formatDate value='${edu.toDate}' pattern='yyyy-MM-dd'/>">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label>졸업 여부</label>
                                        <select class="form-control" name="educationList[${st.index}].isGraduated">
                                            <option value="Y" ${edu.isGraduated eq 'Y' ? 'selected' : ''}>졸업</option>
                                            <option value="N" ${edu.isGraduated eq 'N' ? 'selected' : ''}>재학/중퇴</option>
                                        </select>
                                    </div>
                                </div>
                            </c:forEach>
                            <button type="button" class="btn btn-secondary btn-sm add-edu">
                                <i class="lni lni-add-files"></i> 학력 추가
                            </button>
                        </div>

                        <hr>

                        <!-- 경력사항 -->
                        <h4 class="single-section-title mt-4">경력사항</h4>
                        <div id="careerSection">
                            <c:forEach var="career" items="${resume.careerList}" varStatus="st">
                                <div class="career-item border p-3 rounded mb-3 bg-light">
                                    <div class="form-row">
                                        <div class="form-group col-md-6">
                                            <label>회사명</label>
                                            <input type="text" class="form-control"
                                                   name="careerList[${st.index}].companyName" 
                                                   value="${career.companyName}">
                                        </div>
                                        <div class="form-group col-md-6">
                                            <label>담당 업무</label>
                                            <input type="text" class="form-control"
                                                   name="careerList[${st.index}].responsibility" 
                                                   value="${career.responsibility}">
                                        </div>
                                    </div>
                                    <div class="form-row">
                                        <div class="form-group col-md-6">
                                            <label>입사일</label>
                                            <input type="date" class="form-control"
                                                   name="careerList[${st.index}].fromDate"
                                                   value="<fmt:formatDate value='${career.fromDate}' pattern='yyyy-MM-dd'/>">
                                        </div>
                                        <div class="form-group col-md-6">
                                            <label>퇴사일</label>
                                            <input type="date" class="form-control"
                                                   name="careerList[${st.index}].toDate"
                                                   value="<fmt:formatDate value='${career.toDate}' pattern='yyyy-MM-dd'/>">
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                            <button type="button" class="btn btn-secondary btn-sm add-career">
                                <i class="lni lni-add-files"></i> 경력 추가
                            </button>
                        </div>

                        <hr>

                        <!-- 자격사항 -->
                        <h4 class="single-section-title mt-4">자격사항</h4>
                        <div id="certSection">
                            <c:forEach var="cert" items="${resume.certificationList}" varStatus="st">
                                <div class="cert-item border p-3 rounded mb-3 bg-light">
                                    <div class="form-row">
                                        <div class="form-group col-md-8">
                                            <label>자격명</label>
                                            <input type="text" class="form-control"
                                                   name="certificationList[${st.index}].certificationName" 
                                                   value="${cert.certificationName}">
                                        </div>
                                        <div class="form-group col-md-4">
                                            <label>취득일</label>
                                            <input type="date" class="form-control"
                                                   name="certificationList[${st.index}].acquiredDate"
                                                   value="<fmt:formatDate value='${cert.acquiredDate}' pattern='yyyy-MM-dd'/>">
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                            <button type="button" class="btn btn-secondary btn-sm add-cert">
                                <i class="lni lni-add-files"></i> 자격 추가
                            </button>
                        </div>

                        <hr>

                        <!-- 자기소개서 -->
                        <h4 class="single-section-title mt-4">자기소개서</h4>
                        <div class="border p-3 rounded bg-light mb-4">
                            <div class="form-group">
                                <label>지원 동기</label>
                                <textarea class="form-control" rows="4" name="selfIntro.motivation">${resume.selfIntro.motivation}</textarea>
                            </div>
                            <div class="form-group">
                                <label>강점 및 역량</label>
                                <textarea class="form-control" rows="4" name="selfIntro.strengths">${resume.selfIntro.strengths}</textarea>
                            </div>
                            <div class="form-group">
                                <label>성과나 중요한 경험</label>
                                <textarea class="form-control" rows="4" name="selfIntro.keyExperience">${resume.selfIntro.keyExperience}</textarea>
                            </div>
                            <div class="form-group">
                                <label>입사 후 포부</label>
                                <textarea class="form-control" rows="4" name="selfIntro.futurePlan">${resume.selfIntro.futurePlan}</textarea>
                            </div>
                        </div>

                        <!-- Submit -->
                        <div class="text-center mt-4">
                            <button type="submit" formaction="/resume/tempSave" class="btn btn-secondary btn-lg">임시 저장</button>
                            <button type="submit" formaction="/resume/submitFinal" class="btn btn-primary btn-lg">최종 저장</button>
                            <a href="/resume/detail?resumeId=${resume.resumeId}" class="btn btn-outline-secondary btn-lg">취소</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</section>


<script>
$(document).ready(function(){
  let eduIdx = ${fn:length(resume.educationList)};
  let careerIdx = ${fn:length(resume.careerList)};
  let certIdx = ${fn:length(resume.certificationList)};
  
  $('.add-edu').click(function() {
    $('#educationSection').append(`
      <div class="edu-item border p-3 rounded mb-3 bg-light">
        <div class="form-row">
          <div class="form-group col-md-6">
            <label>학교명</label>
            <input type="text" class="form-control" name="educationList[${eduIdx}].schoolName">
          </div>
          <div class="form-group col-md-6">
            <label>전공</label>
            <input type="text" class="form-control" name="educationList[${eduIdx}].major">
          </div>
        </div>
      </div>
    `);
    eduIdx++;
  });
});
</script>

<%@ include file="../include/Footer.jsp"%>