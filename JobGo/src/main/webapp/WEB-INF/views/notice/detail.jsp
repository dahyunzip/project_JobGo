<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지 상세 보기</title>
</head>
<body>
<%@ include file="../include/Header.jsp"%>
	<h2> 공지 상세 보기 </h2>
	
	<p>번호 : ${notice.noticeId }</p>
	<p>제목 : ${notice.noticeTitle }</p>
	<p>내용 : ${notice.noticeContent }</p>
	<p>작성일 : ${notice.noticeRegdate }</p>
	<p>조회수 : ${notice.noticeViewCnt }</p>
	<br>
	
	<c:if test="${sessionScope.membertype eq 'A' }">
		<form action="/notice/edit" method="get">
			<input type="hidden" name="noticeId" value="${notice.noticeId}">
			<input type="submit" value="수정">
		</form>
		
		<form action="/notice/delete" method="post">
			<input type="hidden" name="noticeId" value="${notice.noticeId}">
			<input type="submit" value="삭제">
		</form>
	</c:if>
	
	<a href="/notice/list">목록으로</a>

</body>
<%@ include file="../include/Footer.jsp"%>
</html>