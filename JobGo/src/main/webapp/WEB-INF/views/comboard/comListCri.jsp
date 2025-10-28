<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../include/Header.jsp"%>
<section class="find-job job-list section">
        <div class="container">
        	<c:set var="cri" value="${pageVO.cri }" scope="page"/>
            <div class="single-head">
                <div class="row">
                    <div class="col-lg-6 col-12">
                        <!-- Single Job -->
                        <div class="single-job">
                            <div class="job-image">
                                <img src="assets/images/jobs/img1.png" alt="#">
                            </div>
                            <div class="job-content">
                                <h4><a href="job-details.html">커뮤니티 글 리스트</a></h4>
                            <table>
                                <tbody>
									<tr>
										<th>번호</th>
										<th>제목</th>
										<th>작성자</th>
										<th style="width: 90px">조회수</th>
										<th>작성일</th>
									</tr>
									<c:forEach var="vo" items="${cboardList}">
										<tr>
											<td>${vo.com_bno}</td>
											<td><a href="/board/read?bno=${vo.com_bno}">${vo.com_title}</a></td>
											<td>${vo.writer}</td>
											<td><span class="badge bg-green">${vo.com_viewcnt}</span></td>
											<td><fmt:formatDate value="${vo.com_regdate}"/></td>
										</tr>
									</c:forEach>
								</tbody>
                             </table>
                        </div>
                    </div>
                </div>
                <!-- Pagination -->
                <div class="row">
                    <div class="col-12">
                        <div class="pagination center">
                            <ul class="pagination-list">
	                            <c:if test="${pageVO.prev}">
	                            	<!-- 이전 버튼 -->
	                                <li>
	                                	<a href="/comboard/comListCri?page=${pageVO.startPage - 1}"><i class="lni lni-arrow-left"></i></a>
	                                </li>
	                            </c:if>
	                            <c:forEach var="i" begin="${pageVO.startPage }" end="${pageVO.endPage }" step="1">
	                                <li class="active">
	                                	<a href="/comboard/comListCri?page=${i}">${i }</a>
	                                </li>
                                </c:forEach>
                              
                              	<c:if test="${pageVO.next}">                              	
	                              	<!-- 다음 버튼 -->
	                                <li>
	                                	<a href="/comboard/comListCri?page=${pageVO.startPage + 1}"><i class="lni lni-arrow-right"></i></a>
	                                </li>
                              	</c:if>
                            </ul>
                        </div>
                    </div>
                </div>
                <!--/ End Pagination -->
            </div>
        </div>
</section>
<%@ include file="../include/Footer.jsp"%>