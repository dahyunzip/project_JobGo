<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/Header.jsp"%>
<script>
</script>
<div id="sub-contents">
	<section class="section">
		<div class="container">
			<div class="row">
				<div class="col-12">
					<div class="add-resume-inner box">
						<div class="post-header align-items-center justify-content-center">
							<div class="section-title">
								<h2>일반회원 회원가입</h2>
								<p>
									이미 회원이신가요? <a href="/member/login" class="login"> 로그인 페이지로 이동</a>
								</p>
							</div>
						</div>
						<div id="tab-li">
							<ul>
								<li class="on"><a href="/member/join">일반회원</a></li>
								<li><a href="/corp/join">기업회원</a></li>
							</ul>
						</div>
						<form class="form-join" method="post">
							<div class="row">
								<div class="col-lg-6 col-12 mb-20">
									<div class="form-group">
										<label class="control-label">이름</label>
										<input type="text" class="form-control" placeholder="이름을 입력하세요." name="name">
									</div>
								</div>
								<div class="col-lg-6 col-12 mb-20">
									<div class="form-group">
										<label class="control-label">아이디</label>
										<input type="text" class="form-control" placeholder="아이디를 입력하세요." name="userid">
									</div>
								</div>
								<div class="col-lg-6 col-12 mb-20">
									<div class="form-group">
										<label class="control-label">비밀번호</label>
										<input type="password" class="form-control" placeholder="비밀번호를 입력하세요." name="userpw">
									</div>
								</div>
								<div class="col-lg-6 col-12 mb-20">
									<div class="form-group">
										<label class="control-label">비밀번호 확인</label>
										<input type="password" class="form-control" placeholder="비밀번호를 입력하세요." name="userpw">
									</div>
								</div>
								<div class="col-lg-6 col-12 mb-20">
									<div class="form-group">
										<label class="control-label">E-mail</label>
										<input type="email" class="form-control" placeholder="이메일을 입력하세요." required name="email">
									</div>
								</div>
								<div class="col-lg-6 col-12 mb-20">
									<div class="form-group">
										<label class="control-label">핸드폰 번호</label>
										<input type="text" class="form-control" placeholder="'-' 빼고 작성하세요." name="phone">
									</div>
								</div>
								<div class="col-lg-12 col-12 mb-20">
									<div class="form-group">
										<label class="control-label">주소</label>
										<input type="text" class="form-control" placeholder="주소를 입력하세요." name="addr">
									</div>
								</div>
								<div class="col-lg-12 col-12">
									<div class="form-group mb-20">
										개인정보 수집 및 이용 동의(필수) *
										<div class="agree-box">
											회사는 회원가입 및 서비스 제공을 위해 아래와 같이 개인정보를 수집하고 이용합니다.<br><br>

											수집 항목<br>
											• 필수: 이름, 아이디, 비밀번호, 이메일, 휴대전화번호<br>
											• 자동 수집 정보: 접속 IP, 쿠키, 서비스 이용 기록, 기기 정보<br><br>
											
											수집 목적<br>
											• 회원 가입 및 본인 확인<br>
											• 서비스 제공 및 이용자 관리<br>
											• 고객 문의 응대 및 공지사항 안내<br>
											• 서비스 품질 개선 및 보안 강화<br><br>
											
											보유 및 이용 기간<br>
											• 회원 탈퇴 시까지 또는 관련 법령에 따라 보존 의무가 있는 경우 해당 기간 동안 보관<br>
											(예: 소비자 보호 관련 법령에 따라 최대 5년 보관)<br><br>
											
											동의 거부 권리 및 안내<br>
											• 개인정보 제공을 거부할 수 있으나, 이 경우 서비스 이용에 제한이 있을 수 있음<br><br>
											
											위 필수 항목 수집 및 이용에 동의해야 서비스 이용이 가능합니다.
										</div>
										<label class="control-label"><input type="checkbox" class="form-check-input" id="agr_chbox" name="agree_essential"> 약관에 동의합니다.</label>
									</div>
									<div class="form-group mb-20">
										위치기반서비스 이용약관 동의 (선택)
										<div class="agree-box">
											회사는 위치기반서비스 제공 시 아래 내용을 안내합니다.<br><br>

											수집 항목 및 방법<br>
											• GPS, Wi-Fi, 기지국 기반 위치정보<br>
											• 모바일 기기 설정 또는 서비스 이용 과정에서 자동 수집<br><br>
											
											이용 목적<br>
											• 위치 기반 추천 서비스 제공<br>
											• 지역 맞춤 정보 및 혜택 제공<br>
											• 서비스 품질 분석 및 최적화<br><br>
											
											보유 및 이용 기간<br>
											• 서비스 이용 목적 달성 시 파기<br>
											• 법령 보존 의무가 있는 경우 해당 기간 보관<br><br>
											
											동의 거부 권리 및 안내<br>
											• 동의하지 않아도 서비스 기본 기능 이용 가능<br>
											• 단, 위치 기반 혜택 및 추천 서비스 제공이 제한됨
										</div>
										<label class="control-label"><input type="checkbox" class="form-check-input" name="agree_location" value="Y"> 약관에 동의합니다.</label>
									</div>
									<div class="form-group mb-20">
										마케팅 정보 수신 동의 – 이메일 (선택)
										<div class="agree-box">
											이용 목적<br>
											• 맞춤형 이벤트, 프로모션 정보 제공<br>
											• 신규 서비스 안내 및 고객 혜택 제공<br><br>
											
											보유 및 이용 기간<br>
											• 동의 철회 또는 회원 탈퇴 시까지<br><br>
											
											수신 거부 안내<br>
											• 이메일 내 하단의 수신 거부 링크 또는 서비스 내 알림 설정에서 변경 가능
										</div>
										<label class="control-label"><input type="checkbox" class="form-check-input" name="agree_email" value="Y"> 약관에 동의합니다.</label>
									</div>
									<div class="form-group mb-20">
										마케팅 정보 수신 동의 – SMS/MMS (선택)
										<div class="agree-box">
											이용 목적<br>
											• 문자 메시지를 통한 이벤트 및 혜택 안내<br>
											• 맞춤 알림 서비스 제공<br><br>
											
											보유 및 이용 기간<br>
											• 동의 철회 또는 회원 탈퇴 시까지<br><br>
											
											수신 거부 안내<br>
											• 고객센터를 통한 철회 또는 서비스 내 설정에서 변경 가능
										</div>
										<label class="control-label"><input type="checkbox" class="form-check-input" name="agree_sms" value="Y"> 약관에 동의합니다.</label>
									</div>
									<div class="form-group mb-8 button">
										<button type="submit" class="btn ">회원가입</button>
									</div>
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