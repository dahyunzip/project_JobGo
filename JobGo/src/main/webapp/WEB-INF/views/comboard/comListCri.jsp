<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/Header.jsp"%>
<section class="find-job job-list section">
        <div class="container">
        	<c:set var="cri" value="${pageVO.cri }" scope="page"/>
            <div class="col-lg-6 col-12">
                        <!-- Single Job -->
                        <div class="single-job">
                            <div class="job-image">
                                <img src="/resources/images/clients/client1.png" alt="#">
                            </div>
                            <c:forEach var="vo" items="${cboardList }">
	                            <div class="job-content">
	                                <h4><a href="/comboard/comRead?com_bno=${vo.com_bno}&page=${cri.page}">${vo.com_title }</a></h4>
	                                <ul>
	                                    <li><a href="#">${vo.email }</a></li>
	                                </ul>
	                            </div>
	                            <div class="job-button">
	                                <ul>
	                                    <li>작성자:	${vo.writer }님</li>
	                                    <li>작성일:	<fmt:formatDate value="${vo.com_regdate }"/></li>
	                                    <li>조회수:	<span>${vo.com_viewcnt }</span></li>
	                                </ul>
	                            </div>
	                            <hr>
                            </c:forEach>
                        </div>

                <!-- Pagination -->
                <div class="row">
                    <div class="col-12">
                    	<div class="button">
	                    	<a href="/comboard/comRegist"><button type="button" class="btn ">글쓰기</button></a>
                    	</div>
                        <div class="pagination center">
                            <ul class="pagination-list">
	                            <c:if test="${pageVO.prev}">
	                            	<!-- 이전 버튼 -->
	                                <li>
	                                	<a href="/comboard/comListCri?page=${pageVO.startPage - 1}"><i class="lni lni-arrow-left"></i></a>
	                                </li>
	                            </c:if>
	                            <c:forEach var="i" begin="${pageVO.startPage }" end="${pageVO.endPage }" step="1">
	                                <li class="${cri.page == i ? 'active' : ''}">
	                                	<a href="/comboard/comListCri?page=${i}">${i }</a>
	                                </li>
                                </c:forEach>
                              
                              	<c:if test="${pageVO.next}">                              	
	                              	<!-- 다음 버튼 -->
	                                <li>
	                                	<a href="/comboard/comListCri?page=${pageVO.endPage + 1}"><i class="lni lni-arrow-right"></i></a>
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