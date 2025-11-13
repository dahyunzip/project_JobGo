<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/Header.jsp" %>
<style>
	#com_top {
		display: flex;
		justify-content: center;
		align-items: center;
		margin-bottom: 15px;
	}
	
</style>
<section class="add-resume section" >
<c:if test="${empty memberLoginInfo }">
	<script type="text/javascript">
		alert("로그인 후 이용 가능합니다.");
		location.href = "/comboard/comListCri";
	</script>
</c:if>
	<div class="container" >
		<div class="row">
			<div class="col-lg-10 offset-lg-1 col-12">
			    <div class="add-resume-inner box">
			        <div id="com_top" class="post-header align-items-center justify-content-center">
			            <h3 id="title">
			            	<font dir="auto" style="vertical-align: inherit;">
			            		<font dir="auto" style="vertical-align: inherit;">${memberLoginInfo.name }</font>
			            	</font>
			            </h3>
			        </div>
			        <hr>
			        <form class="form-ad" method="post" enctype="multipart/form-data">
			        	<!-- 페이지 이동시(수정,삭제) 필요한 정보를 가져가기위한 from태그 -->
			            <h3 class="single-section-title">
			            	<input type="hidden" name="page" value="${page}">
			            	<font dir="auto" style="vertical-align: inherit;">
			            		<font dir="auto" style="vertical-align: inherit;">글 작성</font>
			            	</font>
			            </h3>
			            <div class="row">
			                <div class="col-lg-6 col-12">
			                    <div class="form-group">
			                        <label class="control-label">
			                        	<font dir="auto" style="vertical-align: inherit;">
			                        		<font dir="auto" style="vertical-align: inherit;">글 제목</font>
			                        	</font>
			                        </label>
			                        <input type="text" class="form-control" 
			                               name="com_title"
			                               placeholder="게시글 제목을 작성 해주세요."
			                               value="${resultReadVO.com_title }"
			                               required >
			                    </div>
			                </div>
			                <div class="col-lg-6 col-12">
			                    <div class="form-group">
			                        <label class="control-label">
			                        	<font dir="auto" style="vertical-align: inherit;">
			                        		<font dir="auto" style="vertical-align: inherit;">작성자</font>
			                        	</font>
			                        </label>
			                        <input type="text" class="form-control"
			                        	   value="${memberLoginInfo.name }"
			                               readonly>
			                    </div>
			                </div>
			            </div>
			            <div class="form-group">
			                <label class="control-label">
			                	<font dir="auto" style="vertical-align: inherit;">
			                		<font dir="auto" style="vertical-align: inherit;">E-mail</font>
			                	</font>
			                </label>
			                <input type="text" class="form-control" 
			                       value="${memberLoginInfo.email }"
			                       readonly>
			            </div>
			            <div class="form-group">
						    <label class="control-label">
						        글 내용
						    </label>
						
						    <textarea class="form-control" rows="7"
						              name="com_content"
						              id="com_content"
						              placeholder="자유롭게 글을 작성하세요!"
						              required>${resultReadVO.com_content }</textarea>
						
						    <!-- GPT 첨삭 버튼 -->
						    <button type="button" class="btn btn-outline-primary btn-sm mt-2" id="gptCheckBtn">
						        GPT 맞춤법 교정
						    </button>
						
						    <!-- GPT 결과 박스 -->
						    <div class="gpt-result mt-3 p-3 border rounded bg-white" id="gpt-result-box" style="display:none;">
						        <h6>GPT 교정 결과</h6>
						        <pre id="gpt-corrected" style="white-space:pre-wrap;"></pre>
						
						        <button type="button" class="btn btn-success btn-sm mt-2" id="useGptResult">
						            교정된 문장 적용하기
						        </button>
						    </div>
						</div>
			            <div class="row align-items-center justify-content-center">
			                <div class="col-lg-6 col-md-5 col-12">
			                    <div>
			                        <div class="button-group">
			                            <div class="action-buttons">
			                                <div class="upload-button button">
												<!-- 체크박스 영역 -->
												<div class="checkbox">
													<input type="checkbox" id="confirmCheck" required>
													<label for="confirmCheck">내용을 한번 더 확인 해 주세요.</label>
												</div>	
												<hr>
											
												<!-- 파일 입력 영역 -->
												<div>
													<input id="cover_img_file_3" type="file" name="storedFileName" accept="image/*">
													<label for="cover_img_file_3">첨부파일 ➕</label>
													<input type="button" value="추가하기" id="addBtn">
												</div>
												<div id="fileDiv">
												
												</div>
			                            	</div>
			                        	</div>
			                    	</div>
			                	</div>
			                </div>
			                <div class="col-lg-6 col-md-7 col-12">
			                    <div class="add-post-btn float-right">
			                  		<button type="submit" class="btn btn-primary">수정</button>
			                  		<button type="button" class="btn btn-primary">목록으로</button>
			                    </div>
			                </div>
			            </div>
			        </form>
			    </div>
			</div>
		</div>
	</div>
</section>
<script type="text/javascript">
	$(document).ready(function(){
		var cnt = 1;
		var formObj = $("form[role='form']");
		$("#addBtn").click(function(){
			// alert("버튼 클릭");
			$("#fileDiv").append("<div><br><input id='cover_img_file_3' type='file' name='storedFileName"+(cnt++)+"' accept='image/*' ></div>")
		});
		$(".btn-primary").click(function(){
		    location.href = "/comboard/comListCri?page=${page}";
		});
		
		// GPT 교정 버튼 클릭
		$("#gptCheckBtn").click(function() {
		    let content = $("#com_content").val().trim();

		    if (content === "") {
		        alert("내용을 입력한 후 교정을 요청해주세요!");
		        return;
		    }

		    $("#gpt-result-box").show();
		    $("#gpt-corrected").text("GPT가 교정 중입니다... 잠시만 기다려주세요.");

		    $.ajax({
		        type: "POST",
		        url: "/comboard/grammarCheck",
		        data: { content: content },
		        success: function(response) {
		            $("#gpt-corrected").text(response);
		        },
		        error: function() {
		            $("#gpt-corrected").text("GPT 요청 중 오류가 발생했습니다. 다시 시도해주세요.");
		        }
		    });
		});

		// 교정된 문장 textarea에 넣기
		$("#useGptResult").click(function() {
		    const corrected = $("#gpt-corrected").text();
		    $("#com_content").val(corrected);
		    alert("GPT 교정 내용을 적용했습니다!");
		});
	});
</script>
<%@ include file="../include/Footer.jsp" %>
