<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../include/Header.jsp"%>
<section class="job-details section">
	<h2 class="pageTitle">내 정보 수정</h2>
	<div class="container">
	    <div class="row">
	        <div class="col-lg-12 col-12">
	            <div class="job-details-inner box">
	                <form class="form-ad" method="post" enctype="multipart/form-data">
	                	<!-- hidden -->
	                	<input type="hidden" name="corpId" value="${corpuser.corpId}">
	                	<input type="hidden" name="corpUserId" value="${corpuser.corpUserId}">
	                	<input type="hidden" name="corpUserPw" value="${corpuser.corpUserPw}">
	                    <div class="col-lg-12 col-12">
                            <div class="form-group">
                            	<div>
                                    <img src="/upload/${corpLogo}" height="100" class="mb-2" alt="기업 로고 미리보기">
                                </div>
                                <c:set var="corpLogo" value="${empty corpuser.corpProfileStored ? 'default_image.jpg' : corpuser.corpProfileStored}" />
                                <input type="file" class="form-control" name="corpProfileUpload" accept="image/*">
                            </div>
                        </div>
	                    <div class="row">
	                        <div class="col-lg-6 col-12">
	                            <div class="form-group">
	                                <label class="control-label">담당자 이름</label>
	                                <input type="text" class="form-control" name="managerName" value="${corpuser.managerName}" readonly>
	                            </div>
	                        </div>

	                        <div class="col-lg-6 col-12">
	                            <div class="form-group">
	                                <label class="control-label">담당자 이메일</label>
	                                <input type="text" class="form-control" name="managerEmail" value="${corpuser.managerEmail}" readonly>
	                            </div>
	                        </div>

	                        <div class="col-lg-12 col-12">
	                            <div class="form-group">
	                                <label class="control-label">회사 주소</label>
	                                <input type="text" class="form-control" name="companyAddress" value="${corpuser.companyAddress}">
	                            </div>
	                        </div>

	                        <%-- <div class="col-lg-6 col-12">
	                            <div class="form-group">
	                                <label class="control-label">대표 이미지 (기업 로고)</label>
	                                <c:set var="corpLogo" value="${empty corpuser.corpProfileStored ? 'default.jpg' : corpuser.corpProfileStored}" />
	                                <div>
	                                    <img src="/upload/${corpLogo}" height="100" class="mb-2" alt="기업 로고 미리보기">
	                                </div>
	                                <input type="file" class="form-control" name="corpProfileUpload" accept="image/*">
	                            </div>
	                        </div> --%>

	                        <div class="col-lg-6 col-12">
	                            <div class="form-group">
	                                <label class="control-label">담당자 전화번호</label>
	                                <input type="text" class="form-control" name="managerTel" value="${corpuser.managerTel}">
	                            </div>
	                        </div>
							<div class="col-lg-6 col-12">
	                            <span class="mt-30">
	                                <label class="control-label">위치 정보 제공 동의
	                                <input type="checkbox" class="" name="corpAgreeLocation" value="Y" <c:if test="${corpuser.corpAgreeLocation eq 'Y'}">checked</c:if>></label>
	                            </span>
	                            <span class="mt-30">
	                                <label class="control-label">이메일 수신 동의
	                                <input type="checkbox" class="" name="corpAgreeEmail" value="Y"  <c:if test="${corpuser.corpAgreeEmail eq 'Y'}">checked</c:if>></label>
	                            </span>
	                            <span class="mt-30">
	                                <label class="control-label">SMS 수신 동의
	                                <input type="checkbox" class="" name="corpAgreeSms" value="Y"  <c:if test="${corpuser.corpAgreeSms eq 'Y'}">checked</c:if>></label>
	                            </span>
	                        </div>
	                    </div>
                        <div class="row mt-30">
	                        <div class="col-lg-12 text-center">
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