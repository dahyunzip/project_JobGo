<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../include/Header.jsp"%>
<section class="section">
	<h2 class="pageTitle">이력서 작성</h2>
	<div class="container my-5">
	    <div class="row">
	        <div class="col-12">
                <!-- FORM -->
                <form class="form-ad" action="/resume/write" method="post">
                    <input type="hidden" name="memberId" value="${sessionScope.memberId}" />
                    <!-- 기본 정보 -->
                    <h4 class="mb-3">기본 정보</h4>
                    <div class="row">
                        <div class="col-lg-12 col-12">
                            <div class="form-group">
                                <label class="control-label">이력서 제목</label>
                                <input type="text" class="form-control" name="resumeTitle" placeholder="이력서 제목을 입력하세요." required>
                            </div>
                        </div>
                    </div>
                    <hr>
                    <!-- 학력사항 -->
					<h4 class="single-section-title mt-4">학력사항</h4>
					<div id="educationSection">
						<div class="text-right mb-10">
						    <button type="button" class="btn btn-secondary btn-sm add-edu">
						        <i class="lni lni-add-files"></i> 학력 추가
						    </button>
					    </div> 
					    <div class="edu-item border p-3 rounded mb-3 bg-light">
					        <div class="row">
					            <div class="form-group col-md-6 col-xs-12">
					                <label>학교명</label>
					                <input type="text" class="form-control" name="educationList[0].schoolName" placeholder="학교명">
					            </div>
					            <div class="form-group col-md-6 col-xs-12">
					                <label>전공</label>
					                <input type="text" class="form-control" name="educationList[0].major" placeholder="전공명">
					            </div>
					        </div>
					        <div class="row">
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
					</div>
					<hr>
					<!-- 경력사항 -->
					<h4 class="single-section-title mt-4">경력사항</h4>
					<div id="careerSection">
						<div class="text-right mb-10">
						    <button type="button" class="btn btn-secondary btn-sm add-career">
						        <i class="lni lni-add-files"></i> 경력 추가
						    </button>
					    </div>
					    <div class="career-item border p-3 rounded mb-3 bg-light">
					        <!-- educationSeq 제거 -->
					        <div class="row">
					            <div class="form-group col-md-6 col-xs-12">
					                <label>회사명</label>
					                <input type="text" class="form-control" name="careerList[0].companyName" placeholder="회사명">
					            </div>
					            <div class="form-group col-md-6 col-xs-12">
					                <label>담당 업무</label>
					                <input type="text" class="form-control" name="careerList[0].responsibility" placeholder="담당업무">
					            </div>
					        </div>
					        <div class="row">
					            <div class="form-group col-md-6 col-xs-12">
					                <label>입사일</label>
					                <input type="date" class="form-control" name="careerList[0].fromDate">
					            </div>
					            <div class="form-group col-md-6 col-xs-12">
					                <label>퇴사일</label>
					                <input type="date" class="form-control" name="careerList[0].toDate">
					            </div>
					        </div>
					    </div>
					</div>
					<hr>
					<!-- 교육이력 -->
					<h4 class="single-section-title mt-4">교육이력</h4>
					<div id="trainingSection">
						<div class="text-right mb-10">
						    <button type="button" class="btn btn-secondary btn-sm add-training">
						        <i class="lni lni-add-files"></i> 교육 추가
						    </button>
						</div>
					    <div class="training-item border p-3 rounded mb-3 bg-light">
					        <div class="row">
					            <div class="form-group col-md-6 col-xs-12">
					                <label>기관명</label>
					                <input type="text" class="form-control" name="trainingList[0].institution" placeholder="교육기관명">
					            </div>
					            <div class="form-group col-md-6 col-xs-12">
					                <label>교육 내용</label>
					                <input type="text" class="form-control" name="trainingList[0].content" placeholder="교육내용">
					            </div>
					        </div>
					        <div class="row">
					            <div class="form-group col-md-6 col-xs-12">
					                <label>시작일</label>
					                <input type="date" class="form-control" name="trainingList[0].fromDate">
					            </div>
					            <div class="form-group col-md-6 col-xs-12">
					                <label>종료일</label>
					                <input type="date" class="form-control" name="trainingList[0].toDate">
					            </div>
					        </div>
					    </div>
					</div>
					<hr>
					<!-- 자격사항 -->
					<h4 class="single-section-title mt-4">자격사항</h4>
					<div id="certSection">
						<div class="text-right mb-10">
						    <button type="button" class="btn btn-secondary btn-sm add-cert">
						        <i class="lni lni-add-files"></i> 자격 추가
						    </button>
						</div>
					    <div class="cert-item border p-3 rounded mb-3 bg-light">
					        <div class="row">
					            <div class="form-group col-md-8">
					                <label>자격명</label>
					                <input type="text" class="form-control" name="certificationList[0].certificationName" placeholder="취득 자격을 입력하세요.">
					            </div>
					            <div class="form-group col-md-4">
					                <label>취득일</label>
					                <input type="date" class="form-control" name="certificationList[0].acquiredDate">
					            </div>
					        </div>
					    </div>
					</div>
                    <hr>
                    <!-- 자기소개서 -->
                    <h4 class="single-section-title mb-10">자기소개서</h4>
                    <div class="border p-3 rounded bg-light mb-4">
                        <div class="form-group">
                            <label>지원 동기</label>
                            <textarea class="form-control" rows="4" name="selfIntro.motivation" id="motivation"></textarea>
                            <div class="mt-2 text-right">
						        <button type="button" class="btn btn-primary btn-sm gpt-request" data-target="motivation">
						            AI 첨삭 요청
						        </button>
						    </div>
						    <!-- GPT 첨삭 결과 영역 -->
						    <div class="gpt-result mt-3 p-3 border rounded bg-white" id="gpt-result-motivation" style="display:none;">
						        <h6>AI 첨삭 결과</h6>
						        <pre id="gpt-content-motivation" style="white-space:pre-wrap;"></pre>
						        <button type="button" class="btn btn-success btn-sm mt-2 use-gpt" data-target="motivation">첨삭내용 사용하기</button>
						    </div>
                        </div>
                        <div class="form-group">
                            <label>강점 및 역량</label>
                            <textarea class="form-control" rows="4" name="selfIntro.strengths" id="strengths"></textarea>
                            <div class="mt-2 text-right">
						        <button type="button" class="btn btn-primary btn-sm gpt-request" data-target="strengths">
						            AI 첨삭 요청
						        </button>
						    </div>
						    <!-- GPT 첨삭 결과 영역 -->
						    <div class="gpt-result mt-3 p-3 border rounded bg-white" id="gpt-result-strengths" style="display:none;">
						        <h6>AI 첨삭 결과</h6>
						        <pre id="gpt-content-strengths" style="white-space:pre-wrap;"></pre>
						        <button type="button" class="btn btn-success btn-sm mt-2 use-gpt" data-target="strengths">첨삭내용 사용하기</button>
						    </div>
                        </div>
                        <div class="form-group">
                            <label>성과나 중요한 경험</label>
                            <textarea class="form-control" rows="4" name="selfIntro.keyExperience" id="keyExperience"></textarea>
                            <div class="mt-2 text-right">
						        <button type="button" class="btn btn-primary btn-sm gpt-request" data-target="keyExperience">
						            AI 첨삭 요청
						        </button>
						    </div>
						    <!-- GPT 첨삭 결과 영역 -->
						    <div class="gpt-result mt-3 p-3 border rounded bg-white" id="gpt-result-keyExperience" style="display:none;">
						        <h6>AI 첨삭 결과</h6>
						        <pre id="gpt-content-keyExperience" style="white-space:pre-wrap;"></pre>
						        <button type="button" class="btn btn-success btn-sm mt-2 use-gpt" data-target="keyExperience">첨삭내용 사용하기</button>
						    </div>
                        </div>
                        <div class="form-group">
                            <label>입사 후 포부</label>
                            <textarea class="form-control" rows="4" name="selfIntro.futurePlan" id="futurePlan"></textarea>
                            <div class="mt-2 text-right">
						        <button type="button" class="btn btn-primary btn-sm gpt-request" data-target="futurePlan">
						            AI 첨삭 요청
						        </button>
						    </div>
						    <!-- GPT 첨삭 결과 영역 -->
						    <div class="gpt-result mt-3 p-3 border rounded bg-white" id="gpt-result-futurePlan" style="display:none;">
						        <h6>AI 첨삭 결과</h6>
						        <pre id="gpt-content-futurePlan" style="white-space:pre-wrap;"></pre>
						        <button type="button" class="btn btn-success btn-sm mt-2 use-gpt" data-target="futurePlan">첨삭내용 사용하기</button>
						    </div>
                        </div>
                    </div>
                    <!-- Submit -->
                    <div class="text-center mt-20 button">
					    <button type="submit" formaction="/resume/tempSave" class="btn btn-secondary">
					        임시 저장
					    </button>
					    <button type="submit" formaction="/resume/write" class="btn btn-primary">
					        최종 등록
					    </button>
                           <a href="/resume/list?memberId=${sessionScope.memberId}" class="btn btn-outline-secondary btn-lg">취소</a>
					</div>
                </form>
	        </div>
	    </div>
	</div>
