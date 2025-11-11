<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지 작성</title>
</head>
<body>
<%@ include file="../include/Header.jsp"%>
<c:choose>
	<c:when test="${sessionScope.membertype eq 'A'}">

		<div style="width:80%; margin:40px auto;">
			<h2 style="margin-bottom:20px;"> 공지 작성 </h2>
	
			<form action="/notice/write" method="post" enctype="multipart/form-data">
				<!-- 제목 -->
				<label>제목 :</label><br>
				<input type="text" id="noticeTitle" name="noticeTitle"
					   style="width:100%; padding:8px; margin-bottom:15px; border:1px solid #ccc;" required><br>

				<!-- 공지 유형 선택 (일반 / 기업) -->
				<label>공지 유형 :</label><br>
				<select id="noticeType" style="margin-bottom:15px; padding:6px; border:1px solid #ccc;">
					<option value="A">일반 공지</option>
					<option value="C">기업 공지</option>
				</select><br>
				내용 : <br>
				<textarea name="noticeContent" rows="8" cols="50" style="width:100%; padding:8px; border:1px solid #ccc; margin-bottom:15px;" required></textarea>
		
				첨부파일: <input type="file" name="file" style="margin-bottom:20px; display:block;"><br>
		
				<div style="display:flex; gap:10px;">
					<button type="submit" style="padding:8px 14px; background:#28a745; color:#fff; border:none; cursor:pointer; border-radius:4px;">
						등록
					</button>
			
					<button type="button"
							style="padding:8px 14px; background:#999; color:#fff; border:none; cursor:pointer; border-radius:4px;"
							onclick="location.href='/notice/list'">
						취소
					</button>
				</div>
			</form>
		</div>
	</c:when>
	<c:otherwise>
		<script>
			alert("관리자만 공지를 수정할 수 있습니다.");
			location.href='/notice/list';
		</script>
	</c:otherwise>
	
</c:choose>
</body>
<%@ include file="../include/Footer.jsp"%>
</html>