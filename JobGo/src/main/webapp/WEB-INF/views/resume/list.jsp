<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ include file="../include/Header.jsp" %>
<script>
	$(document).ready(function(){
		var status = '${msg}';
		if(status == 'writeDone'){
			alert("이력서 작성 완료");
		}else if(status == 'deleteDone'){
			alert("이력서 삭제 완료");
		}else if(status == 'editDone'){
			alert("이력서 수정 완료");
		}
	});
</script>
<section class="section resume-list-section py-5">
    <div class="container">
        <div class="section-title text-center mb-4">
            <h2>내 이력서 목록</h2>
            <p>등록한 이력서를 확인하거나 수정할 수 있습니다.</p>
        </div>

        <!-- 등록 버튼 -->
        <div class="text-right mb-4">
            <a href="/resume/write" class="btn btn-primary">
                <i class="lni lni-add-files"></i> 새 이력서 작성
            </a>
        </div>

        <!-- 이력서 목록 테이블 -->
        <div class="table-responsive">
            <table class="table table-hover align-middle text-center">
                <thead class="thead-light">
                    <tr>
                        <th>번호</th>
                        <th>이력서 제목</th>
                        <th>작성일</th>
                        <th>수정일</th>
                        <th>관리</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${not empty resumeList}">
                            <c:forEach var="resume" items="${resumeList}" varStatus="status">
                                <tr>
                                    <td>${status.index + 1}</td>
                                    <td class="text-left">
                                        <a href="/resume/detail?resumeId=${resume.resumeId}" class="text-dark font-weight-bold">
                                            ${resume.resumeTitle}
                                        </a>
                                    </td>
                                    <td>
                                        <fmt:formatDate value="${resume.createdAt}" pattern="yyyy-MM-dd HH:mm" />
                                    </td>
                                    <td>
                                        <fmt:formatDate value="${resume.updatedAt}" pattern="yyyy-MM-dd HH:mm" />
                                    </td>
                                    <td>
                                        <div class="btn-group">
                                            <a href="/resume/detail?resumeId=${resume.resumeId}" class="btn btn-sm btn-outline-info">
                                                <i class="lni lni-eye"></i> 보기
                                            </a>
                                            <a href="/resume/edit?resumeId=${resume.resumeId}" class="btn btn-sm btn-outline-warning">
                                                <i class="lni lni-pencil"></i> 수정
                                            </a>
                                            <form action="/resume/delete" method="post" style="display:inline;">
                                                <input type="hidden" name="resumeId" value="${resume.resumeId}">
                                                <input type="hidden" name="memberId" value="${resume.memberId}">
                                                <button type="submit" class="btn btn-sm btn-outline-danger"
                                                    onclick="return confirm('정말 삭제하시겠습니까?');">
                                                    <i class="lni lni-trash-can"></i> 삭제
                                                </button>
                                            </form>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr>
                                <td colspan="5" class="text-muted py-4">
                                    아직 등록된 이력서가 없습니다. <br>
                                    <a href="/resume/write" class="btn btn-outline-primary mt-3">이력서 작성하기</a>
                                </td>
                            </tr>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>
    </div>
</section>

<%@ include file="../include/Footer.jsp" %>
