<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/Header.jsp" %>
<style>
	#com_top {
		display: flex;
		justify-content: center;
		align-items: center;
		margin-bottom: 15px;
	}
	
	#gptPreviewBox .btn-success,
	#gptPreviewBox .btn-secondary {
	    height: 40px !important;
	    line-height: 26px !important;
	    padding: 6px 18px !important;
	    font-size: 14px;
	    margin-right: 8px;
	}
</style>

<section class="add-resume section">

<!-- 로그인 상태 확인 -->
<c:if test="${empty recLoginInfo}">
	<script type="text/javascript">
		alert("로그인 후 이용 가능합니다.");
		location.href = "/recboard/recListCri";
	</script>
</c:if>

<div class="container">
	<div class="row">
		<div class="col-lg-10 offset-lg-1 col-12">
			<div class="add-resume-inner box">

				<!-- 상단 헤더 -->
				<div id="com_top" class="post-header align-items-center justify-content-center">
					<h3 id="title">
						<font dir="auto">${recLoginInfo.corpUserId}</font>
					</h3>
				</div>
				<hr>

				<!-- 글쓰기 폼 시작 -->
				<form class="form-ad" method="post" enctype="multipart/form-data">
					<input type="hidden" name="page" value="${page }">
					<input type="hidden" name="rec_bno" value="${resultReadVO.rec_bno}">
					<h3 class="single-section-title">공고 수정</h3>

					<!-- 기본 정보 영역 -->
					<div class="row">
						<div class="col-lg-6 col-12">
							<div class="form-group">
								<label>채용 공고 명</label>
								<input type="text" class="form-control" name="rec_title"
									   placeholder="공고 제목을 입력하세요." 
									   value="${resultReadVO.rec_title }"
									   required>
							</div>
						</div>
						<div class="col-lg-6 col-12">
							<div class="form-group">
								<label>채용 담당자</label>
								<input type="text" class="form-control"
									   value="${resultReadVO.managerName}" readonly>
							</div>
						</div>
					</div>

					<div class="form-group">
						<label>담당자 소속 회사명</label>
						<input type="text" class="form-control"
							   value="${resultReadVO.companyName}" readonly>
					</div>
					
					<div class="form-group">
						<label>담당자 메일 주소</label>
						<input type="text" class="form-control"
							   value="${resultReadVO.managerEmail}" readonly>
					</div>

					<div class="form-group">
						<label>회사 소개 및 주요 업무</label>
						<textarea class="form-control" name="rec_maintask"
								  placeholder="주요 업무를 입력하세요." rows="5">${resultReadVO.rec_maintask }
						</textarea>
						
						<button type="button" class="btn btn-outline-primary btn-sm gptBtn"
						        data-target="rec_maintask" data-api="/recboard/gpt/maintask">
						    ✨ GPT로 주요 업무 첨삭하기
						</button>
						
						<div class="gptPreviewBox" id="preview_rec_maintask" style="display:none;">
						    <h5>GPT 미리보기</h5>
						    <pre class="gptText"></pre>
						
						    <button type="button" class="btn btn-success btn-sm applyBtn">적용하기</button>
						    <button type="button" class="btn btn-secondary btn-sm retryBtn">다시 생성하기</button>
						</div>
								  
					</div>

					<!-- 카테고리 / 지역 선택 -->
					<div class="row">
						<div class="col-lg-4 col-12">
							<div class="form-group">
								<label>상위 카테고리</label>
								<select id="topCategory" name="topctg_id" class="form-control" required>
								    <option value="">선택하세요</option>
								    <c:forEach var="tc" items="${topCategoryList}">
								        <option value="${tc.topctg_id}"
								            <c:if test="${tc.topctg_id == resultReadVO.topctg_id}">selected</c:if>>
								            ${tc.topctg_name}
								        </option>
								    </c:forEach>
								</select>
							</div>
						</div>
						<div class="col-lg-4 col-12">
							<div class="form-group">
								<label>하위 카테고리</label>
								<select id="bottomCategory" name="btmctg_id" class="form-control" required>
									<option value="">상위 카테고리를 먼저 선택하세요</option>
								</select>
							</div>
						</div>
						<div class="col-lg-4 col-12">
							<div class="form-group">
								<label>근무 지역</label>
								<select name="toplct_id" class="form-control" required>
								    <option value="">선택하세요</option>
								    <c:forEach var="tl" items="${topLocationList}">
								        <option value="${tl.toplct_id}"
								            <c:if test="${tl.toplct_id == resultReadVO.toplct_id}">selected</c:if>>
								            ${tl.toplct_name}
								        </option>
								    </c:forEach>
								</select>
							</div>
						</div>
					</div>

					<!-- 상세 근무지 / 자격요건 / 마감일 -->
					<div class="row">
						<div class="col-lg-6 col-12">
							<div class="form-group">
								<label>상세 근무지</label>
								<input type="text" id="streetAdr" class="form-control" name="rec_inputlct"
						               placeholder="도로명 주소를 클릭해서 선택하세요" readonly
						               value="${resultReadVO.rec_inputlct}"
						               onclick="execDaumPostcode()"> <!-- 클릭 시 주소 검색창 실행 -->
							</div>
						</div>
						<div class="col-lg-6 col-12">
							<div class="form-group">
								<label>마감일</label>
								<input type="date" 
									   class="form-control" name="rec_deadline" value="${resultReadVO.rec_deadline}" required>
							</div>
						</div>
					</div>

					<div class="form-group">
						<label>입사 자격 요건</label>
						<textarea class="form-control" name="rec_qualification"
								  placeholder="예) 무관, 고졸 이상, 4년제 이상 등 주로 최소 학력 입력" rows="5">${resultReadVO.rec_qualification}
						</textarea>
						
						<button type="button" class="btn btn-outline-primary btn-sm gptBtn"
						        data-target="rec_qualification" data-api="/recboard/gpt/qualification">
						    ✨ GPT로 자격 요건 첨삭하기
						</button>
						
						<div class="gptPreviewBox" id="preview_rec_maintask" style="display:none;">
						    <h5>GPT 미리보기</h5>
						    <pre class="gptText"></pre>
						
						    <button type="button" class="btn btn-success btn-sm applyBtn">적용하기</button>
						    <button type="button" class="btn btn-secondary btn-sm retryBtn">다시 생성하기</button>
						</div>
					</div>
					
					<div class="form-group">
						<label>채용 우대 사항</label>
						<textarea class="form-control" name="rec_preference"
								  placeholder="예) OO관련 전공자 우대, 정보처리기사 우대 등 관련 학력 자격증 입력" rows="5">${resultReadVO.rec_preference}
						</textarea>
						
						<button type="button" class="btn btn-outline-primary btn-sm gptBtn"
						        data-target="rec_preference" data-api="/recboard/gpt/preference">
						    ✨ GPT로 우대 사항 첨삭하기
						</button>
						
						<div class="gptPreviewBox" id="preview_rec_maintask" style="display:none;">
						    <h5>GPT 미리보기</h5>
						    <pre class="gptText"></pre>
						
						    <button type="button" class="btn btn-success btn-sm applyBtn">적용하기</button>
						    <button type="button" class="btn btn-secondary btn-sm retryBtn">다시 생성하기</button>
						</div>
					</div>
					
					<div class="form-group">
						<label>복리 후생</label>
						<textarea class="form-control" name="rec_benefit"
								  placeholder="채용시 복지 및 임/직원 지원 항목을 작성하세요." rows="5">${resultReadVO.rec_benefit }
						</textarea>
						
						<button type="button" class="btn btn-outline-primary btn-sm gptBtn"
						        data-target="rec_benefit" data-api="/recboard/gpt/benefit">
						    ✨ GPT로 복리 후생 첨삭하기
						</button>
						
						<div class="gptPreviewBox" id="preview_rec_maintask" style="display:none;">
						    <h5>GPT 미리보기</h5>
						    <pre class="gptText"></pre>
						
						    <button type="button" class="btn btn-success btn-sm applyBtn">적용하기</button>
						    <button type="button" class="btn btn-secondary btn-sm retryBtn">다시 생성하기</button>
						</div>
					</div>

					<!-- 썸네일 업로드 -->
				    <div class="form-group">
				        <label>썸네일 파일</label>
				        <input type="file" name="thumb" class="form-control" accept="image/*">
				        <small class="form-text text-muted">회사를 상징하는 이미지를 업로드 하세요.</small>
				    </div>
				
				    <!-- 첨부파일 업로드 -->
				    <div class="form-group">
				        <label>회사 정경 이미지 (다중 업로드 가능)</label>
				        <input type="file" name="attachFiles" class="form-control" accept="image/*">
				        <button type="button" id="addBtn" class="btn btn-sm btn-secondary mt-2">➕ 추가하기</button>
				    </div>
                    <div id="fileDiv">
			                                    
               		</div>
					<!-- 확인 및 등록 버튼 -->
					<div class="row align-items-center justify-content-center">
						<div class="col-lg-6 col-md-5 col-12">
							<div class="checkbox">
								<label><input type="checkbox" required> 내용을 한번 더 확인했습니다.</label>
							</div>
						</div>
						<div class="col-lg-6 col-md-7 col-12">
							<div class="add-post-btn float-right">
								<button type="submit" class="btn btn-primary">공고 수정</button>
								<button type="button" class="btn btn-primary listBtn">목록으로</button>
							</div>
						</div>
					</div>
				</form>
				<!-- 폼 끝 -->
			</div>
		</div>
	</div>
