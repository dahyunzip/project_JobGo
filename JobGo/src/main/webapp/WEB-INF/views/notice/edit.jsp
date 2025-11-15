<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../include/Header.jsp"%>
<section class="section">
	<h2 class="pageTitle">공지사항 수정</h2>
	<div class="container">
	<c:choose>
		<c:when test="${sessionScope.membertype eq 'A'}">
			<div>
				<form action="/notice/edit" method="post" enctype="multipart/form-data">
					<input type="hidden" name="noticeId" value="${notice.noticeId }">
					
					<div style="margin-bottom:15px;">
					
						제목 <input type="text" name="noticeTitle" value="${notice.noticeTitle }" style="width:100%; padding:8px; border:1px solid #ccc; border-radius:4px;"
							  	      required><br>
					</div>
					<div>
						내용 <br>
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
			
					<div class="button text-right">
						<button type="button" class="btn btn2" onclick="location.href='/notice/detail?noticeId=${notice.noticeId}'">
							취소
						</button>
						<button type="submit" class="btn">
							수정완료
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
	</div>
</section>
<%@ include file="../include/Footer.jsp"%>
