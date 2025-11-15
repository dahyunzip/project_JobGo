<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../include/Header.jsp"%>
<section class="section">
	<h2 class="pageTitle">공지사항 작성</h2>
	<div class="container">
	<c:choose>
		<c:when test="${sessionScope.membertype eq 'A'}">
				<form action="/notice/write" method="post" enctype="multipart/form-data">
					<!-- 제목 -->
					<label>제목 :</label><br>
					<input type="text" id="noticeTitle" name="noticeTitle" class="form-control" required><br>
	
					<!-- 공지 유형 선택 (일반 / 기업) -->
					<label>공지 유형 :</label><br>
					<select id="noticeType" name="corpNotice" class="form-control" >
						<option value="A">일반 공지</option>
						<option value="corp">기업 공지</option>
					</select><br>
					
					내용 : <br>
					<textarea name="noticeContent" rows="8" cols="50" class="form-control" required></textarea>
			
					첨부파일: <input type="file" name="file"  class="form-control"><br>
			
					<div class="button text-right">
						<button type="submit" class="btn">
							등록
						</button>
				
						<button type="button" onclick="location.href='/notice/list'" class="btn2">
							취소
						</button>
					</div>
				</form>
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