</div>

</section>
<!-- 다음 주소 찾기 API -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	$("#streetAdr").on("click", function() {
        new daum.Postcode({
            oncomplete: function(data) {
                const fullAddr = data.roadAddress ? data.roadAddress : data.jibunAddress;
                $("#streetAdr").val(fullAddr);
            }
        }).open();
    });
</script>

<!-- 대분류 선택 시 소분류 선택 가능-->
<script>
	$(document).ready(function() {
	    const selectedTopId = "${resultReadVO.topctg_id}";
	    const selectedBtmId = "${resultReadVO.btmctg_id}";
	
	    $('#topCategory').change(function() {
	        const topId = $(this).val();
	        $('#bottomCategory').empty();
	
	        if (topId) {
	            $.ajax({
	                url: "/recboard/getBottomCategory",
	                data: { topctg_id: topId },
	                success: function(list) {
	                    $('#bottomCategory').append('<option value="">선택하세요</option>');
	                    $.each(list, function(i, item) {
	                        const selected = (item.btmctg_id == selectedBtmId) ? 'selected' : '';
	                        $('#bottomCategory').append('<option value="' + item.btmctg_id + '" ' + selected + '>' + item.btmctg_name + '</option>');
	                    });
	                }
	            });
	        } else {
	            $('#bottomCategory').append('<option value="">상위 카테고리를 먼저 선택하세요</option>');
	        }
	    });
	
	    // 초기 설정
	    if (selectedTopId) {
	        $('#topCategory').val(selectedTopId).trigger('change');
	    }
	
	    // 파일 추가 버튼
	    $("#addBtn").click(function() {
	        $("#fileDiv").append("<div><br><input type='file' name='attachFiles' accept='image/*'></div>");
	    });
	    
	    $(".listBtn").click(function(){
		    location.href = "/recboard/recListCri?page=${page}";
		});
	    
	 	// GPT 첨삭 버튼
	    $(".gptBtn").click(function () {

	        const target = $(this).data("target");        
	        const api = $(this).data("api");               
	        const textarea = $("textarea[name='"+target+"']");
	        const text = textarea.val().trim();

	        if (!text) {
	            alert("내용을 먼저 입력해주세요!");
	            return;
	        }

	        const previewBox = $("#preview_" + target);
	        const previewText = previewBox.find(".gptText");

	        previewText.text("GPT가 내용을 정리하는 중입니다...");
	        previewBox.show();

	        $.ajax({
	            url: api,
	            type: "POST",
	            data: { content: text },
	            success: function (result) {
	                previewText.text(result);

	                // 적용하기
	                previewBox.find(".applyBtn").off("click").on("click", function () {
	                    textarea.val(result);
	                    alert("적용되었습니다!");
	                });

	                // 다시 생성
	                previewBox.find(".retryBtn").off("click").on("click", function () {
	                    previewText.text("GPT가 새로운 버전을 생성 중입니다...");
	                    $.ajax({
	                        url: api,
	                        type: "POST",
	                        data: { content: textarea.val() },
	                        success: function (retryResult) {
	                            previewText.text(retryResult);
	                        }
	                    });
	                });
	            }
	        });
	    });
	});
</script>

<%@ include file="../include/Footer.jsp" %>