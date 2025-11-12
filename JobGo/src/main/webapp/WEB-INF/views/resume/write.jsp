<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../include/Header.jsp"%>
<section class="add-resume section">
	<div class="section-title">
		<h2>이력서 작성</h2>
	</div>
	<div class="container my-5">
	    <div class="row">
	        <div class="col-lg-10 offset-lg-1 col-12">
	            <div class="add-resume-inner box p-4 shadow-sm bg-white rounded">
	                <!-- Header -->
	                <div class="post-header text-center mb-4">
	                    <h3>이력서 작성</h3>
	                    <%-- <p>${sessionScope.memberId }</p> --%>
	                    <p>이력서 정보를 입력해주세요.</p>
	                </div>
	                <!-- FORM -->
	                <form class="form-ad" action="/resume/write" method="post">
	                    <input type="hidden" name="memberId" value="${sessionScope.memberId}" />
	                    <!-- 기본 정보 -->
	                    <h4 class="mb-3">기본 정보</h4>
	                    <div class="row">
	                        <div class="col-lg-12 col-12">
	                            <div class="form-group">
	                                <label class="control-label">이력서 제목</label>
	                                <input type="text" class="form-control" name="resumeTitle" placeholder="예: 신입 웹퍼블리셔 이력서" required>
	                            </div>
	                        </div>
	                    </div>
	                    <hr>
	                    <!-- 학력사항 -->
	                    <h4 class="single-section-title mt-4">학력사항</h4>
	                    <div id="educationSection">
	                        <div class="edu-item border p-3 rounded mb-3 bg-light">
	                            <div class="form-row">
	                                <div class="form-group col-md-6">
	                                    <label>학교명</label>
	                                    <input type="text" class="form-control" name="educationList[0].schoolName" placeholder="예: 부산대학교">
	                                </div>
	                                <div class="form-group col-md-6">
	                                    <label>전공</label>
	                                    <input type="text" class="form-control" name="educationList[0].major" placeholder="예: 컴퓨터공학과">
	                                </div>
	                            </div>
	                            <div class="form-row">
	                                <div class="form-group col-md-6">
	                                    <label>입학일</label>
	                                    <input type="date" class="form-control" name="educationList[0].fromDate">
	                                </div>
	                                <div class="form-group col-md-6">
	                                    <label>졸업일</label>
	                                    <input type="date" class="form-control" name="educationList[0].toDate">
	                                </div>
	                            </div>
	                            <div class="form-group">
	                                <label>졸업 여부</label>
	                                <select class="form-control" name="educationList[0].isGraduated">
	                                    <option value="Y">졸업</option>
	                                    <option value="N">재학/중퇴</option>
	                                </select>
	                            </div>
	                        </div>
	                        <button type="button" class="btn btn-secondary btn-sm add-edu"><i class="lni lni-add-files"></i> 학력 추가</button>
	                    </div>
	                    <hr>
	                    <!-- 경력사항 -->
	                    <h4 class="single-section-title mt-4">경력사항</h4>
	                    <div id="careerSection">
	                        <div class="career-item border p-3 rounded mb-3 bg-light">
	                            <div class="form-row">
	                                <div class="form-group col-md-6">
	                                    <label>회사명</label>
	                                    <input type="text" class="form-control" name="careerList[0].companyName" placeholder="예: 네이버">
	                                </div>
	                                <div class="form-group col-md-6">
	                                    <label>담당 업무</label>
	                                    <input type="text" class="form-control" name="careerList[0].responsibility" placeholder="예: 웹퍼블리싱">
	                                </div>
	                            </div>
	                            <div class="form-row">
	                                <div class="form-group col-md-6">
	                                    <label>입사일</label>
	                                    <input type="date" class="form-control" name="careerList[0].fromDate">
	                                </div>
	                                <div class="form-group col-md-6">
	                                    <label>퇴사일</label>
	                                    <input type="date" class="form-control" name="careerList[0].toDate">
	                                </div>
	                            </div>
	                        </div>
	                        <button type="button" class="btn btn-secondary btn-sm add-career"><i class="lni lni-add-files"></i> 경력 추가</button>
	                    </div>
	                    <hr>
	                    <!-- 교육이력 -->
	                    <h4 class="single-section-title mt-4">교육이력</h4>
	                    <div id="trainingSection">
	                        <div class="training-item border p-3 rounded mb-3 bg-light">
	                            <div class="form-row">
	                                <div class="form-group col-md-6">
	                                    <label>기관명</label>
	                                    <input type="text" class="form-control" name="trainingList[0].institution" placeholder="예: ITWILL 부산교육센터">
	                                </div>
	                                <div class="form-group col-md-6">
	                                    <label>교육 내용</label>
	                                    <input type="text" class="form-control" name="trainingList[0].content" placeholder="예: 웹퍼블리셔 과정">
	                                </div>
	                            </div>
	                            <div class="form-row">
	                                <div class="form-group col-md-6">
	                                    <label>시작일</label>
	                                    <input type="date" class="form-control" name="trainingList[0].fromDate">
	                                </div>
	                                <div class="form-group col-md-6">
	                                    <label>종료일</label>
	                                    <input type="date" class="form-control" name="trainingList[0].toDate">
	                                </div>
	                            </div>
	                        </div>
	                        <button type="button" class="btn btn-secondary btn-sm add-training"><i class="lni lni-add-files"></i> 교육 추가</button>
	                    </div>
	                    <hr>
	                    <!-- 자격사항 -->
	                    <h4 class="single-section-title mt-4">자격사항</h4>
	                    <div id="certSection">
	                        <div class="cert-item border p-3 rounded mb-3 bg-light">
	                            <div class="form-row">
	                                <div class="form-group col-md-8">
	                                    <label>자격명</label>
	                                    <input type="text" class="form-control" name="certificationList[0].certificationName" placeholder="예: 정보처리기사">
	                                </div>
	                                <div class="form-group col-md-4">
	                                    <label>취득일</label>
	                                    <input type="date" class="form-control" name="certificationList[0].acquiredDate">
	                                </div>
	                            </div>
	                        </div>
	                        <button type="button" class="btn btn-secondary btn-sm add-cert"><i class="lni lni-add-files"></i> 자격 추가</button>
	                    </div>
	                    <hr>
	                    <!-- 자기소개서 -->
	                    <h4 class="single-section-title mt-4">자기소개서</h4>
	                    <div class="border p-3 rounded bg-light mb-4">
	                        <div class="form-group">
	                            <label>지원 동기</label>
	                            <textarea class="form-control" rows="4" name="motivation" id="motivation"></textarea>
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
	                            <textarea class="form-control" rows="4" name="strengths" id="strengths"></textarea>
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
	                            <textarea class="form-control" rows="4" name="keyExperience" id="keyExperience"></textarea>
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
	                            <textarea class="form-control" rows="4" name="futurePlan" id="futurePlan"></textarea>
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
	                    <div class="text-center">
	                        <button type="submit" class="btn btn-primary btn-lg">이력서 등록</button>
	                    </div>
	                </form>
	            </div>
	        </div>
	    </div>
	</div>
