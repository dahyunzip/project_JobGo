<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>

<div class="container-fluid">
    <h2 class="mb-4">공지 작성</h2>

    <form action="${pageContext.request.contextPath}/admin/noticeWrite"
          method="post"
          enctype="multipart/form-data">

        <div class="form-group">
            <label>제목</label>
            <input type="text" name="noticeTitle" class="form-control" required>
        </div>

        <div class="form-group">
            <label>내용</label>
            <textarea name="noticeContent" class="form-control" rows="10" required></textarea>
        </div>

        <div class="form-group">
            <label>첨부파일</label>
            <input type="file" name="file" class="form-control">
        </div>

        <button class="btn btn-primary">등록</button>
        <a href="${pageContext.request.contextPath}/admin/noticeManage"
           class="btn btn-secondary">취소</a>
    </form>
</div>

<%@ include file="footer.jsp" %>