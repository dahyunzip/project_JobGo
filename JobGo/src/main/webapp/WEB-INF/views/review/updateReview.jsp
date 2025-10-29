<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 수정 (실전용)</title>
</head>
<body>
    <h2>리뷰 수정</h2>

    <!-- 실전용 : 로그인 세션 기반으로 본인만 수정 가능 -->
    <!-- 테스트 시에는 action만 동일하게 두고 세션 제거 가능 -->
    <form action="${pageContext.request.contextPath}/review/updateReview" method="post">

        <!-- 리뷰 ID (고정값) -->
        <input type="hidden" name="review_id" value="${review.review_id}" />

        <!-- 실전용  -->
        <!-- <input type="hidden" name="member_id" value="${sessionScope.loginMember.id}" /> -->
        <!-- 테스트용 변경 시 -->
        <div>
            <label>회원 ID</label>
            <input type="text" name="member_id" value="${review.member_id}" />
        </div>
       

        <div>
            <label>기업 ID</label>
            <input type="text" name="corp_id" value="${review.corp_id}" readonly />
            <!-- 테스트용에서는 readonly 제거 가능 -->
        </div>

        <div>
            <label>직무 코드</label>
            <input type="text" name="job_code" value="${review.job_code}" />
        </div>

        <div>
            <label>근무 기간</label>
            <select name="work_months">
                <option value="">선택하세요</option>
                <option value="A" <c:if test="${review.work_months == 'A'}">selected</c:if>>1개월 미만</option>
                <option value="B" <c:if test="${review.work_months == 'B'}">selected</c:if>>1~3개월</option>
                <option value="C" <c:if test="${review.work_months == 'C'}">selected</c:if>>3~6개월</option>
                <option value="D" <c:if test="${review.work_months == 'D'}">selected</c:if>>6~12개월</option>
                <option value="E" <c:if test="${review.work_months == 'E'}">selected</c:if>>1~2년</option>
                <option value="F" <c:if test="${review.work_months == 'F'}">selected</c:if>>2~3년</option>
                <option value="G" <c:if test="${review.work_months == 'G'}">selected</c:if>>3~5년</option>
                <option value="H" <c:if test="${review.work_months == 'H'}">selected</c:if>>5년 이상</option>
            </select>
        </div>

        <div>
            <label>제목</label>
            <input type="text" name="rev_title" value="${review.rev_title}" />
        </div>

        <div>
            <label>내용</label>
            <textarea name="rev_content">${review.rev_content}</textarea>
        </div>

        <div>
            <label>별점</label>
            <div id="star-rating">
                <span class="star" data-value="1">☆</span>
                <span class="star" data-value="2">☆</span>
                <span class="star" data-value="3">☆</span>
                <span class="star" data-value="4">☆</span>
                <span class="star" data-value="5">☆</span>
            </div>
            <input type="hidden" name="rev_rate" id="rev_rate" value="${review.rev_rate}">
        </div>

        <div>
            <label>장점</label>
            <textarea name="rev_pros">${review.rev_pros}</textarea>
        </div>

        <div>
            <label>단점</label>
            <textarea name="rev_cons">${review.rev_cons}</textarea>
        </div>

        <div>
            <label>공개 여부</label>
            <select name="rev_public">
                <option value="y" <c:if test="${review.rev_public == 'y'}">selected</c:if>>예</option>
                <option value="n" <c:if test="${review.rev_public == 'n'}">selected</c:if>>아니오</option>
            </select>
        </div>

        <div>
            <button type="submit">수정 완료</button>
        </div>
    </form>

    <script>
        // 별점 초기값 설정 및 클릭 이벤트 처리
        const stars = document.querySelectorAll('#star-rating .star');
        const revRateInput = document.getElementById('rev_rate');
        const initialRate = parseInt(revRateInput.value) || 0;

        stars.forEach((s, i) => {
            s.textContent = i < initialRate ? '★' : '☆';
        });

        stars.forEach(star => {
            star.addEventListener('click', () => {
                const value = parseInt(star.getAttribute('data-value'));
                revRateInput.value = value;
                stars.forEach((s, i) => {
                    s.textContent = i < value ? '★' : '☆';
                });
            });
        });
    </script>
</body>
</html>
