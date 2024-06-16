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
	<%@include file="/WEB-INF/views/admin/game/item/modals.jsp"%>
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
                    <h1 class="h3 mb-2 text-gray-800">Item Table</h1>
                    <p class="mb-4">상품 관리 테이블입니다.</p>

                    <!-- DataTales Example -->
                    <div class="card shadow mb-4">
                        <div class="card-header py-3">
                            <h6 class="m-0 font-weight-bold text-primary">Item Table</h6>
                        </div>
                        <div class="card-body">
							<div class="table-responsive">
								<table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
									
                                    <p><span><strong>총 ${map.count }개</strong>  |  ${itemVO.page }/${map.totalPage }페이지</span></p>
                                    <colgroup>
                                        <col width="40px">
                                        <col width="40px">
                                        <col width="40px">
                                        <col width="40px">
                                        <col width="40px">
                                        <col width="40px">
                                        <col width="40px">
                                        <col width="40px">
                                        <col width="40px">
                                        <col width="40px">
                                        <col width="40px">
                                        <col width="40px">
                                        <col width="40px">
                                        <col width="40px">
                                    </colgroup>
                                    <thead>
                                        <tr>
                                            <th>item_no</th>
                                            <th>a_seat_sold</th>
                                            <th>b_seat_sold</th>
                                            <th>c_seat_sold</th>
                                            <th>d_seat_sold</th>
                                            <th>vip_seat_sold</th>
                                            <th>state</th>
                                            <th>korean_advancement</th>
                                            <th>a_seat_price</th>
                                            <th>b_seat_price</th>
                                            <th>c_seat_price</th>
                                            <th>d_seat_price</th>
                                            <th>vip_seat_price</th>
                                            <th>game_id</th>
                                            <th>수정/삭제</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:if test="${empty map.list }">
                                            <tr>
                                                <td colspan="14">등록된 종목이 없습니다.</td>
                                            </tr>
                                        </c:if>
                                        <c:forEach var="vo" items="${map.list }">
                                            <tr>
                                                <td id="item_no">${vo.item_no }</td>
                                                <td id="a_seat_sold">${vo.a_seat_sold }</td>
                                                <td id="b_seat_sold">${vo.b_seat_sold }</td>
                                                <td id="c_seat_sold">${vo.c_seat_sold }</td>
                                                <td id="d_seat_sold">${vo.d_seat_sold }</td>
                                                <td id="vip_seat_sold">${vo.vip_seat_sold }</td>
                                                <td id="state">${vo.state }</td>
                                                <td id="korean_advancement">${vo.korean_advancement }</td>
                                                <td id="a_seat_price">${vo.a_seat_price }</td>
                                                <td id="b_seat_price">${vo.b_seat_price }</td>
                                                <td id="c_seat_price">${vo.c_seat_price }</td>
                                                <td id="d_seat_price">${vo.d_seat_price }</td>
                                                <td id="vip_seat_price">${vo.vip_seat_price }</td>
                                                <td id="game_id">${vo.game_id }</td>
                                                <td>
													<button type="button" class="update_btn btn btn-info">수정</button>&ensp; 
											        <button type="button" class="delete_btn btn btn-warning">삭제</button>
												</td>
                                            </tr>
                                            </tr>			
                                        </c:forEach>
                                    </tbody>
								</table>
								<div>
                                    <a href="/olympic/admin/game/item/write.do">상품 추가</a>
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