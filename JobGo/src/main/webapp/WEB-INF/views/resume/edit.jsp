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
                                    <button type="button" class="btn btn-danger btn-sm remove-edu">
					                    <i class="lni lni-trash"></i> 삭제
					                </button>
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
                                    <button type="button" class="btn btn-danger btn-sm remove-career">
					                    <i class="lni lni-trash"></i> 삭제
					                </button>
                                </div>
                            </c:forEach>
                            <button type="button" class="btn btn-secondary btn-sm add-career">
                                <i class="lni lni-add-files"></i> 경력 추가
                            </button>
                        </div>

                        <hr>

						<!-- 교육이력 -->
						<h4 class="single-section-title mt-4">교육이력</h4>
						<div id="trainingSection">
						    <c:forEach var="training" items="${resume.trainingList}" varStatus="st">
						        <div class="training-item border p-3 rounded mb-3 bg-light">
						            <div class="form-row">
						                <div class="form-group col-md-6">
						                    <label>기관명</label>
						                    <input type="text" class="form-control" 
						                           name="trainingList[${st.index}].institution" 
						                           value="${training.institution}"
						                           placeholder="예: ITWILL 부산교육센터">
						                </div>
						                <div class="form-group col-md-6">
						                    <label>교육 내용</label>
						                    <input type="text" class="form-control" 
						                           name="trainingList[${st.index}].content" 
						                           value="${training.content}"
						                           placeholder="예: 웹퍼블리셔 과정">
						                </div>
						            </div>
						            <div class="form-row">
						                <div class="form-group col-md-6">
						                    <label>시작일</label>
						                    <input type="date" class="form-control" 
						                           name="trainingList[${st.index}].fromDate"
						                           value="<fmt:formatDate value='${training.fromDate}' pattern='yyyy-MM-dd'/>">
						                </div>
						                <div class="form-group col-md-6">
						                    <label>종료일</label>
						                    <input type="date" class="form-control" 
						                           name="trainingList[${st.index}].toDate"
						                           value="<fmt:formatDate value='${training.toDate}' pattern='yyyy-MM-dd'/>">
						                </div>
						            </div>
                                    <button type="button" class="btn btn-danger btn-sm remove-training">
					                    <i class="lni lni-trash"></i> 삭제
					                </button>
						        </div>
						    </c:forEach>
						    <button type="button" class="btn btn-secondary btn-sm add-training">
						        <i class="lni lni-add-files"></i> 교육 추가
						    </button>
						</div>
							
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
                                    <button type="button" class="btn btn-danger btn-sm remove-cert">
					                    <i class="lni lni-trash"></i> 삭제
					                </button>
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
						        <textarea class="form-control" rows="4" name="selfIntro.motivation" id="motivation">${resume.selfIntro.motivation}</textarea>
						        <div class="mt-2">
						            <button type="button" class="btn btn-outline-primary btn-sm gpt-request" data-target="motivation">
						                GPT 첨삭 요청
						            </button>
						        </div>
						        <!-- GPT 첨삭 결과 영역 -->
						        <div class="gpt-result mt-3 p-3 border rounded bg-white" id="gpt-result-motivation" style="display:none;">
						            <h6>GPT 첨삭 결과</h6>
						            <pre id="gpt-content-motivation" style="white-space:pre-wrap;"></pre>
						            <button type="button" class="btn btn-success btn-sm mt-2 use-gpt" data-target="motivation">첨삭내용 사용하기</button>
						        </div>
						    </div>
						    <div class="form-group">
						        <label>강점 및 역량</label>
						        <textarea class="form-control" rows="4" name="selfIntro.strengths" id="strengths">${resume.selfIntro.strengths}</textarea>
						        <div class="mt-2">
						            <button type="button" class="btn btn-outline-primary btn-sm gpt-request" data-target="strengths">
						                GPT 첨삭 요청
						            </button>
						        </div>
						        <!-- GPT 첨삭 결과 영역 -->
						        <div class="gpt-result mt-3 p-3 border rounded bg-white" id="gpt-result-strengths" style="display:none;">
						            <h6>GPT 첨삭 결과</h6>
						            <pre id="gpt-content-strengths" style="white-space:pre-wrap;"></pre>
						            <button type="button" class="btn btn-success btn-sm mt-2 use-gpt" data-target="strengths">첨삭내용 사용하기</button>
						        </div>
						    </div>
						    <div class="form-group">
						        <label>성과나 중요한 경험</label>
						        <textarea class="form-control" rows="4" name="selfIntro.keyExperience" id="keyExperience">${resume.selfIntro.keyExperience}</textarea>
						        <div class="mt-2">
						            <button type="button" class="btn btn-outline-primary btn-sm gpt-request" data-target="keyExperience">
						                GPT 첨삭 요청
						            </button>
						        </div>
						        <!-- GPT 첨삭 결과 영역 -->
						        <div class="gpt-result mt-3 p-3 border rounded bg-white" id="gpt-result-keyExperience" style="display:none;">
						            <h6>GPT 첨삭 결과</h6>
						            <pre id="gpt-content-keyExperience" style="white-space:pre-wrap;"></pre>
						            <button type="button" class="btn btn-success btn-sm mt-2 use-gpt" data-target="keyExperience">첨삭내용 사용하기</button>
						        </div>
						    </div>
						    <div class="form-group">
						        <label>입사 후 포부</label>
						        <textarea class="form-control" rows="4" name="selfIntro.futurePlan" id="futurePlan">${resume.selfIntro.futurePlan}</textarea>
						        <div class="mt-2">
						            <button type="button" class="btn btn-outline-primary btn-sm gpt-request" data-target="futurePlan">
						                GPT 첨삭 요청
						            </button>
						        </div>
						        <!-- GPT 첨삭 결과 영역 -->
						        <div class="gpt-result mt-3 p-3 border rounded bg-white" id="gpt-result-futurePlan" style="display:none;">
						            <h6>GPT 첨삭 결과</h6>
						            <pre id="gpt-content-futurePlan" style="white-space:pre-wrap;"></pre>
						            <button type="button" class="btn btn-success btn-sm mt-2 use-gpt" data-target="futurePlan">첨삭내용 사용하기</button>
						        </div>
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
  let trainIdx = ${fn:length(resume.trainingList)};
  let certIdx = ${fn:length(resume.certificationList)};
  
