<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/Header.jsp" %>
<style>
	.modal {
		display: none;
		position: fixed;
		z-index: 999;
		left: 0;
		top: 0;
		width: 100%;
		height: 100%;
		background-color: rgba(0, 0, 0, 0.4);
	}
	
	/* 모달 본체 */
	.modal-content {
		background-color: #fff;
		margin: 13% auto;
		padding: 30px 20px 35px;
		border: 1px solid #e5e7eb;
		width: 360px;
		border-radius: 12px;
		text-align: center;
		box-shadow: 0 8px 24px rgba(0,0,0,0.15);
		font-family: 'Noto Sans KR', sans-serif;
	}
	
	/* 제목 & 안내문 */
	.modal-title {
		font-size: 1.35rem;
		font-weight: 700;
		color: #111827;
		margin-bottom: 8px;
	}
	
	.modal-text {
		font-size: 0.92rem;
		color: #6b7280;
		margin-bottom: 22px;
	}
	
	/* 입력창 중앙 정렬 */
	.input-wrapper {
		display: flex;
		justify-content: center;
	}
	
	#confirmPwd {
		width: 80%;
		padding: 9px 10px;
		border: 1px solid #d1d5db;
		border-radius: 6px;
		font-size: 0.95rem;
		text-align: center; /* 중앙 정렬 */
	}
	
	/* 버튼 영역 */
	.modal-btns {
		display: flex;
		flex-direction: column;
		gap: 10px;
		margin-top: 25px;
	}
	
	.btn-cancel,
	.btn-confirm {
		width: 85%;
		margin: 0 auto;
		padding: 10px 0;
		border-radius: 6px;
		cursor: pointer;
		font-size: 0.95rem;
		font-weight: 500;
		transition: all 0.2s;
	}
	
	.btn-cancel {
		background-color: #fff;
		border: 1px solid #d1d5db;
		color: #111827;
	}
	
	.btn-cancel:hover {
		background-color: #f9fafb;
	}
	
	.btn-confirm {
		background-color: #2563EB; /* 파란 포인트 */
		color: #fff;
		border: 1px solid #2563EB;
	}
	
	.btn-confirm:hover {
		background-color: #1d4ed8;
	}
</style>
<section class="add-resume section" >
	<div class="container" >
		<div class="row">
			<div class="col-lg-10 offset-lg-1 col-12">
			    <div class="add-resume-inner box">
			        <div id="com_top" class="post-header align-items-center justify-content-center">
		            	<form id="readForm" role="form">
							<input type="hidden" name="com_bno" value="${resultReadVO.com_bno }">
							<input type="hidden" name="page" value="${page }">
						</form>
			            <h3 id="title">
			            	<font dir="auto" style="vertical-align: inherit;">
			            		<font dir="auto" style="vertical-align: inherit;">
			            			커뮤니티 게시판
			            		</font>
			            	</font>
			            </h3>
			        </div>
			        <hr>
		            <h3 class="single-section-title">
		            	<font dir="auto" style="vertical-align: inherit;">
		            		<font dir="auto" style="vertical-align: inherit;">
		            			게시판 본문읽기
		            		</font>
		            	</font>
		            </h3>
		            <div class="row">
		                <div class="col-lg-6 col-12">
		                    <div class="form-group">
		                        <label class="control-label">
		                        	<font dir="auto" style="vertical-align: inherit;">
		                        		<font dir="auto" style="vertical-align: inherit;">
		                        			글 제목
		                        		</font>
		                        	</font>
		                        </label>
		                        <input type="text" class="form-control" 
		                               value="${resultReadVO.com_title }"
		                               readonly >
		                    </div>
		                </div>
		                <div class="col-lg-6 col-12">
		                    <div class="form-group">
		                        <label class="control-label">
		                        	<font dir="auto" style="vertical-align: inherit;">
		                        		<font dir="auto" style="vertical-align: inherit;">
		                        			작성자
		                        		</font>
		                        	</font>
		                        </label>
		                        <input type="text" class="form-control"
		                        	   value="${resultReadVO.writer }"
		                               readonly>
		                    </div>
		                </div>
		            </div>
		            <div class="form-group">
		                <label class="control-label">
		                	<font dir="auto" style="vertical-align: inherit;">
		                		<font dir="auto" style="vertical-align: inherit;">
		                			E-mail
		                		</font>
		                	</font>
		                </label>
		                <input type="text" class="form-control" 
		                       value="${resultReadVO.email }"
		                       readonly>
		            </div>
		            <div class="form-group">
		                <label class="control-label">
		                	<font dir="auto" style="vertical-align: inherit;">
		                		<font dir="auto" style="vertical-align: inherit;">
		                			글 내용
		                		</font>
		                	</font>
		                </label>
		                <textarea class="form-control" rows="7"
		                		  name="com_content"
		                          disabled
		                          required>${resultReadVO.com_content }</textarea>
		            </div>
		            <div class="form-group">
					    <label>첨부파일</label>
					    <c:choose>
					        <c:when test="${not empty resultReadVO.storedFileName}">
					            <select id="fileSelect" class="form-control">
					                <option value="">-- 첨부파일을 선택하세요 --</option>
					                <c:forTokens var="file" items="${resultReadVO.storedFileName}" delims=",">
					                    <option value="${file}">${file}</option>
					                </c:forTokens>
					            </select>
					        </c:when>
					        <c:otherwise>
					            <p>첨부된 파일이 없습니다.</p>
					        </c:otherwise>
					    </c:choose>
					</div>
					<div class="col-12">
						<div class="button">
						<c:if test="${loginUserId eq resultReadVO.userid}">
							<button type="submit" class="btn btn-update">수정</button>
							<button type="button" class="btn btn-delete">삭제</button>
						</c:if>
							<button type="submit" class="btn btn-list">목록으로</button>
						</div>
					</div>
			    </div>
			</div>
		</div>
	</div>
