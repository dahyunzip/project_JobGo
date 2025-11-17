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
	.checkbox input[type="checkbox"] {
	    transform: scale(1) !important;
	    width: 16px !important;
	    height: 16px !important;
	}
	
</style>
<section class="section" >
<h2 class="pageTitle">커뮤니티</h2>
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
			        <%-- <div id="com_top" class="post-header align-items-center justify-content-center">
			            <h3 id="title">
			            	<font dir="auto" style="vertical-align: inherit;">
			            		<font dir="auto" style="vertical-align: inherit;">${memberLoginInfo.name }</font>
			            	</font>
			            </h3>
			        </div> --%>
			        <form class="form-ad" method="post" enctype="multipart/form-data">
			            <!-- <h3 class="single-section-title">
			            	<font dir="auto" style="vertical-align: inherit;">
			            		<font dir="auto" style="vertical-align: inherit;">제목</font>
			            	</font>
			            </h3> -->
			            <div class="row">
			                <div class="col-lg-12 col-12">
			                    <div class="form-group">
			                        <label class="control-label">
			                        	<font dir="auto" style="vertical-align: inherit;">
			                        		<font dir="auto" style="vertical-align: inherit;">글 제목</font>
			                        	</font>
			                        </label>
			                        <input type="text" class="form-control" 
			                               name="com_title"
			                               placeholder="게시글 제목을 작성 해주세요."
			                               required >
			                    </div>
			                </div>
			                <div class="col-lg-12 col-12">
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
			            <%-- <div class="form-group">
			                <label class="control-label">
			                	<font dir="auto" style="vertical-align: inherit;">
			                		<font dir="auto" style="vertical-align: inherit;">E-mail</font>
			                	</font>
			                </label>
			                <input type="text" class="form-control" 
			                       value="${memberLoginInfo.email }"
			                       readonly>
			            </div> --%>
						<div class="form-group">
						    <label class="control-label">글 내용</label>
						    <textarea class="form-control" rows="7"
						              name="com_content"
						              id="com_content"
						              placeholder="자유롭게 글을 작성하세요!"
						              required></textarea>
						
						    <!-- GPT 버튼 -->
						    <div class="mt-2 button text-right">
						        <button type="button" class="btn btn-outline-primary btn-sm" id="gptCheckBtn">
						            GPT 맞춤법 교정
						        </button>
						    </div>
						
						    <!-- GPT 결과 박스 -->
						    <div id="gptResultBox" class="gpt-result mt-3 p-3 border rounded bg-white" style="display:none;">
						        <h6>GPT 교정 결과</h6>
						        <pre id="gptResultText" style="white-space:pre-wrap;"></pre>
						        <button type="button" class="btn btn-success btn-sm mt-2" id="applyGptBtn">
						            교정내용 적용하기
						        </button>
						    </div>
						</div>
			            <div class="row align-items-center justify-content-center">
			                <div class="col-lg-12 col-md-12 col-12">
			                    <div class="form-group">
			                        <div class="button-group">
			                            <div class="action-buttons">
			                                <div class="">
								                <div class="checkbox">
											        <label>
											        	<input type="checkbox" required> 내용을 한번 더 확인 해 주세요.
											        </label>
									            </div>	
			                                    <hr>
			                                    <div class="text-right">
													<input type="button" value=" 첨부파일 추가하기" id="addBtn" class="btn-success mb-10 btn">
				                                    <input id="cover_img_file_3" type="file" name="storedFileName" accept="image/*" class="form-control">
			                                    </div>
			                                    <div id="fileDiv">
			                                    
			                                    </div>
			                                </div>
			                            </div>
			                        </div>
			                    </div>
			                </div>
			            </div>
		                <div class="col-12">
		                    <div class="button text-center mt-20">
		                  		<button type="submit" class="btn btn-primary">글쓰기</button>
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
		$("#addBtn").click(function(){
			// alert("버튼 클릭");
			$("#fileDiv").append("<div><br><input id='cover_img_file_3' type='file' name='storedFileName"+(cnt++)+"' accept='image/*' class='form-control'></div>")
		});
		
		// GPT 맞춤법 교정 요청
		$("#gptCheckBtn").on("click", function() {
		    const content = $("#com_content").val().trim();

		    if (content === "") {
		        alert("내용을 입력한 후 교정을 요청해주세요!");
		        return;
		    }

		    // 결과 박스 보이기 + 로딩 메시지
		    $("#gptResultBox").show();
		    $("#gptResultText").text("GPT가 교정 중입니다... 잠시만 기다려주세요.");

		    $.ajax({
		        type: "POST",
		        url: "/comboard/grammarCheck",
		        data: { content: content },
		        success: function(result) {
		            $("#gptResultText").text(result);
		        },
		        error: function() {
		            $("#gptResultText").text("GPT 요청 중 오류가 발생했습니다. 다시 시도해주세요.");
		        }
		    });
		});

		// GPT 내용 적용하기
		$("#applyGptBtn").on("click", function() {
		    const text = $("#gptResultText").text();
		    $("#com_content").val(text);
		    alert("GPT 교정 내용을 적용했습니다!");
		});
	});
</script>
<%@ include file="../include/Footer.jsp" %>
