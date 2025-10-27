<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/Header.jsp"%>
<div id="sub-contents">
	<section class="pricing-table section">
		<div class="container">
			<div class="row">
				<div class="col-12">
					<div class="section-title">
						<h2 class="wow fadeInUp" data-wow-delay=".4s" style="visibility: visible; animation-delay: 0.4s; animation-name: fadeInUp;">
							회원가입
						</h2>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="row no-gutters">
                    <div class="col-12">
                        <div class="row">
                            <form method="post">
                                <div class="form-group">
                                    <label for="name" class="label">이름</label>
                                    <input type="text" class="form-control" placeholder="이름" name="name" id="ip_name">
                                </div>
                                <div class="form-group">
                                    <label for="userid" class="label">아이디</label>
                                    <input type="text" class="form-control" placeholder="아이디를 입력하세요." name="userid" id="ip_id">
                                </div>
                                <div class="form-group">
                                    <label for="password" class="label">비밀번호</label>
                                    <div class="position-relative">
                                        <input type="password" class="form-control" placeholder="비밀번호를 입력하세요" name="userpw" id="ip_pw">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="email" class="label">이메일</label>
                                    <input type="email" class="form-control" placeholder="이메일을 입력하세요." name="email" required id="ip_em">
                                </div>
                                <div class="form-group">
                                    <label for="phone" class="label">연락처</label>
                                    <div class="position-relative">
                                        <input type="text" class="form-control" placeholder="연락처를 입력하세요." name="phone" id="ip_ph">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="text" class="label">주소</label>
                                    <input type="text" class="form-control" placeholder="주소를 입력하세요." name="addr" required id="ip_ad">
                                </div>
                                <div class="form-group">
                                	<div class="form-box">
                                		<h5>이용약관 동의</h5>
                                		<div class="agree-cont">
                                			<p>저는 이거이거에 동의하고.민아ㅣ;ㅁㄴ어;ㄴ미ㅓㅇㄴㅁ;ㅣ어니ㅏㅁ어니ㅏ어ㅣ너인어니어니어니ㅓㅇ닝</p>
                                		</div>
                                	</div>
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" value="" id="ip_ch01">
                                        <label class="form-check-label" for="ip_ch01">이용약관에 동의합니다.</label>
                                    </div>
                                </div>
                                <div class="form-group mb-8 button">
                                    <button type="submit" class="btn ">회원가입</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
			</div>
		</div>
	</section>
</div>
<%@ include file="../include/Footer.jsp"%>