<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../include/Header.jsp"%>

<script>
$(document).ready(function(){
    const msg = '${msg}';
    if (msg === 'modifySuccess') {
        alert('정보 수정이 완료되었습니다.');
    } else if (msg === 'deleteSuccess') {
        alert('회원 탈퇴가 완료되었습니다.');
    }
});
</script>

<div class="job-details section" id="mypage">
	<h2 class="pageTitle">마이페이지</h2>
    <div class="container">
        <div class="row mb-n5">
            <!-- Main Content -->
            <div class="col-lg-12 col-12">
                <div class="job-details-inner box">
                    <!-- Header -->
                    <div class="job-details-head row mx-0 align-items-center">
                        <div class="user-img col-auto">
                            <c:set var="corpLogo" value="${empty corpuser.corpProfileStored ? 'default.jpg' : corpuser.corpProfileStored}" />
                            <div style="border-radius: 4px; overflow: hidden; width:100px; height:100px;">
                                <img src="/upload/${corpLogo}" style="object-fit:cover;" alt="기업 로고">
                            </div>
                        </div>
                        <div class="content col">
                            <h5 class="title">${corpuser.managerName} 님 안녕하세요.</h5>
                            <p class="mb-0">${corpuser.companyName}</p>
                        </div>
                    </div>

                    <!-- Body -->
                    <div class="job-details-body mt-4">
                        <h6 class="mb-3">기업 회원 정보</h6>
                        <ul class="info-list">
                            <li><strong>아이디:</strong> ${corpuser.corpUserId}</li>
                            <li><strong>이메일:</strong> ${corpuser.managerEmail}</li>
                            <li><strong>전화번호:</strong> ${corpuser.managerTel}</li>
                            <li><strong>주소:</strong> 
                                <c:choose>
                                    <c:when test="${empty corpuser.companyAddress}">미등록</c:when>
                                    <c:otherwise>${corpuser.companyAddress}</c:otherwise>
                                </c:choose>
                            </li>
                            <li><strong>회사명:</strong> ${corpuser.companyName}</li>
                            <li><strong>대표자명:</strong> ${corpuser.ceoName}</li>
                            <li><strong>업종:</strong> ${corpuser.industryType}</li>
                            <li><strong>업태:</strong> ${corpuser.businessType}</li>
                            <li><strong>회원가입일:</strong> <fmt:formatDate value="${corpuser.corpJoined}" pattern="yyyy-MM-dd HH:mm" /></li>
                            <li><strong>최근 수정일:</strong> <fmt:formatDate value="${corpuser.corpUpdated}" pattern="yyyy-MM-dd HH:mm" /></li>
                            <li><strong>위치정보 동의:</strong> 
                                <c:out value="${corpuser.corpAgreeLocation eq 'Y' ? '동의' : '미동의'}"/>
                            </li>
                            <li><strong>이메일 수신 동의:</strong> 
                                <c:out value="${corpuser.corpAgreeEmail eq 'Y' ? '동의' : '미동의'}"/>
                            </li>
                            <li><strong>SMS 수신 동의:</strong> 
                                <c:out value="${corpuser.corpAgreeSms eq 'Y' ? '동의' : '미동의'}"/>
                            </li>
                            <li><strong>가입 상태:</strong> 
                                <c:choose>
                                    <c:when test="${corpuser.status eq 'A'}"><span style="color:green;">활성</span></c:when>
                                    <c:when test="${corpuser.status eq 'W'}"><span style="color:orange;">대기</span></c:when>
                                    <c:otherwise><span style="color:red;">비활성</span></c:otherwise>
                                </c:choose>
                            </li>
                        </ul>

                        <div class="button text-right mt-4">
                            <a href="/corp/modify" class="btn">정보 수정하기</a>
                        </div>
                    </div>

                    <!-- 탈퇴 -->
                    <div class="text-left mt-3">
                        <a href="/corp/delete" class="dropBtn" >회원 탈퇴하기</a>
                    </div>

                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="../include/Footer.jsp"%>