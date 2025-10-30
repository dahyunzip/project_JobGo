<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/Header.jsp"%>
<section class="add-resume section">
	<div class="container">
	    <div class="row">
	    	<div class="col-lg-4 col-12">
                <div class="dashbord-sidebar">
                    <ul>
                        <li class="heading">마이페이지</li>
                        <li><a class="" href="/member/mypage"><i class="lni lni-clipboard"></i> 내 정보 확인</a></li>
                        <li><a class="active" href="/member/modify"><i class="lni lni-clipboard"></i> 내 정보 수정</a></li>
                    </ul>
                </div>
            </div>
	        <div class="col-lg-8 col-12">
	            <div class="add-resume-inner box">
	                <div class="post-header align-items-center justify-content-center">
	                    <h3>내 정보 수정</h3>
	                </div>
	                <form class="form-ad">
	                    <div class="row">
	                        <div class="col-lg-6 col-12">
	                            <div class="form-group">
	                                <label class="control-label">이름</label>
	                                <input type="text" class="form-control" name="name" value="${user.name }" readonly>
	                            </div>
	                        </div>
	                        <div class="col-lg-6 col-12">
	                            <div class="form-group">
	                                <label class="control-label">이메일</label>
	                                <input type="text" class="form-control" name="email" value=${user.email } readonly>
	                            </div>
	                        </div>
	                        <div class="col-lg-12 col-12">
	                            <div class="form-group">
	                                <label class="control-label">주소</label>
	                                <input type="text" class="form-control" name="addr" value=${user.addr }>
	                            </div>
	                        </div>
	                        <div class="col-lg-6 col-12">
	                            <div class="form-group">
	                                <label class="control-label">대표이미지</label>
	                                <input type="file" class="form-control" name="pfImage" value="${user.pfImage }">
	                            </div>
	                        </div>
	                        <div class="col-lg-6 col-12">
	                            <div class="form-group">
	                                <label class="control-label">마케팅 수신 동의</label>
	                                <input type="checkbox" class="" name="" value="">
	                            </div>
	                        </div>
	                        <div class="col-lg-6 col-12">
	                            <div class="form-group">
	                                <label class="control-label">어쩌구 수신 동의</label>
	                                <input type="checkbox" class="" name="" value="">
	                            </div>
	                        </div>
	                        <div class="col-lg-6 col-12">
	                            <div class="form-group">
	                                <label class="control-label">어쩌구 수신 동의</label>
	                                <input type="checkbox" class="" name="" value="">
	                            </div>
	                        </div>
	                    </div>
                        <div class="row">
                            <div class="col-lg-12 col-12 text-center">
                                <div class="button">
                                    <button type="submit" class="btn">수정하기</button>
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