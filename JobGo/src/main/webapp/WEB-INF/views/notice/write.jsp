<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지 작성</title>
</head>
<body>
<%@ include file="../include/Header.jsp"%>
<div style="width:80%; margin:40px auto;">
	<h2 style="margin-bottom:20px;"> 공지 작성 </h2>
	
	<form action="/notice/write" method="post" enctype="multipart/form-data">
		제목 : <input type="text" name="noticeTitle" style="width:100%; padding:8px; margin-bottom:15px; border:1px solid #ccc;" required><br>
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
</body>
<%@ include file="../include/Footer.jsp"%>
</html>