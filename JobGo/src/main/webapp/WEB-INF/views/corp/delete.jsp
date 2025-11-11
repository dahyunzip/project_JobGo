<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../include/Header.jsp"%>

<script>
$(function(){
    var status = '${msg}';
    if(status == 'dropFail'){
        alert('형식에 맞게 입력해주세요.');
    }

    $("form").on("submit", function(e){
        var check = $("#agreeCheck").is(":checked");
        var text = $.trim($("#confirmText").val());

        if(!check){
            alert("약관에 동의해야 탈퇴가 가능합니다.");
            e.preventDefault();
            return false;
        }

        if(text != "탈퇴하겠습니다."){
            alert("탈퇴 동의 문구를 정확히 입력해주세요.");
            e.preventDefault();
            return false;
        }

        return true;
    });
});
</script>

<section class="add-resume section">
    <c:if test="${empty sessionScope.corpUserId}">
        <c:redirect url="/corp/login"/>
    </c:if>

    <div class="container">
        <div class="row">
            <div class="col-lg-12 col-12">
                <div class="add-resume-inner box">
                    <div class="post-header align-items-center justify-content-center">
                        <h3>기업회원 탈퇴</h3>
                    </div>
                    <form class="form-ad" method="post">
                        <input type="hidden" name="corpUserId" value="${corpuser.corpUserId}">
                        <input type="hidden" name="corpUserPw" value="${corpuser.corpUserPw}">
                        <div class="row text-center">
                            <h5 class="mb-20">${corpuser.managerName} 님, 정말 탈퇴하시겠어요?</h5>
                            <p class="mb-20">
                                탈퇴를 원하신다면, 약관 동의 후 
                                '<strong style="color:red">탈퇴하겠습니다.</strong>' 를 입력해주세요.
                            </p>

                            <div class="form-group">
                                <div class="agree-box">
                                    JobGo는 회원정보를 2년간 보관 후 자동 파기합니다.  
                                    탈퇴 후에는 기업회원으로 등록된 공고 및 데이터가 모두 삭제됩니다.
                                </div>
                                <label for="agreeDrop">
                                    <input type="checkbox" name="agreeCheck" id="agreeCheck"> 약관에 동의합니다.
                                </label>
                            </div>

                            <div class="form-group">
                                <input type="text" placeholder="입력해주세요." class="text-center" 
                                       id="confirmText" name="confirmText">
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-lg-12 col-12 text-center">
                                <div class="button">
                                    <button type="submit" class="btn">탈퇴하기</button>
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