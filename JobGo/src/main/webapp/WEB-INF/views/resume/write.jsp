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
	                    <p>${sessionScope.memberId }</p>
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
	                                    <input type="text" class="form-control" name="trainingList[0].institution" placeholder="예: 부산IT아카데미">
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
	                            <textarea class="form-control" rows="4" name="selfIntro.motivation"></textarea>
	                        </div>
	                        <div class="form-group">
	                            <label>강점 및 역량</label>
	                            <textarea class="form-control" rows="4" name="selfIntro.strengths"></textarea>
	                        </div>
	                        <div class="form-group">
	                            <label>성과나 중요한 경험</label>
	                            <textarea class="form-control" rows="4" name="selfIntro.keyExperience"></textarea>
	                        </div>
	                        <div class="form-group">
	                            <label>입사 후 포부</label>
	                            <textarea class="form-control" rows="4" name="selfIntro.futurePlan"></textarea>
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

	<%-- <form action="/resume/write" method="post">
	
	    <!-- 기본 이력서 정보 -->
	    <div class="section">
	        <h2>기본 정보</h2>
	        <input type="hidden" name="memberId" value="${sessionScope.member.id}" />
	        <label>이력서 제목</label>
	        <input type="text" name="resumeTitle" required />
	    </div>
	
	    <!-- 학력사항 -->
	    <div class="section" id="educationSection">
	        <h2>학력사항</h2>
	        <div class="education-item">
	            <label>학교명</label>
	            <input type="text" name="educationList[0].schoolName" />
	            <label>전공</label>
	            <input type="text" name="educationList[0].major" />
	            <label>입학일</label>
	            <input type="date" name="educationList[0].fromDate" />
	            <label>졸업일</label>
	            <input type="date" name="educationList[0].toDate" />
	            <label>졸업 여부</label>
	            <select name="educationList[0].isGraduated">
	                <option value="Y">졸업</option>
	                <option value="N">재학/중퇴</option>
	            </select>
	        </div>
	        <button type="button" class="add-btn" onclick="addEducation()">+ 학력 추가</button>
	    </div>
	
	    <!-- 경력사항 -->
	    <div class="section" id="careerSection">
	        <h2>경력사항</h2>
	        <div class="career-item">
	            <label>회사명</label>
	            <input type="text" name="careerList[0].companyName" />
	            <label>담당 업무</label>
	            <input type="text" name="careerList[0].responsibility" />
	            <label>입사일</label>
	            <input type="date" name="careerList[0].fromDate" />
	            <label>퇴사일</label>
	            <input type="date" name="careerList[0].toDate" />
	        </div>
	        <button type="button" class="add-btn" onclick="addCareer()">+ 경력 추가</button>
	    </div>
	
	    <!-- 교육이력 -->
	    <div class="section" id="trainingSection">
	        <h2>교육이력</h2>
	        <div class="training-item">
	            <label>기관명</label>
	            <input type="text" name="trainingList[0].institution" />
	            <label>내용</label>
	            <input type="text" name="trainingList[0].content" />
	            <label>시작일</label>
	            <input type="date" name="trainingList[0].fromDate" />
	            <label>종료일</label>
	            <input type="date" name="trainingList[0].toDate" />
	        </div>
	        <button type="button" class="add-btn" onclick="addTraining()">+ 교육 추가</button>
	    </div>
	
	    <!-- 자격사항 -->
	    <div class="section" id="certSection">
	        <h2>자격사항</h2>
	        <div class="cert-item">
	            <label>자격명</label>
	            <input type="text" name="certificationList[0].certificationName" />
	            <label>취득일</label>
	            <input type="date" name="certificationList[0].acquiredDate" />
	        </div>
	        <button type="button" class="add-btn" onclick="addCert()">+ 자격 추가</button>
	    </div>
	
	    <!-- 자기소개서 -->
	    <div class="section">
	        <h2>자기소개서</h2>
	        <label>지원 동기</label>
	        <textarea name="selfIntro.motivation"></textarea>
	        <label>강점 및 역량</label>
	        <textarea name="selfIntro.strengths"></textarea>
	        <label>성과나 중요한 경험</label>
	        <textarea name="selfIntro.keyExperience"></textarea>
	        <label>입사 후 포부</label>
	        <textarea name="selfIntro.futurePlan"></textarea>
	    </div>
	
	    <div class="section" style="text-align:center;">
	        <button type="submit">이력서 등록</button>
	    </div>
	</form> --%>
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
});
</script>


<%@ include file="../include/Footer.jsp"%>