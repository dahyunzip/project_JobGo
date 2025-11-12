<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>지원 내역</title>
    <style>
        .application-item {
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 12px;
            margin: 10px 0;
        }
        .application-item h3 {
            margin: 0;
        }
        .application-item p {
            margin: 4px 0;
        }
        button {
            background-color: #f25c5c;
            color: white;
            border: none;
            padding: 6px 12px;
            border-radius: 4px;
            cursor: pointer;
        }
        button:hover {
            background-color: #d94343;
        }
    </style>
</head>
<body>

<h2>나의 지원 내역</h2>

<c:if test="${empty applications}">
    <p>지원한 공고가 없습니다.</p>
</c:if>

<c:forEach var="app" items="${applications}">
    <div class="application-item">
        <h3>${app.rec_title}</h3>
        <p>기업명: ${app.corp_name}</p>
        <p>이력서: ${app.resume_title}</p>
        <p>지원일: ${app.applied_at}</p>
        <p>상태: ${app.status}</p>

        <form method="post" action="/application/withdraw">
            <input type="hidden" name="application_id" value="${app.application_id}">
            <button type="submit">지원 취소</button>
        </form>
    </div>
</c:forEach>

</body>
</html>