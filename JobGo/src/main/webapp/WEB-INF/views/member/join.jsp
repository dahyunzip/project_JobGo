<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/Header.jsp"%>
<script>
	$(document).ready(function() {
		var $form = $('.form-join');
		var $pwd = $('#pwd');
		var $pwdConfirm = $('#pwdConfirm');
		var $pwdError = $('#pwdError');

		function validatePassword() {
			var pwd = $pwd.val();
			var pwdConfirm = $pwdConfirm.val();
			var pwdError = [];

			// 최소 8자 이상
			if (pwd.length < 8) {
				pwdError.push('비밀번호는 최소 8자 이상이어야 합니다.');
			}

			// 영문 대소문자 포함
			if (!/[A-Za-z]/.test(pwd)) {
				pwdError.push('비밀번호에는 영문자가 최소 하나 포함되어야 합니다.');
			}

			// 숫자 포함
			if (!/[0-9]/.test(pwd)) {
				pwdError.push('비밀번호에는 숫자가 최소 하나 포함되어야 합니다.');
			}

			// 특수문자 포함
			if (!/[!@#$%^&*(),.?":{}|<>]/.test(pwd)) {
				pwdError.push('비밀번호에는 특수문자 하나 이상 포함되어야 합니다.');
			}

			// 비밀번호 확인과 일치 여부
			if (pwd !== pwdConfirm) {
				pwdError.push('비밀번호와 확인용 비밀번호가 일치하지 않습니다');
			}

			if (pwdError.length > 0) {
				$pwdError.html(pwdError.join('<br>')).show();
				return false;
			} else {
				$pwdError.hide();
				return true;
			}
		}//validatePassword

		// 체크박스 요소
		var $chkEssential = $('#agr_chbox');
		var $chkLocation = $('input[name="agreeLocation"]');
		var $chkEmail = $('input[name="agreeEmail"]');
		var $chkSms = $('input[name="agreeSms"]');

		// 이용 약관 검사
		function setAgreementValues() {
			// 개인정보 수집 및 이용 동의 약관
			if (!$chkEssential.is(':checked')) {
				alert('개인정보 수집 및 이용 동의는 필수입니다!');
				return false;
			}

			// 선택 항목들 값 설정
			// 체크되어 있으면 Y, 아니면 N
			$chkLocation.each(function() {
				$(this).val($(this).is(':checked') ? 'Y' : 'N');
			});
			$chkEmail.each(function() {
				$(this).val($(this).is(':checked') ? 'Y' : 'N');
			});
			$chkSms.each(function() {
				$(this).val($(this).is(':checked') ? 'Y' : 'N');
			});

			return true;
		}

		// 아이디 중복 검사
		var isUseridChecked = false;
		var idMsg = $('#useridCheckMsg');
		$('#checkID').click(function() {
			var useridRaw = $('#userid').val();
			var userid = useridRaw ? useridRaw.trim() : '';
			if (userid === '') {
				idMsg.text('아이디를 입력해주세요.');
				isUseridChecked = false;
				return;
			}

			$.ajax({
				type : "GET",
				url : '/member/idCheck',
				data : {
					userid : userid
				},
				dataType : 'json'
			}).done(function(res) {
				if (res.available) {
					idMsg.css('color', 'green').text('사용 가능한 아이디 입니다.');
					isUseridChecked = true;
				} else {
					idMsg.text('이미 사용중인 아이디 입니다.');
					isUseridChecked = false;
				}
			}).fail(function(err) {
				idMsg.text('아이디 중복검사 중 오류가 발생했습니다.');
				isUseridChecked = false;
			});
		});

		// 핸드폰 번호 유효성 검사
		var phone = $('#phone');
		var phoneError = $('#phoneError');
		function validatePhone() {
			var phoneVal = phone.val().trim();

			//숫자만 있는지 검사
			var regex = /^\d+$/;

			if (!regex.test(phoneVal)) {
				phoneError.text("'-' 없이 숫자만 입력해 주세요.").show();
				return false;
			}
			if (!(phoneVal.length === 11)) {
				phoneError.text("11자의 핸드폰 번호를 입력해주세요.").show();
				return false;
			}

			phoneError.hide();
			return true;
		}

		var isEmailVerified = false;
		var timerInterval;
		
		// 이메일 전송 버튼 이벤트
		$('#sendMail').click(function(){
			var email = $('input[name="email"]').val().trim();
			if(email === ''){
				alert('이메일을 입력해주세요.');
				return;
			}
			$.ajax({
				type : "POST",
				url : '/member/email/sendCode',
				data : {email:email},
				dataType : 'json'
			}).done(function(res){
				if(res.success){
					alert(res.message);
					$('#emailCodeSection').show();
					startTimer(5 * 60);
				}else{
					alert(res.message);
				}
			}).fail(function(){
				alert("인증메일 전송 중 오류가 발생했습니다. 관리자에게 문의하세요.");
			});
		});
		
		// 인증번호 확인 버튼 이벤트
		$('#verifyCode').click(function(){
			var email = $('input[name="email"]').val().trim();
			var code = $('#emailCode').val().trim();
			console.log(code);
			if(code === ''){
				$('#emailCodeMsg').text('인증번호를 입력해주세요.');
				return;
			}
			$.ajax({
				type : "POST",
				url : '/member/email/verifyCode',
				data : {email:email, code:code},
				dataType : 'json'
			}).done(function(res){
				if(res.success){
					$('#emailCodeMsg').css('color', 'green').text(res.message);
					isEmailVerified = true;
					stopTimer();
				}else{
					$('#emailCodeMsg').css('color', 'red').text(res.message);
					isEmailVerified = false;
				}
			}).fail(function(){
				$('#emailCodeMsg').text('인증 요청 중 오류가 발생했습니다.');
				isEmailVerified = false;
			});
		});
		
		
		// 타이머 시작 함수
		function startTimer(duration){
			var remaining = duration;
			clearInterval(timerInterval); // 이전 타이머 있으면 클리어
			timerInterval = setInterval(function(){
				var minutes = Math.floor(remaining / 60);
				var seconds = remaining % 60;
				$('#emailCodeMsg').text('남은 시간 : ' + minutes + '분 ' + (seconds < 10 ? '0' + seconds : seconds) + '초'); 
				// 시간 만료시
				if(remaining <= 0){
					clearInterval(timerInterval);
					$('#emailCodeMsg').text('유효시간이 만료되었습니다.');
					isEmailVerified = false;
				}
				remaining--;
			}, 1000);
		}
		
		// 타이머 중지 함수
		function stopTimer(){
			clearInterval(timerInterval);
		}
		
		// 실시간 검사
		$pwd.on('keyup change', validatePassword);
		$pwdConfirm.on('keyup change', validatePassword);
		// 아이디 입력창이 다시 변경되면 중복검사 리셋
		$('#userid').on('change keyup', function() {
			isUseridChecked = false;
			idMsg.text('');
		});
		$(phone).on('keyup change', validatePhone);

		$form.on('submit', function(e) {
			// 아이디 중복검사 확인
			if (!isUseridChecked) {
				e.preventDefault();
				alert('아이디 중복검사를 해주세요.');
				return;
			}

			// 비밀번호 검사
			if (!validatePassword()) {
				e.preventDefault(); // 제출 막기
				alert('비밀번호 입력 항목을 확인해주세요.');
				return;
			}

			// 핸드폰 번호 검사
			if (!validatePhone()) {
				e.preventDefault();
				alert("핸드폰 번호 입력을 확인해주세요.");
				return;
			}

			// 약관 동의 값 설정 및 필수 동의 검사
			if (!setAgreementValues()) {
				e.preventDefault();
				alert('약관 사항을 확인해주세요.');
				return;
			}
			
			if(!isEmailVerified){
				e.preventDefault();
				alert('이메일 인증을 완료해주세요.');
				return;
			}
		});
		
		var status = '${msg }';
		if(status == 'notVerified'){
			alert('이메일 인증을 먼저 완료해 주세요.');
		}else if(status == 'errorVerified'){
			alert('이메일 인증 상태 확인 중 오류가 발생했습니다. 다시 시도해 주세요.');
		}

	});
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
									이미 회원이신가요? <a href="/member/login" class="login"> 로그인 페이지로
										이동</a>
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
										<label class="control-label">이름<i class="essential">*</i></label> <input type="text"
											class="form-control" placeholder="이름을 입력하세요." name="name">
									</div>
								</div>
								<div class="col-lg-6 col-12 mb-20">
									<label class="control-label">아이디<i class="essential">*</i></label>
									<div class="row">
										<div class="form-group col-8">
											<input type="text" class="form-control"
												placeholder="아이디를 입력하세요." name="userid" id="userid">
										</div>
										<div class="col-4 button">
											<button type="button" id="checkID" class="btn">중복 검사</button>
										</div>
									</div>
									<div id="useridCheckMsg"></div>
								</div>
								<div class="col-lg-6 col-12 mb-20">
									<div class="form-group">
										<label class="control-label">비밀번호<i class="essential">*</i></label> <input
											type="password" class="form-control"
											placeholder="비밀번호를 입력하세요." name="userpw" id="pwd" required>
									</div>
								</div>
								<div class="col-lg-6 col-12 mb-20">
									<div class="form-group">
										<label class="control-label">비밀번호 확인<i class="essential">*</i></label> <input
											type="password" class="form-control"
											placeholder="비밀번호를 입력하세요." name="userpwConfirm"
											id="pwdConfirm" required>
									</div>
								</div>
								<div id="pwdError" class="col-lg-12 col-12 mb-10"></div>
								<div class="col-lg-6 col-12 mb-20">
									<label class="control-label">E-mail<i class="essential">*</i></label>
									<div class="row">
										<div class="form-group col-8">
											<input type="email" class="form-control"
												placeholder="이메일을 입력하세요." required name="email">
										</div>
										<div class="col-4 button">
											<button type="button" id="sendMail" class="btn">인증메일 전송</button>
										</div>
									</div>
									<div class="col-12 mt-10" id="emailCodeSection" style="display: none;">
										<label class="control-label">인증번호 입력</label>
										<div class="row">
											<div class="form-group col-8">
												<input type="text" class="form-control"
													placeholder="인증번호 입력" id="emailCode" />
											</div>
											<div class="col-4 button">
												<button type="button" id="verifyCode" class="btn">인증확인</button>
											</div>
										</div>
										<div id="emailCodeMsg"></div>
									</div>
								</div>
								<div class="col-lg-6 col-12 mb-20">
									<div class="form-group">
										<label class="control-label">핸드폰 번호<i class="essential">*</i></label> <input type="text"
											class="form-control" placeholder="'-' 빼고 작성하세요." name="phone"
											id="phone" required>
										<div id="phoneError"></div>
									</div>
								</div>
								<div class="col-lg-12 col-12 mb-20">
									<div class="form-group">
										<label class="control-label">주소</label> <input type="text"
											class="form-control" placeholder="주소를 입력하세요." name="addr">
									</div>
								</div>
								<div class="col-lg-12 col-12">
									<div class="form-group mb-20">
										개인정보 수집 및 이용 동의(필수) *
										<div class="agree-box">
											회사는 회원가입 및 서비스 제공을 위해 아래와 같이 개인정보를 수집하고 이용합니다.<br>
											<br> 수집 항목<br> • 필수: 이름, 아이디, 비밀번호, 이메일, 휴대전화번호<br>
											• 자동 수집 정보: 접속 IP, 쿠키, 서비스 이용 기록, 기기 정보<br>
											<br> 수집 목적<br> • 회원 가입 및 본인 확인<br> • 서비스 제공 및
											이용자 관리<br> • 고객 문의 응대 및 공지사항 안내<br> • 서비스 품질 개선 및
											보안 강화<br>
											<br> 보유 및 이용 기간<br> • 회원 탈퇴 시까지 또는 관련 법령에 따라 보존 의무가
											있는 경우 해당 기간 동안 보관<br> (예: 소비자 보호 관련 법령에 따라 최대 5년 보관)<br>
											<br> 동의 거부 권리 및 안내<br> • 개인정보 제공을 거부할 수 있으나, 이 경우
											서비스 이용에 제한이 있을 수 있음<br>
											<br> 위 필수 항목 수집 및 이용에 동의해야 서비스 이용이 가능합니다.
										</div>
										<label class="control-label"><input type="checkbox"
											class="form-check-input" id="agr_chbox" name="agreeEssential">
											약관에 동의합니다.</label>
									</div>
									<div class="form-group mb-20">
										위치기반서비스 이용약관 동의 (선택)
										<div class="agree-box">
											회사는 위치기반서비스 제공 시 아래 내용을 안내합니다.<br>
											<br> 수집 항목 및 방법<br> • GPS, Wi-Fi, 기지국 기반 위치정보<br>
											• 모바일 기기 설정 또는 서비스 이용 과정에서 자동 수집<br>
											<br> 이용 목적<br> • 위치 기반 추천 서비스 제공<br> • 지역 맞춤
											정보 및 혜택 제공<br> • 서비스 품질 분석 및 최적화<br>
											<br> 보유 및 이용 기간<br> • 서비스 이용 목적 달성 시 파기<br> •
											법령 보존 의무가 있는 경우 해당 기간 보관<br>
											<br> 동의 거부 권리 및 안내<br> • 동의하지 않아도 서비스 기본 기능 이용 가능<br>
											• 단, 위치 기반 혜택 및 추천 서비스 제공이 제한됨
										</div>
										<label class="control-label">
										<input type="hidden" name="agreeLocation" value="N">
										<input type="checkbox" class="form-check-input" name="agreeLocation" value="Y">
											약관에 동의합니다.</label>
									</div>
									<div class="form-group mb-20">
										마케팅 정보 수신 동의 – 이메일 (선택)
										<div class="agree-box">
											이용 목적<br> • 맞춤형 이벤트, 프로모션 정보 제공<br> • 신규 서비스 안내 및
											고객 혜택 제공<br>
											<br> 보유 및 이용 기간<br> • 동의 철회 또는 회원 탈퇴 시까지<br>
											<br> 수신 거부 안내<br> • 이메일 내 하단의 수신 거부 링크 또는 서비스 내 알림
											설정에서 변경 가능
										</div>
										<label class="control-label">
										<input type="hidden" name="agreeEmail" value="N">
										<input type="checkbox" class="form-check-input" name="agreeEmail" value="Y">
											약관에 동의합니다.</label>
									</div>
									<div class="form-group mb-20">
										마케팅 정보 수신 동의 – SMS/MMS (선택)
										<div class="agree-box">
											이용 목적<br> • 문자 메시지를 통한 이벤트 및 혜택 안내<br> • 맞춤 알림 서비스
											제공<br>
											<br> 보유 및 이용 기간<br> • 동의 철회 또는 회원 탈퇴 시까지<br>
											<br> 수신 거부 안내<br> • 고객센터를 통한 철회 또는 서비스 내 설정에서 변경 가능
										</div>
										<label class="control-label">
										<input type="hidden" name="agreeSms" value="N">
										<input type="checkbox" class="form-check-input" name="agreeSms" value="Y">
											약관에 동의합니다.</label>
									</div>
									<div class="form-group mb-8 button text-center">
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