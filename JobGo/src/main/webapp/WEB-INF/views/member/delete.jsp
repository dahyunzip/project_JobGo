<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../include/Header.jsp"%>
<script>
	$(function(){
		var status = '${msg }';
		if(status == 'dropFail'){
			alert('형식에 맞게 입력해주세요.');
		}
		
		
		$("form").on("submit", function(e){
			var check = $("#agreeCheck").is(":checked");
			var text = $.trim($("#confirmText").val());
			
			if(!check){
				alert("약관에 동의해야 탈퇴가 가능합니다.");
				e.preventDefault(); // 폼 제출 막기
				return false;
			}
			
			if(text != "탈퇴하겠습니다."){
				alert("탈퇴 동의 문구를 정확히 입력해주세요.");
				e.preventDefault();
				return false();
			}
			
			// 모든 조건 통과시 폼 제출 허용
			return true;
		})
	});
</script>
<section class="add-resume section">
	<c:if test="${empty sessionScope.userid }">
		<c:redirect url="/member/login"/>
	</c:if>
	<div class="container">
	    <div class="row">
	        <div class="col-lg-12 col-12">
	            <div class="add-resume-inner box">
	                <div class="post-header align-items-center justify-content-center">
	                    <h3>회원 탈퇴</h3>
	                </div>
	                <form class="form-ad" method="post">
	                	<input type="hidden" name="userid" value="${user.userid }">
	                	<input type="hidden" name="userpw" value="${user.userpw}">
	                    <div class="row text-center">
	                    	<h5 class="mb-20">${user.name }님, 정말 탈퇴하시겠어요?</h5>
	                    	<p class="mb-20">탈퇴를 원하신다면, 약관 동의 후 '<strong style="color:red">탈퇴하겠습니다.</strong>' 를 입력해주세요.</p>
	                    	<div class="form-group">
	                    		<div class="agree-box mb-10">
	                        		JobGo는 회원정보를 2년간 수집하고 자동 파기합니다. 
	                        	</div>
	                        	<label for="agreeCheck">
	                        		<input type="checkbox" name="agreeCheck" id="agreeCheck"> 약관에 동의합니다.
	                        	</label>
	                    	</div>
	                    	<div class="form-group">
	                    		<input type="text" placeholder="입력해주세요." class="text-center form-control" id="confirmText" name="confirmText">
	                    	</div>
	                        
	                    </div>
                        <div class="row">
                            <div class="col-lg-12 col-12 text-center">
                                <div class="button">
                                    <button type="submit" class="btn">탈퇴하기</button>
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