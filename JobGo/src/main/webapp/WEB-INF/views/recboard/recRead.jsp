<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/Header.jsp"%>
<section class="add-resume section" >
	<div class="container" >
		<div class="row">
			<div class="col-lg-10 offset-lg-1 col-12">
			    <div class="add-resume-inner box">
			        <div id="com_top" class="post-header align-items-center justify-content-center">
		            	<form id="readForm" role="form">
							<input type="hidden" name="rec_bno" value="${resultReadVO.rec_bno}">
							<input type="hidden" name="page" value="${page}">
						</form>
			            <h3 id="title">
			            	<font dir="auto" style="vertical-align: inherit;">
			            		<font dir="auto" style="vertical-align: inherit;">
			            			채용 공고 게시판
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
		                               value="${resultReadVO.rec_title }"
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
		                        	   value="${resultReadVO.managerName }"
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
		                       value="${resultReadVO.managerEmail }"
		                       readonly>
		            </div>
		            <div class="form-group">
		                <label class="control-label">
		                	<font dir="auto" style="vertical-align: inherit;">
		                		<font dir="auto" style="vertical-align: inherit;">
		                			회사 주요 업무 소개
		                		</font>
		                	</font>
		                </label>
		                <textarea class="form-control" rows="7"
		                		  name="com_content"
		                          disabled
		                          required>${resultReadVO.rec_maintask }</textarea>
		            </div>
		            <div class="form-group">
		                <label class="control-label">
		                	<font dir="auto" style="vertical-align: inherit;">
		                		<font dir="auto" style="vertical-align: inherit;">
		                			채용 우대 사항
		                		</font>
		                	</font>
		                </label>
		                <textarea class="form-control" rows="7"
		                		  name="com_content"
		                          disabled
		                          required>${resultReadVO.rec_preference }</textarea>
		            </div>
		            <div class="form-group">
		                <label class="control-label">
		                	<font dir="auto" style="vertical-align: inherit;">
		                		<font dir="auto" style="vertical-align: inherit;">
		                			복리 후생
		                		</font>
		                	</font>
		                </label>
		                <textarea class="form-control" rows="7"
		                		  name="com_content"
		                          disabled
		                          required>${resultReadVO.rec_benefit }</textarea>
		            </div>
					<div class="col-12">
						<div class="button">
						<c:if test="${recLoginInfo eq resultReadVO.corpUserId}">
							<button type="submit" class="btn btn-update">수정</button>
							<button type="button" class="btn btn-delete">삭제</button>
						</c:if>
							<button type="submit" class="btn btn-list">목록으로</button>
						</div>
					</div>
					<hr>
			    </div>
			</div>
		</div>
	</div>
</section>
<%@ include file="../include/Footer.jsp"%>