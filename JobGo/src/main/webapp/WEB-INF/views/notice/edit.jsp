<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title> 공지 수정 </title>
</head>
<body>
<%@ include file="../include/Header.jsp"%>
<div style="width:80%; margin:40px auto; font-family:'Inter', sans-serif;">
	<h2 style="margin-bottom:20px; border-left:4px solid #007bff; padding-left:10px;"> 공지 수정 </h2>
	
	<form action="/notice/edit" method="post">
		<input type="hidden" name="noticeId" value="${notice.noticeId }">
		
		<div style="margin-bottom:15px;">
		
			제목 : <input type="text" name="noticeTitle" value="${notice.noticeTitle }" style="width:100%; padding:8px; border:1px solid #ccc; border-radius:4px;"
				  	      required><br>
		</div>
		<div>
			내용 : <br>
			<textarea name="noticeContent" rows="8" cols="50"style="width:100%; padding:10px; border:1px solid #ccc; border-radius:4px; line-height:1.5;"
					  required>${notice.noticeContent}</textarea>
		</div>
		<div style="margin-bottom:15px;">
			<label style="font-weight:bold; display:block; margin-bottom:5px;">첨부파일 (선택 변경)</label>
			<input type="file" name="file"
				   style="display:block; margin-bottom:8px;">

			<c:if test="${not empty notice.storedFileName}">
				<div style="font-size:14px; color:#444; margin-top:5px;">
					현재 파일: <span style="color:#007bff;">${notice.storedFileName}</span>
				</div>
			</c:if>
		</div>
		
		<div style="display:flex; gap:10px; margin-top:20px;">
			<button type="submit"
					style="padding:8px 16px; background:#28a745; border:none; border-radius:4px; color:#fff; cursor:pointer;">
				수정완료
			</button>

			<button type="button"
					style="padding:8px 16px; background:#6c757d; border:none; border-radius:4px; color:#fff; cursor:pointer;"
					onclick="location.href='/notice/detail?noticeId=${notice.noticeId}'">
				취소
			</button>
		</div>
		
	</form>
	
	<button type="button" onclick="location.href='/notice/detail?noticeId=${notice.noticeId}'">
		취소
	</button>
</div>
</body>
<%@ include file="../include/Footer.jsp"%>
</html>