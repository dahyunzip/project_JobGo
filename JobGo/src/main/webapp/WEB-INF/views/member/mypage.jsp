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
	<div class="container">
	    <div class="row mb-n5">
	    	 <!-- Job Sidebar Wrap Start -->
	        <div class="col-lg-4 col-12">
                <div class="dashbord-sidebar">
                    <ul>
                        <li class="heading">마이페이지</li>
                        <li><a class="active" href="/member/mypage"><i class="lni lni-clipboard"></i> 내 정보 확인</a></li>
                        <li><a href="/member/modify"><i class="lni lni-clipboard"></i> 내 정보 수정</a></li>
                    </ul>
                </div>
            </div>
	        <!-- Job Sidebar Wrap End -->
	        <!-- Job List Details Start -->
	        <div class="col-lg-8 col-12">
	            <div class="job-details-inner">
	                <div class="job-details-head row mx-0">
	                    <div class="user-img col-auto">
	                        <a href="#" style="border-radius: 4px; overflow: hidden;"><img src="/resources/images/sub/defaultProfile.jpg" alt="기본 프로필 사진"></a>
	                    </div>
	                    <div class="content col">
	                        <h5 class="title">${user.name }님 안녕하세요.</h5>
	                    </div>
	                </div>
	                <div class="job-details-body">
	                    <h6 class="mb-3 mt-4">내 정보 확인</h6>
	                    <ul>
	                        <li><strong>아이디 </strong>${user.userid }</li>
	                        <li><i class="lni lni-map-marker"></i><strong>이메일 </strong>${user.email }</li>
	                        <li><strong>핸드폰 </strong>${user.phone }</li>
	                        <li><strong>주소 </strong>${user.addr }</li>
	                        <li><strong>회원가입일 </strong>${user.joinedAt }</li>
	                        <li><strong>최근 정보수정일</strong>${user.updateAt }</li>
	                    </ul>
	                    <div class="button text-right mt-20">
	                    	<a href="/member/modify" class="btn">정보 수정하기</a>
	                    </div>
	                </div>
	                <a href="#" class="dropBtn">회원 탈퇴하기</a>
	            </div>
	        </div>
	        <!-- Job List Details End -->
	       
	        </div>
	    </div>
	</div>
<%@ include file="../include/Footer.jsp"%>