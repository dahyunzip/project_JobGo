<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>

<div class="container-fluid">
    <h2 class="mb-4">공지 수정</h2>

    <form action="${pageContext.request.contextPath}/admin/noticeEdit"
          method="post"
          enctype="multipart/form-data">

        <input type="hidden" name="noticeId" value="${notice.noticeId}">

        <div class="form-group">
            <label>제목</label>
            <input type="text" name="noticeTitle"
                   class="form-control"
                   value="${notice.noticeTitle}" required>
        </div>

        <div class="form-group">
            <label>내용</label>
            <textarea name="noticeContent" class="form-control" rows="10" required>${notice.noticeContent}</textarea>
        </div>

        <div class="form-group">
            <label>현재 파일</label><br>
            <c:choose>
                <c:when test="${not empty notice.storedFileName}">
                    <a href="${pageContext.request.contextPath}/resources/upload/${notice.storedFileName}"
                       download="${notice.storedFileName}">
                        ${notice.storedFileName}
                    </a>
                </c:when>
                <c:otherwise>
                    없음
                </c:otherwise>
            </c:choose>
        </div>

        <div class="form-group">
            <label>새 파일 업로드 (선택)</label>
            <input type="file" name="file" class="form-control">
        </div>

        <button class="btn btn-warning">수정 완료</button>
        <a href="${pageContext.request.contextPath}/admin/noticeDetail?noticeId=${notice.noticeId}"
           class="btn btn-secondary">취소</a>
    </form>
</div>

<%@ include file="footer.jsp" %>