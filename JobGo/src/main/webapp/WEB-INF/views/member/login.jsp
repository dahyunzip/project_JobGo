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
	}
})
</script>
<div id="sub-contents">
	<section class="section">
		<div class="container">
			<div class="row">
				<div class="col-12">
					<div class="add-resume-inner box">
						<div class="post-header align-items-center justify-content-center">
							<div class="section-title">
								<h2>로그인</h2>
								<p>
									회원이 아니신가요? <a href="/member/join" class="login"> 회원가입 페이지로 이동</a>
								</p>
							</div>
						</div>
						<form class="form-ad" method="post">
							<div class="row">
								<div class="col-lg-6 col-12">
									<div class="form-group">
										<label class="control-label">아이디</label>
										<input type="text" class="form-control" placeholder="이메일을 입력하세요." name="userid" required>
									</div>
								</div>
								<div class="col-lg-6 col-12">
									<div class="form-group">
										<label class="control-label">비밀번호</label>
										<input type="password" class="form-control" placeholder="비밀번호를 입력하세요." name="userpw" required>
									</div>
								</div>
								<div class="col-lg-12">
									<a href="#">아이디 찾기</a>
									<a href="#">| 비밀번호 찾기</a>
								</div>
								<div class="form-group mb-8 button">
									<button type="submit" class="btn ">로그인</button>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</section>
</div>
<%@ include file="../include/Footer.jsp"%>