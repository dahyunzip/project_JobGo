<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/Header.jsp"%>
<script>
$(document).ready(function(){
	var status = '${msg }';
	if(status == 'joinSuccess'){
		alert('회원가입 성공! 기업회원은 관리자 승인 후 이용 가능합니다.');
	}else if(status == 'notAllowed'){
		alert('승인되지 않은 기업회원입니다. 관리자에게 문의해 주세요. 문의번호 : 1599-0024');
	}else if(status == 'loginFail'){
		alert('아이디 또는 비밀번호가 올바르지 않거나 탈퇴된 회원입니다.');
	}else if(status == 'deleteSuccess'){
		alert('회원 탈퇴가 완료되었습니다.');
	}else if(status == 'notLoggedIn'){
		alert('로그인이 필요한 서비스입니다.');
	}else if(status == 'resetPwSuccess'){
		alert('비밀번호가 변경되었습니다. 변경된 비밀번호로 로그인해주세요.');
	}
})
</script>
<div id="sub-contents">
	<section class="section" id="login">
		<div class="container">
			<div class="row">
				<div class="loginBox">
					<div class="post-header align-items-center justify-content-center">
						<div class="section-title">
							<h2>로그인</h2>
							<p>
								회원이 아니신가요? <a href="/member/join" class="login"> 회원가입 페이지로 이동</a>
							</p>
						</div>
					</div>
					<div class="memberDiv">
						<a href="/member/login" >일반회원</a>
						<a href="javascript:;" class="active">기업회원</a>
					</div>
					<form class="form-ad" method="post">
						<div class="row">
							<div class="col-lg-12 col-12 mb-10">
								<div class="form-group">
									<label class="control-label">아이디</label>
									<input type="text" class="form-control" placeholder="아이디를 입력하세요." name="corpUserId">
								</div>
							</div>
							<div class="col-lg-12 col-12 mb-10">
								<div class="form-group">
									<label class="control-label">비밀번호</label>
									<input type="password" class="form-control" placeholder="비밀번호를 입력하세요." name="corpUserPw">
								</div>
							</div>
							<div class="col-lg-12 mb-20 loginSmBtn">
								<div>
									<a href="/corp/findId">아이디 찾기</a>
									<a href="/corp/findPw">| 비밀번호 찾기</a>
								</div>
								<a href="/corp/join">회원가입</a>
							</div>
							<div class="form-group mb-8 button">
								<button type="submit" class="btn ">로그인</button>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</section>
</div>
<%@ include file="../include/Footer.jsp"%>