//===== 학력 추가 =====
  $('.add-edu').on('click', function() {
      console.log('현재 eduIdx:', eduIdx); // 디버깅용
      
      let html = '<div class="edu-item border p-3 rounded mb-3 bg-light">' +
              '<div class="form-row">' +
                  '<div class="form-group col-md-6">' +
                      '<label>학교명</label>' +
                      '<input type="text" class="form-control" name="educationList[' + eduIdx + '].schoolName" placeholder="학교명">' +
                  '</div>' +
                  '<div class="form-group col-md-6">' +
                      '<label>전공</label>' +
                      '<input type="text" class="form-control" name="educationList[' + eduIdx + '].major" placeholder="전공명">' +
                  '</div>' +
              '</div>' +
              '<div class="form-row">' +
                  '<div class="form-group col-md-6">' +
                      '<label>입학일</label>' +
                      '<input type="date" class="form-control" name="educationList[' + eduIdx + '].fromDate">' +
                  '</div>' +
                  '<div class="form-group col-md-6">' +
                      '<label>졸업일</label>' +
                      '<input type="date" class="form-control" name="educationList[' + eduIdx + '].toDate">' +
                  '</div>' +
              '</div>' +
              '<div class="form-group">' +
                  '<label>졸업 여부</label>' +
                  '<select class="form-control" name="educationList[' + eduIdx + '].isGraduated">' +
                      '<option value="Y">졸업</option>' +
                      '<option value="N">재학/중퇴</option>' +
                  '</select>' +
              '</div>' +
              '<button type="button" class="btn btn-danger btn-sm remove-edu">' +
                  '<i class="lni lni-trash"></i> 삭제' +
              '</button>' +
          '</div>';
          
      $('#educationSection .add-edu').before(html);
      
      // 추가 후 확인
      console.log('추가된 항목의 name:', 
          $('#educationSection .edu-item:last input:first').attr('name'));
      
      eduIdx++;
  });

  // ===== 학력 삭제 =====
  $(document).on('click', '.remove-edu', function() {
      if ($('.edu-item').length > 1) {
          $(this).closest('.edu-item').remove();
          reindexItems('.edu-item', 'educationList');
      } else {
          alert('최소 1개의 학력은 유지되어야 합니다.');
      }
  });

  // ===== 경력 추가 =====
  $('.add-career').on('click', function() {
      console.log('현재 careerIdx:', careerIdx);
      
      let html = '<div class="career-item border p-3 rounded mb-3 bg-light">' +
              '<div class="form-row">' +
                  '<div class="form-group col-md-6">' +
                      '<label>회사명</label>' +
                      '<input type="text" class="form-control" name="careerList[' + careerIdx + '].companyName" placeholder="회사명">' +
                  '</div>' +
                  '<div class="form-group col-md-6">' +
                      '<label>담당 업무</label>' +
                      '<input type="text" class="form-control" name="careerList[' + careerIdx + '].responsibility" placeholder="담당업무">' +
                  '</div>' +
              '</div>' +
              '<div class="form-row">' +
                  '<div class="form-group col-md-6">' +
                      '<label>입사일</label>' +
                      '<input type="date" class="form-control" name="careerList[' + careerIdx + '].fromDate">' +
                  '</div>' +
                  '<div class="form-group col-md-6">' +
                      '<label>퇴사일</label>' +
                      '<input type="date" class="form-control" name="careerList[' + careerIdx + '].toDate">' +
                  '</div>' +
              '</div>' +
              '<button type="button" class="btn btn-danger btn-sm remove-career">' +
                  '<i class="lni lni-trash"></i> 삭제' +
              '</button>' +
          '</div>';
          
      $('#careerSection .add-career').before(html);
      careerIdx++;
  });

  // ===== 경력 삭제 =====
  $(document).on('click', '.remove-career', function() {
      if ($('.career-item').length > 1) {
          $(this).closest('.career-item').remove();
          reindexItems('.career-item', 'careerList');
      } else {
          alert('최소 1개의 경력은 유지되어야 합니다.');
      }
  });

  // ===== 교육이력 추가 =====
  $('.add-training').on('click', function() {
      console.log('현재 trainIdx:', trainIdx);
      
      let html = '<div class="training-item border p-3 rounded mb-3 bg-light">' +
              '<div class="form-row">' +
                  '<div class="form-group col-md-6">' +
                      '<label>기관명</label>' +
                      '<input type="text" class="form-control" name="trainingList[' + trainIdx + '].institution" placeholder="교육기관명">' +
                  '</div>' +
                  '<div class="form-group col-md-6">' +
                      '<label>교육 내용</label>' +
                      '<input type="text" class="form-control" name="trainingList[' + trainIdx + '].content" placeholder="교육내용">' +
                  '</div>' +
              '</div>' +
              '<div class="form-row">' +
                  '<div class="form-group col-md-6">' +
                      '<label>시작일</label>' +
                      '<input type="date" class="form-control" name="trainingList[' + trainIdx + '].fromDate">' +
                  '</div>' +
                  '<div class="form-group col-md-6">' +
                      '<label>종료일</label>' +
                      '<input type="date" class="form-control" name="trainingList[' + trainIdx + '].toDate">' +
                  '</div>' +
              '</div>' +
              '<button type="button" class="btn btn-danger btn-sm remove-training">' +
                  '<i class="lni lni-trash"></i> 삭제' +
              '</button>' +
          '</div>';
          
      $('#trainingSection .add-training').before(html);
      trainIdx++;
  });

  // ===== 교육이력 삭제 =====
  $(document).on('click', '.remove-training', function() {
      if ($('.training-item').length > 1) {
          $(this).closest('.training-item').remove();
          reindexItems('.training-item', 'trainingList');
      } else {
          alert('최소 1개의 교육이력은 유지되어야 합니다.');
      }
  });

  // ===== 자격 추가 =====
  $('.add-cert').on('click', function() {
      console.log('현재 certIdx:', certIdx);
      
      let html = '<div class="cert-item border p-3 rounded mb-3 bg-light">' +
              '<div class="form-row">' +
                  '<div class="form-group col-md-8">' +
                      '<label>자격명</label>' +
                      '<input type="text" class="form-control" name="certificationList[' + certIdx + '].certificationName" placeholder="취득 자격명">' +
                  '</div>' +
                  '<div class="form-group col-md-4">' +
                      '<label>취득일</label>' +
                      '<input type="date" class="form-control" name="certificationList[' + certIdx + '].acquiredDate">' +
                  '</div>' +
              '</div>' +
              '<button type="button" class="btn btn-danger btn-sm remove-cert">' +
                  '<i class="lni lni-trash"></i> 삭제' +
              '</button>' +
          '</div>';
          
      $('#certSection .add-cert').before(html);
      certIdx++;
  });

  // ===== 자격 삭제 =====
  $(document).on('click', '.remove-cert', function() {
      if ($('.cert-item').length > 1) {
          $(this).closest('.cert-item').remove();
          reindexItems('.cert-item', 'certificationList');
      } else {
          alert('최소 1개의 자격은 유지되어야 합니다.');
      }
  });

  // ===== 인덱스 재정렬 함수 =====
  function reindexItems(itemClass, listName) {
      console.log('재정렬 시작:', itemClass, listName);
      
      $(itemClass).each(function(index) {
          console.log('재정렬 index:', index);
          $(this).find('input, select, textarea').each(function() {
              let oldName = $(this).attr('name');
              if (oldName && oldName.includes(listName)) {
                  let newName = oldName.replace(/\[\d*\]/, '[' + index + ']');
                  $(this).attr('name', newName);
                  console.log('변경:', oldName, '->', newName);
              }
          });
      });
  }

  // ===== 폼 제출 전 확인 =====
  $('form.form-ad').on('submit', function(e) {
      console.log('=== 폼 제출 전 name 속성 확인 ===');
      
      $('input[name^="educationList"], select[name^="educationList"]').each(function() {
          console.log('학력:', $(this).attr('name'), '=', $(this).val());
      });
      
      $('input[name^="careerList"]').each(function() {
          console.log('경력:', $(this).attr('name'), '=', $(this).val());
      });
      
      $('input[name^="trainingList"]').each(function() {
          console.log('교육:', $(this).attr('name'), '=', $(this).val());
      });
      
      $('input[name^="certificationList"]').each(function() {
          console.log('자격:', $(this).attr('name'), '=', $(this).val());
      });
      
      // 실제 제출은 진행
      // return false; // 테스트 시에는 이 줄의 주석을 해제하세요
  });
  
