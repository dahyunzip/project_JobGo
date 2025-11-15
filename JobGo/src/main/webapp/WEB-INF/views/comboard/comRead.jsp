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
<section class="section" >
	<h2 class="pageTitle">커뮤니티</h2>
	<div class="container" >
		<div class="boardHeader">
			<h2>${resultReadVO.com_title }</h2>
			<div>
				<p>
					<b>작성자:</b>${resultReadVO.writer }
				</p>
			</div>
		</div>
		<div class="boardBody">
			${resultReadVO.com_content }
		</div>
		<dl class="detailView">
			<dt><label>첨부파일</label></dt>
			<dd>
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
		    </dd>
		</dl>
		<hr>
	    <div class="add-resume-inner box">
	        <div id="com_top" class="post-header align-items-center justify-content-center">
            	<form id="readForm" role="form">
					<input type="hidden" name="com_bno" value="${resultReadVO.com_bno}">
					<input type="hidden" name="page" value="${page}">
				</form>
	        </div>
            <%-- <div class="form-group">
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
			</div>--%>
			<!-- 비동기 댓글 영역 -->
			<div class="form-group mb-20 ">
				<div class="comment">
					<h5>댓글 (<span id="rcount">0</span>)</h5>
					<div id="replyArea">
						<c:if test="${!empty loginUserId}">
							<form id="replyForm">
								<input type="text" class="form-control" id="reply_content"
									name="reply_content" placeholder="다양한 의견을 작성해 보세요!">
							</form>
						</c:if>
						<c:if test="${empty loginUserId and empty recLoginInfo}">
							<p>
								<a id="loginLink" href="#">로그인</a> 후 댓글 작성이 가능합니다.
							</p>
							<script>
							  const returnOldPath = "/comboard/comRead?com_bno=${resultReadVO.com_bno}&page=${page}";
							  const encoded = encodeURIComponent(returnOldPath);
							  document.getElementById("loginLink").href = "/member/login?oldPath=" + encoded;
							</script>
						</c:if>
						<c:if test="${!empty recLoginInfo}">
							<p>불편을 드려 죄송합니다 (┬┬﹏┬┬) 일반회원만 댓글 작성이 가능합니다.</p>
						</c:if>
					</div>
					<div class="button">
						<button class="btn">등록</button>
					</div>
				</div>
                <hr>
				<table class="table-default table-responsive" style="word-break: break-word;">
					<colgroup>
						<col width="10%">
						<col width="*">
						<col width="10%">
						<col width="12%">
					</colgroup>
					<thead>
						<tr>
							<th>작성자</th>
							<th>내용</th>
							<th>작성일</th>
							<c:if test="${!empty loginUserId}">									
								<th>기능</th>
							</c:if>
						</tr>
					</thead>
					<tbody class="replyList">
					
					</tbody>
				</table>
			</div>
			<!-- 비동기 댓글 영역 -->
			<div class="boardFoot text-right">
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
	let comBno = null;         
	let loginUserId = null;
	
	$(document).ready(function(){
	
		const formObj = $("#readForm");
		
		comBno = "${resultReadVO.com_bno}";
		loginUserId = "${loginUserId}";
		
		console.log("comBno:", comBno);
	    console.log("loginUserId:", loginUserId);
	
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
	
		// 삭제 버튼
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
				}
			});
		});
		
		// 댓글 검색 from 태그 감지
		$("#replyForm").on("submit", function(e) {
			  writeReplySection();
			  e.preventDefault();
		});
		
		$(".comment .btn").click(function(){
			$("#replyForm").submit();
		});
		
		// 댓글 추가
		function writeReplySection() {
			// alert("REST 호출"+"${loginUserId}");
			
			$.ajax({
				type:"POST",
				url: "/reply/writeReply/"+comBno,
				data: {
					reply_writer:'${loginUserId}',
					reply_content: $("#reply_content").val()
				},
				success: function(result,statusText,jquXHR){
					if(jquXHR.status == "200") {
						// alert("REST 컨트롤러 다녀옴!");
						if(result == 0) {
							alert("댓글 등록 실패")
						} else {
							alert("댓글 등록 성공")
						}
						getReplyList();
						$("#reply_content").val("");
					}
				},
				error: function(data){
					// alert("테스트e");
					console.log(data);
				}
			});
			
			// alert("REST 호출2"+comBno);
			
		}
		
		getTimeAgo();
		getReplyList();
		
	});
	
	// 댓글 작성 시간 계산 로직
	function getTimeAgo(createDate) {
	    const now = new Date();                // 현재 시각
	    const written = new Date(createDate);  // 댓글 작성 시각
	    const diffMs = now - written;          // 시간 차 (밀리초)

	    const diffMin = Math.floor(diffMs / 1000 / 60);
	    const diffHour = Math.floor(diffMin / 60);
	    const diffDay = Math.floor(diffHour / 24);

	    if (diffMin < 1) return "방금 전";
	    if (diffMin < 60) return diffMin + "분 전";
	    if (diffHour < 24) return diffHour + "시간 전";
	    if (diffDay < 7) return diffDay + "일 전";

	    // 7일 이상이면 날짜 형식으로 표시
	    return written.getFullYear().toString().slice(2) + "년 " + 
	           (written.getMonth() + 1) + "월 " + 
	           written.getDate() + "일";
	}
	
	// 댓글 목록 비동기 조회
	function getReplyList() {
		
		$.ajax({
			type: "GET",
			url: "/reply/repList/"+comBno,
			success: function(result,statusText,jquXHR){
				// alert("REST 컨트롤러 다녀옴!");
				// console.log(repList);
				var tag = "";
				if(jquXHR.status == "200") {
					
	
					console.log("댓글 데이터:", result); // ← 여기서 배열 확인
	
					$(result).each(function(idx, item) {
					/* 	var date = new Date(item.create_date);
						
						var year = String(date.getFullYear()).slice(2); // ← '2025' → '25'
						var month = date.getMonth() + 1;
						var day = date.getDate();
						var hours = String(date.getHours()).padStart(2, '0');
						var minutes = String(date.getMinutes()).padStart(2, '0'); */
						
						/* 
						var dateYMD = year + "년 " + 
									  month + "월 " + 
									  day + "일 " + 
									  hours + "시 " +
									  minutes + "분";
						
						console.log(date); */
						
						const dateText = getTimeAgo(item.create_date);
	
						tag += "<tr>";
						tag += "<td>" + item.writerUserid + "</td>";
						tag += "<td>" + item.reply_content + "</td>";
						tag += "<td>" + dateText + "</td>";
						if (loginUserId) {
                            tag += "<td>";
                            if (loginUserId == item.writerUserid) {
                                tag += "<button class='btn btn-sm btn-primary mt-1' onclick='updateReply(" + item.reply_no + ", this)'>수정</button>";
                                tag += "<button class='btn btn-sm btn-secondary mt-1' onclick='deleteReply(" + item.reply_no + ")'>삭제</button>";
                            }
                            tag += "</td>";
                        }
						tag += "</tr>";
					});
				}

				$(".replyList").html(tag);
				$("#rcount").text(result.length);
		    }	 
		});
	}

	// 댓글 수정창 열기
	function updateReply(reply_no, btn) {
	    const $td = $(btn).closest("tr").find("td").eq(1); // 두 번째 td (댓글 내용칸)
	    const oldContent = $td.text().trim();

	    // textarea + 저장/취소 버튼 생성
	    let editTag = "";
	    editTag += "<textarea id='savedata' class='form-control' rows='2'>" + oldContent + "</textarea>";
	    editTag += "<button class='btn btn-sm btn-success mt-1' onclick='saveUpdateReply(" + reply_no + ", this)'>저장</button>";
	    editTag += "<button class='btn btn-sm btn-secondary mt-1' onclick='cancelUpdateReply(this, \"" + oldContent + "\")'>취소</button>";

	    $td.html(editTag);
	}
	
	// 수정 취소 버튼(원래 내용 복원)
	function cancelUpdateReply(btn, oldContent) {
	    const $td = $(btn).closest("tr").find("td").eq(1);
	    $td.html(oldContent);
	}
	
	// 수정 저장 버튼(바뀐 내용 저장)
	function saveUpdateReply(reply_no, btn) {
		// alert("saveUpdateReply함수 접근!");
		const $tb = $(btn).closest("tr").find("td").eq(1);
		const newContent = $tb.find("#savedata").val().trim();
		
		if(newContent == "") {
			alert("댓글 내용을 입력하세요.");
			return;
		}
		
		const replyData = {
				reply_no: reply_no,
				reply_content: newContent
		}
		
		$.ajax({
			type: "PUT",
			url : "/reply/replyUpdate/"+reply_no,
			data: JSON.stringify(replyData),
			contentType: "application/json; charset=UTF-8",
			success: function(result,statusText,jquXHR){
				// alert("REST컨트롤러 다녀옴!");
				if(jquXHR.status == "200"){
					if(result > 0){
						alert("댓글이 수정되었습니다.");
						getReplyList();
					} else {
						alert("댓글 수정 실패");
					}
				}
			},
			error: function(data){
				// alert("테스트e");
				console.log(data);
			}
		});
		
	}
	
	// 댓글 삭제
	function deleteReply(reply_no){
		// alert(" deleteReply() 함수 진입 ")
		if(confirm('정말로 댓글을 삭제하겠습니까?')) {
			
			$.ajax({
				type : 'DELETE',
				url : '/reply/replyDelete/'+reply_no,
				data : {
					reply_no:reply_no
					},
				success : function(result,statusText,jquXHR){
					// alert(" REST 컨트롤러 진입 ")
					if(jquXHR.status == "200"){	
						if(result > 0){
							alert("삭제성공")
							getReplyList();
						}else{
							alert("삭제실패")
						}
					}
				}
			});
		}
	}
</script>
<%@ include file="../include/Footer.jsp" %>