</section>
	<!-- 비밀번호 확인 모달 -->
	<div id="pwdModal" class="modal" style="display:none;">
		<div class="modal-content">
			<h3 class="modal-title">비밀번호 확인</h3>
			<p class="modal-text">본인 확인을 위해 비밀번호를 입력하세요</p>
			<div class="input-wrapper">			
				<input type="password" id="confirmPwd" placeholder="비밀번호 입력">
			</div>
			<div class="modal-btns">
		    	<button id="cancelBtn" class="btn-cancel">취소</button>
		        <button id="pwdCheckBtn" class="btn-confirm">확인</button>
		    </div>
		</div>
	</div>
<script type="text/javascript">
	$(document).ready(function(){
	
		const formObj = $("#readForm");
		const comBno = "${resultReadVO.com_bno}";
	
		// 첨부파일 선택 시 다운로드
		$('#fileSelect').change(function() {
	        const fileName = $(this).val();
	        if (fileName) {
	            window.location.href = '/comboard/download?fileName=' + encodeURIComponent(fileName);
	        }
	    });
	
		// 수정 버튼
		$(".btn-update").click(function(){
			formObj.attr("action","/comboard/comUpdate");
			formObj.submit();
		});
	
		// 목록 버튼
		$(".btn-list").click(function(){
			location.href="/comboard/comListCri?page=${page}";
		});
	
		// 삭제 버튼 → 모달 표시
		$(".btn-delete").click(function(e){
			e.preventDefault();
			$("#pwdModal").fadeIn();
		});
	
		// 버튼 닫기
		$("#cancelBtn").click(function(){
			$("#pwdModal").fadeOut();
		});
	
		// 모달 배경 클릭 닫기
		$(window).click(function(e){
			if($(e.target).is("#pwdModal")){
				$("#pwdModal").fadeOut();
			}
		});
	
		// 비밀번호 확인 → Ajax 검증 후 삭제
		$("#pwdCheckBtn").click(function(){
			const inputPwd = $("#confirmPwd").val().trim();
	
			if(inputPwd === ""){
				alert("비밀번호를 입력하세요.");
				return;
			}
	
			$.ajax({
				type: "POST",
				url: "/comboard/checkPassword",
				data: { password: inputPwd },
				success: function(result){
					if(result === "OK"){
						alert("확인되었습니다. 게시글을 삭제합니다.");
						formObj.attr("action","/comboard/comDelete");
						formObj.attr("method","POST");
						formObj.append('<input type="hidden" name="com_bno" value="'+comBno+'">');
						formObj.submit();
					}else if(result === "FAIL"){
						alert("비밀번호가 일치하지 않습니다.");
					}else if(result === "NOT_LOGIN"){
						alert("로그인 후 이용해주세요.");
						location.href="/member/login";
					}
				},
				error: function(){
					alert("서버 오류가 발생했습니다.");
				}
			});
		});
	});
</script>
<%@ include file="../include/Footer.jsp" %>
