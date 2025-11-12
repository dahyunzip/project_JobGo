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
<section class="add-resume section">
    <div class="container">
        <div class="row">
            <div class="col-lg-10 offset-lg-1 col-12">
                <div class="add-resume-inner box">                        
            		<form id="readForm" role="form" >
            			<input type="hidden" name="rec_bno" value="${resultReadVO.rec_bno}">
                        <input type="hidden" name="page" value="${page}">
                    </form>
                    <div id="com_top" class="post-header align-items-center justify-content-center">
                        <img src="/upload/recfile/${resultReadVO.thumbFileName}" width="100%" height="100px" style="object-fit: cover; display: block;">
                    </div>
                    
                    <hr>

                    <div class="row">
                        <div class="col-lg-6 col-12">
                            <div class="form-group">
                            	<div>
			                    	<h3 class="single-section-title">(주)${resultReadVO.companyName} 직원 채용 공고문</h3>
			                    </div>
                                <label class="control-label">
                                    <font dir="auto" style="vertical-align: inherit;">
                                        <font dir="auto" style="vertical-align: inherit;">
                                            ${resultReadVO.rec_title} / 모집 담당자: ${resultReadVO.managerName}(${resultReadVO.managerEmail})
                                        </font>
                                    </font>
                                </label>
                            </div>
                        </div>
                    </div>
                    <hr>
                    <!-- 다음 지도 API 출력 공간 -->
                    <div class="form-group">
                    	<label class="control-label">
                            <font dir="auto" style="vertical-align: inherit;">
                                <font dir="auto" style="vertical-align: inherit;">
                                    회사 위치
                                </font>
                            </font>
                        </label>
	                    <div id="map" style="width:100%;height:300px;margin-top:10px;border-radius:10px;">
	                    
	                    </div>
                    </div> <br>
                    <div id="box1">
	                    <div class="form-group1">
	                        <label class="control-label">
	                            <font dir="auto" style="vertical-align: inherit;">
	                                <font dir="auto" style="vertical-align: inherit;">
	                                    입사 자격 요건
	                                </font>
	                            </font>
	                        </label>
	                        <textarea class="form-control" rows="3" name="com_content" disabled required>${resultReadVO.rec_qualification}</textarea>
	                    </div> <br>
	                    
	                    <div class="form-group2">
	                        <label class="control-label">
	                            <font dir="auto" style="vertical-align: inherit;">
	                                <font dir="auto" style="vertical-align: inherit;">
	                                    채용 우대 사항
	                                </font>
	                            </font>
	                        </label>
	                        <textarea class="form-control" rows="3" name="com_content" disabled required>${resultReadVO.rec_preference}</textarea>
	                    </div> 
                    </div> <br>
                    
                    <div class="form-group3">
                        <label class="control-label">
                            <font dir="auto" style="vertical-align: inherit;">
                                <font dir="auto" style="vertical-align: inherit;">
                                    복리 후생
                                </font>
                            </font>
                        </label>
                        <textarea class="form-control" rows="7" name="com_content" disabled required>${resultReadVO.rec_benefit}</textarea>
                    </div> <br>
                    
                    <div class="form-group4">
                        <label class="control-label">
                            <font dir="auto" style="vertical-align: inherit;">
                                <font dir="auto" style="vertical-align: inherit;">
                                    회사 주요 업무 소개
                                </font>
                            </font>
                        </label>
                        <textarea class="form-control" rows="7" name="com_content" disabled required>${resultReadVO.rec_maintask}</textarea>
                    </div> <br>
                    <hr>
                    <div class="form-group-image">
                    	<label class="control-label">
                            <font dir="auto" style="vertical-align: inherit;">
                                <font dir="auto" style="vertical-align: inherit;">
                                    회사 전경 및 사내 전경
                                </font>
                            </font>
                        </label>
                   	    <div class="image-box">
					        <c:if test="${not empty resultReadVO.attachFileName}">
					            <c:forEach var="file" items="${fn:split(resultReadVO.attachFileName, ',')}">
					                <img src="/upload/recfile/${file}" 
					                     alt="회사 이미지"
					                     class="company-img"
					                     style="width: 100%; height: 300px;"> <br><br>
					            </c:forEach>
					        </c:if>
					
					        <c:if test="${empty resultReadVO.attachFileName}">
					            <p>등록된 추가 이미지가 없습니다.</p>
					        </c:if>
					    </div>
                    </div>
                    
                    <div class="col-12">
                        <div class="button">
                            <c:if test="${not empty recLoginInfo and recLoginInfo.corpUserId eq resultReadVO.corpUserId}">
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
	let recBno = null;
	$(document).ready(function(){
		
		const formObj = $("#readForm");
		
		// 수정 버튼
		$(".btn-update").click(function(){
			formObj.attr("action","/recboard/recUpdate");
			formObj.submit();
		});
		
		// 목록 버튼
		$(".btn-list").click(function(){
			location.href="/recboard/recListCri?page=${page}";
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