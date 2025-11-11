<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 재설정 | JobGo</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" />
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
body {
	background: #f8f9fa;
	font-family: 'Noto Sans KR';
}

.container {
	max-width: 420px;
	margin-top: 100px;
	background: white;
	padding: 40px;
	border-radius: 10px;
	box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
}

.btn {
	width: 100%;
	margin-top: 15px;
}

#pwdError {
	color: red;
	margin-top: 10px;
}
</style>
</head>
<body>
	<div class="container">
		<c:choose>
			<c:when test="${userType eq 'general'}">
				<h3 class="text-center mb-4">일반회원 비밀번호 재설정</h3>
				<form id="resetForm"
					action="${pageContext.request.contextPath}/member/resetPw"
					method="post">
					<input type="hidden" name="email" value="${email}"> <input
						type="hidden" name="token" value="${token}">

					<div class="form-group mb-3">
						<label>새 비밀번호</label> <input type="password" class="form-control"
							id="newPw" name="newPw" placeholder="새 비밀번호 입력 (8자 이상)" required>
					</div>

					<div class="form-group mb-3">
						<label>비밀번호 확인</label> <input type="password" class="form-control"
							id="confirmPw" name="confirmPw" placeholder="비밀번호 다시 입력" required>
					</div>

					<div id="pwdError"></div>

					<button type="submit" class="btn btn-primary mt-3">비밀번호 변경</button>

					<div class="text-center mt-3">
						<a href="/member/login">로그인으로
							돌아가기</a>
					</div>
				</form>
			</c:when>

			<c:when test="${userType eq 'corp'}">
				<h3 class="text-center mb-4">기업회원 비밀번호 재설정</h3>
				<form id="resetForm" action="/corp/resetPw" method="post">
					<input type="hidden" name="managerEmail" value="${managerEmail}"> <input
						type="hidden" name="token" value="${token}">

					<div class="form-group mb-3">
						<label>새 비밀번호</label> <input type="password" class="form-control"
							id="newPw" name="newPw" placeholder="새 비밀번호 입력 (8자 이상)" required>
					</div>

					<div class="form-group mb-3">
						<label>비밀번호 확인</label> <input type="password" class="form-control"
							id="confirmPw" name="confirmPw" placeholder="비밀번호 다시 입력" required>
					</div>

					<div id="pwdError"></div>

					<button type="submit" class="btn btn-primary mt-3">비밀번호 변경</button>

					<div class="text-center mt-3">
						<a href="/corp/login">로그인으로
							돌아가기</a>
					</div>
				</form>
			</c:when>
		</c:choose>
		<%-- <h3 class="text-center mb-4">새 비밀번호 설정</h3>
		<form id="resetForm"
			action="${pageContext.request.contextPath}/member/resetPw"
			method="post">
			<input type="hidden" name="email" value="${email}"> <input
				type="hidden" name="token" value="${token}">

			<div class="form-group mb-3">
				<label>새 비밀번호</label> <input type="password" class="form-control"
					id="newPw" name="newPw" placeholder="새 비밀번호 입력 (8자 이상)" required>
			</div>

			<div class="form-group mb-3">
				<label>비밀번호 확인</label> <input type="password" class="form-control"
					id="confirmPw" name="confirmPw" placeholder="비밀번호 다시 입력" required>
			</div>

			<div id="pwdError"></div>

			<button type="submit" class="btn btn-primary mt-3">비밀번호 변경</button>
		</form> --%>
	</div>
	<script>
		$(document).ready(function() {
			const $form = $('#resetForm');
			const $newPw = $('#newPw');
			const $confirmPw = $('#confirmPw');
			const $pwdError = $('#pwdError');

			function validatePassword() {
				const pwd = $newPw.val();
				const pwdConfirm = $confirmPw.val();
				let pwdError = [];

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

				// 비밀번호 확인 일치 여부
				if (pwd !== pwdConfirm) {
					pwdError.push('비밀번호와 확인 비밀번호가 일치하지 않습니다.');
				}

				// 출력
				if (pwdError.length > 0) {
					$pwdError.html(pwdError.join('<br>')).show();
					return false;
				} else {
					$pwdError.hide();
					return true;
				}
			}

			// 실시간 유효성 검사
			$newPw.on('keyup change', validatePassword);
			$confirmPw.on('keyup change', validatePassword);

			// 폼 제출 시 최종 검사
			$form.on('submit', function(e) {
				if (!validatePassword()) {
					e.preventDefault();
					alert('비밀번호 조건을 다시 확인해주세요.');
				}
			});
		});
	</script>

</body>
</html>