//-------------- GPT 첨삭 기능
	// GPT 첨삭 요청 버튼 클릭
	   $('.gpt-request').on('click', function(){
	       const target = $(this).data('target'); // 예: "motivation"
	       const content = $('#' + target).val();
	
	       if (!content.trim()) {
	           alert("내용을 입력한 후 첨삭을 요청해주세요!");
	           return;
	       }
	
	       // 로딩 표시
	       const resultBox = $('#gpt-result-' + target);
	       const resultContent = $('#gpt-content-' + target);
	       resultBox.show();
	       resultContent.text("GPT가 첨삭 중입니다... 잠시만 기다려주세요.");
	
	       // AJAX 요청
	       $.ajax({
	           type: "POST",
	           url: "/resume/selfIntro/feedback",
	           data: { content: content },
	           success: function(response) {
	               resultContent.text(response);
	           },
	           error: function() {
	               resultContent.text("GPT 요청 중 오류가 발생했습니다. 다시 시도해주세요.");
	           }
	       });
	   });
	
	   // "첨삭내용 사용하기" 버튼 클릭
	   $('.use-gpt').on('click', function(){
	       const target = $(this).data('target');
	       const gptText = $('#gpt-content-' + target).text();
	       $('#' + target).val(gptText); // textarea 내용 교체
	       alert("GPT 첨삭 내용을 적용했습니다!");
	   });
  
});
</script>

<%@ include file="../include/Footer.jsp"%>