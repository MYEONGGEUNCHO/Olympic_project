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
<script>
	$(document).ready(function() {
		$(".update_btn").click(function() {
			alert(1)
			
			$("#editModal").modal('show');
		});
		
		$(".delete_btn").click(function() {
			// 서버로 이메일 값 전송
	         $.ajax({
	             type: "POST",
	             url: "/olympic/admin/game/sport/delete.do",
	             data: { email: email },
	             success: function(data) {
	            	 if(data == 1){
		            	 alert("");
	            	 }else{
	                	 alert("오류 발생.");
	                	 return;
	                 }
	             }
	         });
		});
	});
</script>
</head>

<body>
	<%@include file="/WEB-INF/views/admin/game/sport/modals.jsp"%>
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
                                                <td id="sport_code">${vo.sport_code }</td>
                                                <td id="sport_name">${vo.sport_name }</td>
                                                <td id="sport_pictogram">${vo.sport_pictogram }</td>
                                                <td id="title_image">${vo.title_image }</td>
                                                <td id="link">${vo.link }</td>
                                                <td id="sport_info">${vo.sport_info }</td>
                                                <td id="sport_rule">${vo.sport_rule }</td>
                                                <td id="sport_history">${vo.sport_history }</td>
                                                <td>
													<button type="button" class="update_btn btn btn-info">수정</button>&ensp; 
											        <button type="button" class="delete_btn btn btn-warning">삭제</button>
												</td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
								</table>
								<div>
                                    <a href="/olympic/admin/game/sport/write.do">종목 추가</a>
                                </div>
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