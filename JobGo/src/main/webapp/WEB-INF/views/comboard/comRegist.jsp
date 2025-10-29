<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/Header.jsp"%>
<style>
#com_top {
	display: flex;
	justify-content: center;
	align-items: center;
	margin-bottom: 15px;
}
</style>
<section class="add-resume section">
	<div class="container">
		<div class="row">
			<div class="col-lg-10 offset-lg-1 col-12">
				<div class="add-resume-inner box">
					<div id="com_top"
						class="post-header align-items-center justify-content-center">
						<h3 id="title">
							<font dir="auto" style="vertical-align: inherit;"> <font
								dir="auto" style="vertical-align: inherit;">${memberLoginInfo.name }</font>
							</font>
						</h3>
					</div>
					<hr>
					<form class="form-ad" method="post">
						<h3 class="single-section-title">
							<font dir="auto" style="vertical-align: inherit;"> <font
								dir="auto" style="vertical-align: inherit;">글 작성</font>
							</font>
						</h3>
						<div class="row">
							<div class="col-lg-6 col-12">
								<div class="form-group">
									<label class="control-label"> <font dir="auto"
										style="vertical-align: inherit;"> <font dir="auto"
											style="vertical-align: inherit;">글 제목</font>
									</font>
									</label> <input type="text" class="form-control" name="com_title"
										placeholder="게시글 제목을 작성 해주세요." required>
								</div>
							</div>
							<div class="col-lg-6 col-12">
								<div class="form-group">
									<label class="control-label"> <font dir="auto"
										style="vertical-align: inherit;"> <font dir="auto"
											style="vertical-align: inherit;">이름</font>
									</font>
									</label> <input type="text" class="form-control"
										placeholder="전공, 예: 컴퓨터 과학">
								</div>
							</div>
						</div>
						<div class="form-group">
							<div class="row">
								<div class="col-md-6">
									<label class="control-label"><font dir="auto"
										style="vertical-align: inherit;"><font dir="auto"
											style="vertical-align: inherit;">에서</font></font></label> <input type="text"
										class="form-control" placeholder="예를 들어 2014년">
								</div>
								<div class="col-md-6">
									<label class="control-label"><font dir="auto"
										style="vertical-align: inherit;"><font dir="auto"
											style="vertical-align: inherit;">에게</font></font></label> <input type="text"
										class="form-control" placeholder="예를 들어 2020년">
								</div>
							</div>
						</div>
						<div class="form-group">
							<label class="control-label"><font dir="auto"
								style="vertical-align: inherit;"><font dir="auto"
									style="vertical-align: inherit;">학교</font></font></label> <input type="text"
								class="form-control" placeholder="학교 이름, 예: 매사추세츠 공과대학교">
						</div>
						<div class="form-group">
							<label class="control-label"><font dir="auto"
								style="vertical-align: inherit;"><font dir="auto"
									style="vertical-align: inherit;">설명</font></font></label>
							<textarea class="form-control" rows="7"></textarea>
						</div>
						<div class="row align-items-center justify-content-center">
							<div class="col-lg-6 col-md-5 col-12">
								<div class="form-group">
									<div class="button-group">
										<div class="action-buttons">
											<div class="upload-button button">
												<button class="btn">
													<font dir="auto" style="vertical-align: inherit;"><font
														dir="auto" style="vertical-align: inherit;">커버 로고를
															선택하세요</font></font>
												</button>
												<input id="cover_img_file_3" type="file">
											</div>
										</div>
									</div>
								</div>
							</div>
							<div class="col-lg-6 col-md-7 col-12">
								<div class="add-post-btn float-right">
									<ul>
										<li><a href="#" class="btn-added"><i
												class="lni lni-add-files"></i><font dir="auto"
												style="vertical-align: inherit;"><font dir="auto"
													style="vertical-align: inherit;">새로운 교육 추가</font></font></a></li>
										<li><a href="#" class="btn-delete"><i
												class="lni lni-remove-file"></i><font dir="auto"
												style="vertical-align: inherit;"><font dir="auto"
													style="vertical-align: inherit;"> 이것을 삭제하세요</font></font></a></li>
									</ul>
								</div>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</section>
<%@ include file="../include/Footer.jsp"%>