</section>
<script>
$(document).ready(function(){
	let eduIdx = 1, careerIdx = 1, trainIdx = 1, certIdx = 1;

	// ===== 학력 추가 =====
    $('.add-edu').on('click', function() {
        console.log('현재 eduIdx:', eduIdx); // 디버깅용
        
        let html = '<div class="edu-item border p-3 rounded mb-3 bg-light text-left">' +
                '<div class="row">' +
                    '<div class="form-group col-md-6 col-xs-12">' +
                        '<label>학교명</label>' +
                        '<input type="text" class="form-control" name="educationList[' + eduIdx + '].schoolName" placeholder="학교명">' +
                    '</div>' +
                    '<div class="form-group col-md-6 col-xs-12">' +
                        '<label>전공</label>' +
                        '<input type="text" class="form-control" name="educationList[' + eduIdx + '].major" placeholder="전공명">' +
                    '</div>' +
                '</div>' +
                '<div class="row">' +
                    '<div class="form-group col-md-6 col-xs-12">' +
                        '<label>입학일</label>' +
                        '<input type="date" class="form-control" name="educationList[' + eduIdx + '].fromDate">' +
                    '</div>' +
                    '<div class="form-group col-md-6 col-xs-12">' +
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
                '<button type="button" class="btn btn-danger btn-sm remove-edu mt-10">' +
                    '<i class="lni lni-trash"></i> 삭제' +
                '</button>' +
            '</div>';
            
       $('#educationSection').append(html);
        
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
        
        let html = '<div class="career-item border p-3 rounded mb-3 bg-light text-left">' +
                '<div class="row">' +
                    '<div class="form-group col-md-6 col-xs-12">' +
                        '<label>회사명</label>' +
                        '<input type="text" class="form-control" name="careerList[' + careerIdx + '].companyName" placeholder="회사명">' +
                    '</div>' +
                    '<div class="form-group col-md-6 col-xs-12">' +
                        '<label>담당 업무</label>' +
                        '<input type="text" class="form-control" name="careerList[' + careerIdx + '].responsibility" placeholder="담당업무">' +
                    '</div>' +
                '</div>' +
                '<div class="row">' +
                    '<div class="form-group col-md-6 col-xs-12">' +
                        '<label>입사일</label>' +
                        '<input type="date" class="form-control" name="careerList[' + careerIdx + '].fromDate">' +
                    '</div>' +
                    '<div class="form-group col-md-6 col-xs-12">' +
                        '<label>퇴사일</label>' +
                        '<input type="date" class="form-control" name="careerList[' + careerIdx + '].toDate">' +
                    '</div>' +
                '</div>' +
                '<button type="button" class="btn btn-danger btn-sm remove-career mt-10">' +
                    '<i class="lni lni-trash"></i> 삭제' +
                '</button>' +
            '</div>';
            
        $('#careerSection').append(html);
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
        
        let html = '<div class="training-item border p-3 rounded mb-3 bg-light text-left">' +
                '<div class="row">' +
                    '<div class="form-group col-md-6 col-xs-12">' +
                        '<label>기관명</label>' +
                        '<input type="text" class="form-control" name="trainingList[' + trainIdx + '].institution" placeholder="교육기관명">' +
                    '</div>' +
                    '<div class="form-group col-md-6 col-xs-12">' +
                        '<label>교육 내용</label>' +
                        '<input type="text" class="form-control" name="trainingList[' + trainIdx + '].content" placeholder="교육내용">' +
                    '</div>' +
                '</div>' +
                '<div class="row">' +
                    '<div class="form-group col-md-6 col-xs-12">' +
                        '<label>시작일</label>' +
                        '<input type="date" class="form-control" name="trainingList[' + trainIdx + '].fromDate">' +
                    '</div>' +
                    '<div class="form-group col-md-6 col-xs-12">' +
                        '<label>종료일</label>' +
                        '<input type="date" class="form-control" name="trainingList[' + trainIdx + '].toDate">' +
                    '</div>' +
                '</div>' +
                '<button type="button" class="btn btn-danger btn-sm remove-training mt-10">' +
                    '<i class="lni lni-trash"></i> 삭제' +
                '</button>' +
            '</div>';
            
        $('#trainingSection').append(html);
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
        
        let html = '<div class="cert-item border p-3 rounded mb-3 bg-light text-left">' +
                '<div class="row">' +
                    '<div class="form-group col-md-8 col-xs-12">' +
                        '<label>자격명</label>' +
                        '<input type="text" class="form-control" name="certificationList[' + certIdx + '].certificationName" placeholder="취득 자격명을 입력하세요.">' +
                    '</div>' +
                    '<div class="form-group col-md-4 col-xs-12">' +
                        '<label>취득일</label>' +
                        '<input type="date" class="form-control" name="certificationList[' + certIdx + '].acquiredDate">' +
                    '</div>' +
                '</div>' +
                '<button type="button" class="btn btn-danger btn-sm remove-cert mt-10">' +
                    '<i class="lni lni-trash"></i> 삭제' +
                '</button>' +
            '</div>';
            
        $('#certSection').append(html);
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