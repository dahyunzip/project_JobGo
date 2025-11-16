<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="header.jsp" %>

<div class="container-fluid">
    <h2 class="mb-4">공지 상세보기</h2>

    <table class="table table-bordered">
        <tr>
            <th>제목</th>
            <td>${notice.noticeTitle}</td>
        </tr>
        <tr>
            <th>내용</th>
            <td style="white-space:pre-line;">${notice.noticeContent}</td>
        </tr>
        <tr>
            <th>첨부파일</th>
            <td>
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
            </td>
        </tr>
        <tr>
            <th>등록일</th>
            <td>${notice.noticeRegdate}</td>
        </tr>
        <tr>
            <th>수정일</th>
            <td>${notice.noticeUpdated}</td>
        </tr>
    </table>

    <div class="mt-3">
        <a href="${pageContext.request.contextPath}/admin/noticeManage"
           class="btn btn-secondary">목록</a>

        <a href="${pageContext.request.contextPath}/admin/noticeEdit?noticeId=${notice.noticeId}"
           class="btn btn-warning">수정</a>
    </div>
</div>

<%@ include file="footer.jsp" %>