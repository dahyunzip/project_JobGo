<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/Header.jsp"%>
<script>
$(document).ready(function(){
	var status = '${msg }';
	if(status == 'loginSuccess'){
		alert('로그인 성공!');
	}else if(status == 'loginFail'){
		alert('잘못된 ID 또는 비밀번호 입니다.');
	}else if(status == 'joinSuccess'){
		alert('회원가입 완료! 환영합니다.');
	}else if(status == 'resetPwSuccess'){
		alert('비밀번호가 변경되었습니다. 변경된 비밀번호로 로그인해주세요.');
	}else if(status == 'loginRequired'){
		alert('로그인 후 이용 가능한 서비스입니다.');
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
						<a href="javascript:;" class="active">일반회원</a>
						<a href="/corp/login" class="">기업회원</a>
					</div>
					<form class="form-ad" method="post">
						<%-- <input type="hidden" name="oldPath" value="${param.oldPath}"> --%>
						
						<div class="row">
							<div class="col-lg-12 col-12 mb-10">
								<div class="form-group">
									<label class="control-label">아이디</label>
									<input type="text" class="form-control" placeholder="아이디를 입력하세요." name="userid" required>
								</div>
							</div>
							<div class="col-lg-12 col-12 mb-10">
								<div class="form-group">
									<label class="control-label">비밀번호</label>
									<input type="password" class="form-control" placeholder="비밀번호를 입력하세요." name="userpw" required>
								</div>
							</div>
							<div class="col-lg-12 mb-20">
								<a href="/member/findId">아이디 찾기</a>
								<a href="/member/findPw">| 비밀번호 찾기</a>
								<a href="/member/join">회원가입</a>
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