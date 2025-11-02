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
	<div class="container" >
		<div class="row">
			<div class="col-lg-10 offset-lg-1 col-12">
			    <div class="add-resume-inner box">
			        <div id="com_top" class="post-header align-items-center justify-content-center">
		            	<form role="form">
							<input type="hidden" name="bno" value="${resultReadVO.com_bno }">
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
							<button type="submit" class="btn btn-delete">삭제</button>
						</c:if>
							<button type="submit" class="btn btn-list">목록으로</button>
						</div>
					</div>
			    </div>
			</div>
		</div>
	</div>
</section>
<script type="text/javascript">
	$(document).ready(function(){
		$('#fileSelect').change(function() {
	        var fileName = $(this).val();
	        if (fileName) {
	            // 선택된 파일이 있으면 다운로드 요청
	            window.location.href = '/comboard/download?fileName=' + encodeURIComponent(fileName);
	        }
	    });
		
		var formObj = $("form[role='form']");
		
		$(".btn-update").click(function(){
			formObj.attr("action","/comboard/update");
			formObj.submit();
		});
		
		$(".btn-delete").click(function(){
			formObj.attr("action","/board/delete");
			formObj.attr("method","POST");
			formObj.submit();
		}); 
		
		$(".btn-list").click(function(){
			location.href="/comboard/comListCri?page=${page}";
		}); 
	});
</script>
<%@ include file="../include/Footer.jsp" %>
