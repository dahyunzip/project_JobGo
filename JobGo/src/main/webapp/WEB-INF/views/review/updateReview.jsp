<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 수정</title>
</head>
<body>
	<form action="/review/insertReview" method="post">
		<input type="hidden" name="rev_title" value="${reviewDetail.review_id}"/>
		<div>
			<label>회원 ID</label>
			<input type="text" name="member_id" value="${reviewDetail.member_id}"/>
		</div>
		<div>
			<label>기업 ID</label>
			<input type="text" name="corp_id" value="${reviewDetail.corp_id }"/>
		</div>
		<div>
			<label>직무 코드</label>
			<input type="text" name="job_code" value="${reviewDetail.job_code }"/>
		</div>
		<div>
			<label>근무 기간</label>
			<input type="text" name="work_months" value="${reviewDetail.work_months }"/>
		</div>
		<div>
			<label>제목</label>
			<input type="text" name="rev_title" value="${reviewDetail.rev_title }"/>
		</div>
		<div>
			<label>내용</label>
			<textarea name="rev_content">${reviewDetail.rev_content}</textarea>
		</div>
		<div>
			<label>별점: </label>
			<select name="rev_rate">
			    <c:forEach begin="1" end="5" var="i">
			        <option value="${i}" ${i == review.rev_rate ? 'selected' : ''}>
			            <c:forEach begin="1" end="${i}" var="j">★</c:forEach>
			            <c:forEach begin="1" end="${5 - i}" var="k">☆</c:forEach>
			        </option>
			    </c:forEach>
			</select>
		</div>
		<div>
			<label>장점</label>
			<textarea name="rev_pros">${reviewDetail.rev_pros}</textarea>
		</div>
		<div>
			<label>단점</label>
			<textarea name="rev_cons">${reviewDetail.rev_cons}</textarea>
		</div>
		<div>
			<label>공개여부</label>
			<select name="rev_public">
				<option value="y" ${reviewDetail.rev_public == 'y' ? 'selected' : ''}>예</option>
                <option value="n" ${reviewDetail.rev_public == 'n' ? 'selected' : ''}>아니오</option>
            </select>
		</div>
	</form>
</body>
</html>