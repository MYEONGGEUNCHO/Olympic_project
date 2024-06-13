<%@page import="com.fasterxml.jackson.annotation.JsonInclude.Include"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<script src="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.js"></script>
<script>

</script>
<style type="text/css">
    table {
        border-collapse: collapse !important;
    }
    th, td {
        max-width: 150px !important; /* 셀의 최대 너비 설정 */
        overflow: hidden !important; /* 넘치는 부분 숨기기 */
        text-overflow: ellipsis !important; /* 넘치는 부분 생략 (...) 표시 */
        white-space: nowrap !important; /* 텍스트 줄바꿈 방지 */
        text-align: center !important; /* 텍스트 중앙 정렬 */
        padding: 8px !important; /* 셀의 여백 설정 */
    }
</style>
</head>

<body>
	<div id="wrapper">
	<!-- 슬라이더 바 -->
	<%@include file="/WEB-INF/views/common/adminslide.jsp"%>
		<!-- Content Wrapper -->
        <div id="content-wrapper" class="d-flex flex-column">

            <!-- Main Content -->
            <div id="content">
            <!-- 상단 툴바 -->
			<%@include file="/WEB-INF/views/common/adminheader.jsp"%>
                
				<!-- 추가 -->
                <!-- Begin Page Content -->
                <div class="container-fluid">

                    <!-- Page Heading -->
                    <h1 class="h3 mb-2 text-gray-800">Sport Table</h1>
                    <p class="mb-4">종목 관리 테이블입니다.</p>

                    <!-- DataTales Example -->
                    <div class="card shadow mb-4">
                        <div class="card-header py-3">
                            <h6 class="m-0 font-weight-bold text-primary">Sport Table</h6>
                        </div>
                        <div class="card-body">
							<div class="table-responsive">
								<table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
									
                                    <p><span><strong>총 ${map.count }개</strong>  |  ${sportVO.page }/${map.totalPage }페이지</span></p>
                                    <colgroup>
                                        <col width="50px">
                                        <col width="50px">
                                        <col width="50px">
                                        <col width="50px">
                                        <col width="50px">
                                        <col width="50px">
                                        <col width="50px">
                                        <col width="50px">
                                        <col width="50px">
                                    </colgroup>
                                    <thead>
                                        <tr>
                                            <th>sport_code</th>
                                            <th>sport_name</th>
                                            <th>sport_pictogram</th>
                                            <th>title_image</th>
                                            <th>link</th>
                                            <th>sport_info</th>
                                            <th>sport_rule</th>
                                            <th>sport_history</th>
                                            <th>수정/삭제</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:if test="${empty map.list }">
                                            <tr>
                                                <td colspan="7">등록된 종목이 없습니다.</td>
                                            </tr>
                                        </c:if>
                                        <c:forEach var="vo" items="${map.list }">
                                            <tr>
                                                <td >${vo.sport_code }</td>
                                                <td >${vo.sport_name }</td>
                                                <td >${vo.sport_pictogram }</td>
                                                <td >${vo.title_image }</td>
                                                <td >${vo.link }</td>
                                                <td >${vo.sport_info }</td>
                                                <td >${vo.sport_rule }</td>
                                                <td >${vo.sport_history }</td>
                                                <td>
													<input type="button" value="수정" onclick="" id="update">
													<input type="button" value="삭제" onclick="" id="update">
												</td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
								</table>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- /.container-fluid -->
            </div>
            <!-- End of Main Content -->
            <!-- Footer -->
            <%@include file="/WEB-INF/views/common/adminfooter.jsp"%>
            <!-- End of Footer -->
        </div>
        <!-- End of Content Wrapper -->
	</div>
</body>
</html>