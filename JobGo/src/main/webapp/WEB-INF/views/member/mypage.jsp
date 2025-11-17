<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/Header.jsp"%>
<script>
	$(document).ready(function(){
		if('${msg }' == 'modifySuccess'){
			alert('정보 수정 완료!');
		}
	})
</script>

<div class="job-details section" id="mypage">
	<h2 class="pageTitle">마이페이지</h2>
	<div class="container">
	    <div class="row mb-n5">
	        <!-- Job List Details Start -->
	        <div class="col-lg-12 col-12">
	            <div class="job-details-inner">
	                <div class="mb-10 text-center">
	                    <div class="user-img">
	                    	<c:set var="imageName" value="${empty user.storedFileName ? 'default_image.jpg' : user.storedFileName }" />
	                        <img src="/upload/${imageName }"  alt="기본 프로필 사진" onerror="this.onerror=null; this.src='/resources/images/default_image.jpg'">
	                    </div>
	                    <div class="content">
	                        <h5 class="title">${user.name }님 안녕하세요.</h5>
	                        <%-- ${user } --%>
	                    </div>
	                    <hr>
	                </div>
	                <div class="job-details-body">
	                    <h6 class="mb-3 mt-4">내 정보 확인</h6>
	                    <ul>
	                        <li><strong>아이디 </strong>${user.userid }</li>
	                        <li><i class="lni lni-map-marker"></i><strong>이메일 </strong>${user.email }</li>
	                        <li><strong>핸드폰 </strong>${user.phone }</li>
	                        <li><strong>주소 </strong>${user.addr }</li>
	                        <li><strong>회원가입일 </strong>${user.joinedAt }</li>
	                        <li><strong>최근 정보수정일 </strong>${user.updateAt }</li>
	                        <li><strong>위치 제공 동의 </strong>${user.agreeLocation }</li>
	                        <li><strong>이메일 수신 동의 </strong>${user.agreeEmail }</li>
	                        <li><strong>SMS 수신 동의 </strong>${user.agreeSms }</li>
	                    </ul>
	                    <div class="button text-right mt-20">
	                    	<a href="/member/modify" class="btn">정보 수정하기</a>
	                    </div>
	                </div>
	                <a href="/member/delete" class="dropBtn">회원 탈퇴하기</a>
	            </div>
	        </div>
	        <!-- Job List Details End -->
	       
	        </div>
	    </div>
	</div>
<%@ include file="../include/Footer.jsp"%>