</section>
<script>
$(document).ready(function(){
	let eduIdx = 1, careerIdx = 1, trainIdx = 1, certIdx = 1;

    $('.add-edu').on('click', function() {
        let html = `
            <div class="edu-item border p-3 rounded mb-3 bg-light">
                <div class="form-row">
                    <div class="form-group col-md-6">
                        <label>학교명</label>
                        <input type="text" class="form-control" name="educationList[" + eduIdx + "].schoolName">
                    </div>
                    <div class="form-group col-md-6">
                        <label>전공</label>
                        <input type="text" class="form-control" name="educationList[" + eduIdx + "].major">
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group col-md-6">
                        <label>입학일</label>
                        <input type="date" class="form-control" name="educationList[" + eduIdx + "].fromDate">
                    </div>
                    <div class="form-group col-md-6">
                        <label>졸업일</label>
                        <input type="date" class="form-control" name="educationList[" + eduIdx + "].toDate">
                    </div>
                </div>
                <div class="form-group">
                    <label>졸업 여부</label>
                    <select class="form-control" name="educationList[" + eduIdx + "].isGraduated">
                        <option value="Y">졸업</option>
                        <option value="N">재학/중퇴</option>
                    </select>
                </div>
            </div>`;
        $('#educationSection .add-edu').before(html);
        eduIdx++;
    });

    $('.add-career').on('click', function() {
        let html = `
            <div class="career-item border p-3 rounded mb-3 bg-light">
                <hr>
                <div class="form-row">
                    <div class="form-group col-md-6">
                        <label>회사명</label>
                        <input type="text" class="form-control" name="careerList[" + careerIdx + "].companyName">
                    </div>
                    <div class="form-group col-md-6">
                        <label>담당 업무</label>
                        <input type="text" class="form-control" name="careerList[" + careerIdx + "].responsibility">
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group col-md-6">
                        <label>입사일</label>
                        <input type="date" class="form-control" name="careerList[" + careerIdx + "].fromDate">
                    </div>
                    <div class="form-group col-md-6">
                        <label>퇴사일</label>
                        <input type="date" class="form-control" name="careerList[" + careerIdx + "].toDate">
                    </div>
                </div>
            </div>`;
        $('#careerSection .add-career').before(html);
        careerIdx++;
    });

    $('.add-training').on('click', function() {
        let html = `
            <div class="training-item border p-3 rounded mb-3 bg-light">
                <hr>
                <div class="form-row">
                    <div class="form-group col-md-6">
                        <label>기관명</label>
                        <input type="text" class="form-control" name="trainingList[" + trainIdx + "].institution">
                    </div>
                    <div class="form-group col-md-6">
                        <label>내용</label>
                        <input type="text" class="form-control" name="trainingList[" + trainIdx + "].content">
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group col-md-6">
                        <label>시작일</label>
                        <input type="date" class="form-control" name="trainingList[" + trainIdx + "].fromDate">
                    </div>
                    <div class="form-group col-md-6">
                        <label>종료일</label>
                        <input type="date" class="form-control" name="trainingList[" + trainIdx + "].toDate">
                    </div>
                </div>
            </div>`;
        $('#trainingSection .add-training').before(html);
        trainIdx++;
    });

    $('.add-cert').on('click', function() {
        let html = `
            <div class="cert-item border p-3 rounded mb-3 bg-light">
                <hr>
                <div class="form-row">
                    <div class="form-group col-md-8">
                        <label>자격명</label>
                        <input type="text" class="form-control" name="certificationList[" + certIdx + "].certificationName">
                    </div>
                    <div class="form-group col-md-4">
                        <label>취득일</label>
                        <input type="date" class="form-control" name="certificationList[" + certIdx + "].acquiredDate">
                    </div>
                </div>
            </div>`;
        $('#certSection .add-cert').before(html);
        certIdx++;
    });
    
    // -------------- GPT 첨삭 기능
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