<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ include file="../include/Header.jsp" %>

<section class="section py-5">
    <div class="container">
        <!-- ====== 제목 영역 ====== -->
        <div class="text-center mb-5">
            <h2 class="fw-bold">${resume.resumeTitle}</h2>
            <p class="text-muted">
                작성일: <fmt:formatDate value="${resume.createdAt}" pattern="yyyy-MM-dd HH:mm" /> |
                수정일: <fmt:formatDate value="${resume.updatedAt}" pattern="yyyy-MM-dd HH:mm" />
            </p>
            <p>
            	<c:if test="${resume.status eq 'TEMP'}">
			        <span class="badge bg-warning text-dark">임시저장</span>
			    </c:if>
                 <c:if test="${resume.status eq 'FINAL'}">
			        <span class="badge bg-primary text-white">작성완료</span>
			    </c:if>
            </p>
        </div>

        <!-- ====== 학력사항 ====== -->
        <div class="card mb-4 shadow-sm">
            <div class="card-header bg-primary text-white">
                <h5 class="mb-0"><i class="lni lni-graduation"></i> 학력사항</h5>
            </div>
            <div class="card-body">
                <c:choose>
                    <c:when test="${not empty resume.educationList}">
                        <table class="table table-bordered table-hover text-center align-middle">
                            <thead class="table-light">
                                <tr>
                                    <th>학교명</th>
                                    <th>전공</th>
                                    <th>입학일</th>
                                    <th>졸업일</th>
                                    <th>상태</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="edu" items="${resume.educationList}">
                                    <tr>
                                        <td>${edu.schoolName}</td>
                                        <td>${edu.major}</td>
                                        <td><fmt:formatDate value="${edu.fromDate}" pattern="yyyy-MM-dd" /></td>
                                        <td><fmt:formatDate value="${edu.toDate}" pattern="yyyy-MM-dd" /></td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${edu.isGraduated eq 'Y'}">졸업</c:when>
                                                <c:otherwise>재학/중퇴</c:otherwise>
                                            </c:choose>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:when>
                    <c:otherwise>
                        <p class="text-muted">등록된 학력사항이 없습니다.</p>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <!-- ====== 경력사항 ====== -->
        <div class="card mb-4 shadow-sm">
            <div class="card-header bg-success text-white">
                <h5 class="mb-0"><i class="lni lni-briefcase"></i> 경력사항</h5>
            </div>
            <div class="card-body">
                <c:choose>
                    <c:when test="${not empty resume.careerList}">
                        <table class="table table-bordered table-hover text-center align-middle">
                            <thead class="table-light">
                                <tr>
                                    <th>회사명</th>
                                    <th>담당 업무</th>
                                    <th>입사일</th>
                                    <th>퇴사일</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="career" items="${resume.careerList}">
                                    <tr>
                                        <td>${career.companyName}</td>
                                        <td>${career.responsibility}</td>
                                        <td><fmt:formatDate value="${career.fromDate}" pattern="yyyy-MM-dd" /></td>
                                        <td><fmt:formatDate value="${career.toDate}" pattern="yyyy-MM-dd" /></td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:when>
                    <c:otherwise>
                        <p class="text-muted">등록된 경력사항이 없습니다.</p>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <!-- ====== 교육이력 ====== -->
        <div class="card mb-4 shadow-sm">
            <div class="card-header bg-info text-white">
                <h5 class="mb-0"><i class="lni lni-certificate"></i> 교육이력</h5>
            </div>
            <div class="card-body">
                <c:choose>
                    <c:when test="${not empty resume.trainingList}">
                        <table class="table table-bordered table-hover text-center align-middle">
                            <thead class="table-light">
                                <tr>
                                    <th>기관명</th>
                                    <th>교육 내용</th>
                                    <th>시작일</th>
                                    <th>종료일</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="train" items="${resume.trainingList}">
                                    <tr>
                                        <td>${train.institution}</td>
                                        <td>${train.content}</td>
                                        <td><fmt:formatDate value="${train.fromDate}" pattern="yyyy-MM-dd" /></td>
                                        <td><fmt:formatDate value="${train.toDate}" pattern="yyyy-MM-dd" /></td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:when>
                    <c:otherwise>
                        <p class="text-muted">등록된 교육이력이 없습니다.</p>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <!-- ====== 자격사항 ====== -->
        <div class="card mb-4 shadow-sm">
            <div class="card-header bg-warning text-white">
                <h5 class="mb-0"><i class="lni lni-medall"></i> 자격사항</h5>
            </div>
            <div class="card-body">
                <c:choose>
                    <c:when test="${not empty resume.certificationList}">
                        <table class="table table-bordered table-hover text-center align-middle">
                            <thead class="table-light">
                                <tr>
                                    <th>자격명</th>
                                    <th>취득일</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="cert" items="${resume.certificationList}">
                                    <tr>
                                        <td>${cert.certificationName}</td>
                                        <td><fmt:formatDate value="${cert.acquiredDate}" pattern="yyyy-MM-dd" /></td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:when>
                    <c:otherwise>
                        <p class="text-muted">등록된 자격사항이 없습니다.</p>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <!-- ====== 자기소개서 ====== -->
        <div class="card shadow-sm">
            <div class="card-header bg-dark text-white">
                <h5 class="mb-0"><i class="lni lni-user"></i> 자기소개서</h5>
            </div>
            <div class="card-body">
                <c:choose>
                    <c:when test="${not empty resume.selfIntro}">
                        <p><strong>지원동기:</strong><br>${resume.selfIntro.motivation}</p>
                        <hr>
                        <p><strong>강점 및 역량:</strong><br>${resume.selfIntro.strengths}</p>
                        <hr>
                        <p><strong>성과나 중요한 경험:</strong><br>${resume.selfIntro.keyExperience}</p>
                        <hr>
                        <p><strong>입사 후 포부:</strong><br>${resume.selfIntro.futurePlan}</p>
                    </c:when>
                    <c:otherwise>
                        <p class="text-muted">등록된 자기소개서 내용이 없습니다.</p>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
        
        <div class="mt-3 text-right">
            <a href="/resume/list?memberId=${resume.memberId}" class="btn btn-outline-secondary btn-sm">
                <i class="lni lni-arrow-left"></i> 목록으로
            </a>
            <a href="/resume/edit?resumeId=${resume.resumeId}" class="btn btn-outline-primary btn-sm">
                <i class="lni lni-pencil"></i> 수정
            </a>
            <form action="/resume/delete" method="post" style="display:inline;">
                <input type="hidden" name="resumeId" value="${resume.resumeId}">
                <input type="hidden" name="memberId" value="${resume.memberId}">
                <button type="submit" class="btn btn-outline-danger btn-sm" onclick="return confirm('정말 삭제하시겠습니까?');">
                    <i class="lni lni-trash-can"></i> 삭제
                </button>
            </form>
        </div>
    </div>
</section>

<%@ include file="../include/Footer.jsp" %>