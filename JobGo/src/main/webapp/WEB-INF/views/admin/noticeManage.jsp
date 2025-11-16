<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="header.jsp" %>

<div class="container-fluid">
    <h2 class="mb-4">공지사항 관리</h2>

    <!-- 공지사항 등록 버튼 -->
    <div class="mb-3 text-right">
       <a href="${pageContext.request.contextPath}/admin/noticeWrite"
           class="btn btn-primary btn-sm">
            <i class="fas fa-plus"></i> 공지 작성
        </a>
    </div>

    <!-- 검색 -->
    <form action="${pageContext.request.contextPath}/admin/noticelist" method="get" class="form-inline mb-3">
        <input type="text" name="search" value="${pageVO.cri.search}"
               class="form-control form-control-sm mr-2" placeholder="제목 검색">
        <button type="submit" class="btn btn-sm btn-secondary">검색</button>
    </form>

    <!-- 공지사항 테이블 -->
    <table class="table table-bordered text-center">
        <thead class="bg-light">
            <tr>
                <th>번호</th>
                <th>제목</th>
                <th>파일</th>
                <th>조회수</th>
                <th>등록일</th>
                <th>수정일</th>
                <th>관리</th>
            </tr>
        </thead>
        <tbody>
            <c:choose>
                <c:when test="${empty noticeList}">
                    <tr>
                        <td colspan="7" class="text-muted">등록된 공지사항이 없습니다.</td>
                    </tr>
                </c:when>

                <c:otherwise>
                    <c:forEach var="n" items="${noticeList}">
                        <tr>
                            <td>${n.noticeId}</td>

                            
                            <td>
                                <a href="${pageContext.request.contextPath}/admin/noticeDetail?noticeId=${n.noticeId}">
                                    ${n.noticeTitle}
                                </a>
                            </td>

                            <td>
    							<c:choose>
        							<c:when test="${not empty n.storedFileName}">
            							<a href="${pageContext.request.contextPath}/resources/upload/${n.storedFileName}"
   										   download="${n.storedFileName}"
   										   class="text-primary font-weight-bold">
    									   ${n.storedFileName}
										</a>
        							</c:when>
        							<c:otherwise>
            							<span class="text-muted">없음</span>
        							</c:otherwise>
    							</c:choose>
							</td>

                            <td>${n.noticeViewCnt}</td>

                            <td>${n.noticeRegdate}</td>

                            <td>${n.noticeUpdated}</td>

                            <!-- 관리 버튼 -->
                            <td>
                                <a href="${pageContext.request.contextPath}/admin/noticeEdit?noticeId=${n.noticeId}"
                                   class="btn btn-sm btn-warning">수정</a>

                                 <form action="${pageContext.request.contextPath}/admin/noticeDelete"
                                      method="post"
                                      style="display:inline-block;"
                                      onsubmit="return confirm('정말 삭제하시겠습니까?');">
                                    <input type="hidden" name="noticeId" value="${n.noticeId}">
                                    <button type="submit" class="btn btn-sm btn-danger">삭제</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </tbody>
    </table>

    <!-- 페이징 -->
    <div class="d-flex justify-content-center mt-4">
        <ul class="pagination">

            <!-- 이전 버튼 -->
            <c:if test="${pageVO.prev}">
                <li class="page-item">
                    <a class="page-link"
                       href="?page=${pageVO.startPage - 1}&pageSize=${pageVO.cri.pageSize}&search=${pageVO.cri.search}">
                        <i class="lni lni-arrow-left"></i>
                    </a>
                </li>
            </c:if>

            <!-- 페이지 번호 -->
            <c:forEach var="num" begin="${pageVO.startPage}" end="${pageVO.endPage}">
                <li class="page-item ${pageVO.cri.page == num ? 'active' : ''}">
                    <a class="page-link"
                       href="?page=${num}&pageSize=${pageVO.cri.pageSize}&search=${pageVO.cri.search}">
                        ${num}
                    </a>
                </li>
            </c:forEach>

            <!-- 다음 버튼 -->
            <c:if test="${pageVO.next}">
                <li class="page-item">
                    <a class="page-link"
                       href="?page=${pageVO.endPage + 1}&pageSize=${pageVO.cri.pageSize}&search=${pageVO.cri.search}">
                        <i class="lni lni-arrow-right"></i>
                    </a>
                </li>
            </c:if>

        </ul>
    </div>

</div>

<%@ include file="footer.jsp" %>