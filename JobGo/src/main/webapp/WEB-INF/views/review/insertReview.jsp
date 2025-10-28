<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 작성</title>
</head>
<body>
	<h2>리뷰 작성</h2>
	<form action="/review/insertReview" method="post">
		<div>
			<label>회원 ID</label>
			<input type="text" name="member_id"/>
		</div>
		<div>
			<label>기업 ID</label>
			<input type="text" name="corp_id"/>
		</div>
		<div>
			<label>직무 코드</label>
			<input type="text" name="job_code"/>
		</div>
		<div>
			<label>근무 기간</label>
			<input type="text" name="work_months"/>
		</div>
		<div>
			<label>제목</label>
			<input type="text" name="rev_title"/>
		</div>
		<div>
			<label>내용</label>
			<textarea name="rev_content"></textarea>
		</div>
		<div>
			<label>별점: </label>
			<select name="rev_rate">
			    <c:forEach begin="1" end="5" var="i">
			        <option value="${i}">
			            <c:forEach begin="1" end="${i}" var="j">★</c:forEach>
    			        <c:forEach begin="1" end="${5 - i}" var="k">☆</c:forEach>
    			    </option>
    			</c:forEach>
			</select>
		</div>
		<div>
			<label>장점</label>
			<textarea name="rev_pros"></textarea>
		</div>
		<div>
			<label>단점</label>
			<textarea name="rev_cons"></textarea>
		</div>
		<div>
			<label>공개여부</label>
			<select name="rev_public">
				<option value="y">예</option>
				<option value="n">아니오</option>
			</select>
		</div>
	</form>
	
	
	
</body>
</html>