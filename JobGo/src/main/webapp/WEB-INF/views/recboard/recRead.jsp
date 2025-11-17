<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/Header.jsp"%>
<style>
	#box1 {
		display: flex;
		gap: 20px;
		justify-content: space-between;
	}
	#box1 > div {
	    flex: 1;  
	}
	
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
<section class="section">
	<h2 class="pageTitle">채용공고</h2>
    <div class="container">
        <div class="row">
            <div class="col-12">
                <div class="add-resume-inner box">                        
            		<form id="readForm" role="form" >
            			<input type="hidden" name="rec_bno" value="${resultReadVO.rec_bno}">
                        <input type="hidden" name="recPage" value="${recPage != null ? recPage : 1}">
                    </form>
                    <div id="com_top" class="post-header align-items-center justify-content-center">
                    	<div class="comTopInfo">
                    		<h3 class="single-section-title">${resultReadVO.rec_title}</h3>
                        	<p>소속: ${resultReadVO.companyName} | 모집 담당자: ${resultReadVO.managerName}(${resultReadVO.managerEmail})님</p>
                    	</div>
                    	<div class="comTopThumb">
                    		<c:choose>
								<c:when test="${empty resultReadVO.thumbFileName}">
									<img src="/resources/images/default_image.jpg" class="profile-img">
								</c:when>
								<c:otherwise>
									 <img src="/upload/recfile/${resultReadVO.thumbFileName}" onerror="this.onerror=null; this.src='/resources/images/default_image.jpg'">
								</c:otherwise>
							</c:choose>
                    	</div>
                    </div>
                    <hr>
                    <div class="row">
                    	<h6 class="mb-10">지원하기</h6>
                        <div class="col-lg-12 col-12">
                            <div class="form-group">
								<c:choose>
									<c:when test="${not empty recLoginInfo}">
										<p>기업회원 로그인 중입니다: ${resultReadVO.companyName}</p>
									</c:when>

									<c:when test="${not empty sessionScope.memberId}">
										<c:choose>
											<%-- 이미 지원한 경우 --%>
											<c:when test="${alreadyApplied}">
												<p class="text-danger fw-bold">
													이미 지원한 채용공고입니다. 지원취소는 <a href="/application/list" class="underline-link">커리어관리 &gt; 지원현황</a>에서 가능합니다.
												</p>
											</c:when>
											<c:when test="${empty resumeList }">
												<p>지원가능한 상태의 이력서가 없습니다. 임시저장 상태의 이력서는 지원할 수 없습니다.</p>
											</c:when>
											<%-- 아직 지원 안한 경우 --%>
											<c:otherwise>
												<form method="post" action="/application/apply">
													<input type="hidden" name="rec_bno" value="${resultReadVO.rec_bno}">
													<input type="hidden" name="recPage" value="${recPage}">
													<div class="applyBtnWrap">
														<div class="selectBox">
														<select name="resume_id" class="form-control">
															<c:forEach var="resume" items="${resumeList}">
																<option value="${resume.resumeId}">${resume.resumeTitle}</option>
															</c:forEach>
														</select>
														</div>
														<div class="btns">
															<button type="submit" class="btn btn-primary">지원하기</button>
														</div>
													</div>
												</form>
											</c:otherwise>
										</c:choose>
									</c:when>

									<c:otherwise>
										<p>
											로그인 후 지원이 가능합니다. <a id="loginLink">로그인</a>
										</p>
										<script>
										const returnOldPath = "/recboard/recRead?rec_bno=${resultReadVO.rec_bno}&page=${page}";
										const encoded = encodeURIComponent(returnOldPath);
										document.getElementById("loginLink").href = "/member/login?oldPath=" + encoded;
										</script>
									</c:otherwise>
								</c:choose>
							</div>
                        </div>
                    </div>
                    <hr>
                    <!-- 다음 지도 API 출력 공간 -->
                    <div class="form-group">
                    	<h6 class="mb-10"><span>회사 위치</span></h6>
	                    <div id="map" style="width:100%;height:300px;margin-top:10px;border-radius:10px;">
	                    
	                    </div>
                    </div> <br>
                    <div class="cont-head">
                    	<h6 class="mb-10"><span>입사 자격 요건</span></h6>
                        <p>${resultReadVO.rec_qualification}</p>
                    </div>
                    <div class="cont-head">
                    	<h6 class="mb-10"><span>채용 우대 사항</span></h6>
                        <p>${resultReadVO.rec_preference}</p>
                    </div>
                    <div class="cont-head">
                    	<h6 class="mb-10"><span>복리 후생</span></h6>
                        <p>${resultReadVO.rec_benefit}</p>
                    </div> 
                    <div class="cont-head">
                    	<h6 class="mb-10"><span>회사 주요 업무 소개</span></h6>
                    	<p>${resultReadVO.rec_maintask}</p>
                    </div>
                    <div class="cont-head">
                    	<h6 class="mb-10"><span>회사 전경 및 사내 전경</span></h6>
                   	    <div class="image-box">
					        <c:if test="${not empty resultReadVO.attachFileName}">
					            <c:forEach var="file" items="${fn:split(resultReadVO.attachFileName, ',')}">
					                <img src="/upload/recfile/${file}" 
					                     alt="회사 이미지"
					                     class="company-img"
					                     style="width: 100%; height: auto;" onerror="this.onerror=null; this.src='/resources/images/default_image.jpg'"> <br><br>
					            </c:forEach>
					        </c:if>
					
					        <c:if test="${empty resultReadVO.attachFileName}">
					            <p>등록된 추가 이미지가 없습니다.</p>
					        </c:if>
					    </div>
                    </div>
                    <hr>
                    <div class="col-12 text-center">
                        <div class="button">
                            <c:if test="${not empty recLoginInfo and recLoginInfo.corpUserId eq resultReadVO.corpUserId}">
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
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=f741118517088ca2272cc9689f78f15e&libraries=services"></script>
<script type="text/javascript">
	let recBno = "${resultReadVO.rec_bno}";
	$(document).ready(function(){
		var status = '${msg}';
		if(status == 'applySuccess'){
			alert('입사지원 처리 되었습니다!');
		}
		
		const formObj = $("#readForm");
		
		// 수정 버튼
		$(".btn-update").click(function(){
			formObj.attr("action","/recboard/recUpdate");
			formObj.submit();
		});
		
		// 목록 버튼
		$(".btn-list").click(function(){
			const recPage = "${recPage}" || 1;
			location.href = "/recboard/recListCri?recPage=" + recPage;
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
				url: "/recboard/checkPassword",
				data: { password: inputPwd },
				success: function(result){
					if(result === "OK"){
						alert("확인되었습니다. 게시글을 삭제합니다.");
						formObj.attr("action","/recboard/recDelete");
						formObj.attr("method","POST");
						formObj.append('<input type="hidden" name="rec_bno" value="'+recBno+'">');
						formObj.submit();
					}else if(result === "FAIL"){
						alert("비밀번호가 일치하지 않습니다.");
					}else if(result === "NOT_LOGIN"){
						alert("로그인 후 이용해주세요.");
						location.href="/corp/login";
					}
				}
			});
		});
		
		// recWrite에서 전달된 주소값
		const address = "${resultReadVO.rec_inputlct}";
		
		if(!address || address.trim() == "") {
			alert("근무지 상세 주소 정보가 없습니다.");
			return
		}
		
		// 지도 기본 설정(좌표값: 서울)
		const mapContainer = $("#map")[0];
		const mapOption = {
				center:  new kakao.maps.LatLng(33.450701, 126.570667),
				level: 3
		}
		
		const map = new kakao.maps.Map(mapContainer, mapOption);
		const geocoder = new kakao.maps.services.Geocoder();
		
		// 주소값 -> 좌표값으로 변경
		geocoder.addressSearch(address, function(result, status){
			if(status == kakao.maps.services.Status.OK) {
				
				// 지도 중심 이동
				const coords = new kakao.maps.LatLng(result[0].y, result[0].x);
				map.setCenter(coords);
				
				// 마커 표시
				const marker = new kakao.maps.Marker({
					map: map,
					position: coords
				});
				
				// 인포윈도우 표시
				const infowindow = new kakao.maps.InfoWindow({
					content: '<div style="padding:5px 10px;font-size:13px;">' + address + '</div>'
				});
				infowindow.open(map, marker);
			} else {
				console.error("주소 변환 실패:",status);
			}
		});
		
	
		
	});
</script>
<%@ include file="../include/Footer.jsp"%>