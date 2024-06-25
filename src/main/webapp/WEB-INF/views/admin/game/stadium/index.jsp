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
<script src="../../../js/jquery-3.7.1.min.js"></script>
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
			$("#editStadiumModal").modal('show');
			var row = $(this).closest("tr");
			
			$("#editstadiumNo").val(row.find("#stadiumNo").text());
			$("#editstadiumName").val(row.find("#stadiumName").text());
			$("#editstadium_img_url").val(row.find("#stadium_img_url").text());
			$("#editstadium_url").val(row.find("#stadium_url").text());
			$("#editstadium_en_name").val(row.find("#stadium_en_name").text());
			$("#editstadium_position").val(row.find("#stadium_position").text());
			$("#edita_seat_quantity").val(row.find("#a_seat_quantity").text());
			$("#editb_seat_quantity").val(row.find("#b_seat_quantity").text());
			$("#editc_seat_quantity").val(row.find("#c_seat_quantity").text());
			$("#editd_seat_quantity").val(row.find("#d_seat_quantity").text());
			$("#editvip_seat_quantity").val(row.find("#vip_seat_quantity").text());
			
			$("#editStadiumModal").modal('show');
		});
		
		$("#saveStadium").click(function() {
	        var form = $("#stadiumfrm");
	        var formData = form.serialize();
	        
	        $.ajax({
	        	type: 'POST',
	        	url: '/olympic/admin/game/stadium/update.do',
	        	data: formData,
	        	success:function(res){
	        		if(res == 1){
	        			var stadiumNo = $("#editstadiumNo").val();
		       	 		var row;
		            	// 수정일 경우
			            row = $("#dataTable").find("tr").filter(function() {
			                return $(this).find("#stadiumNo").text() == stadiumNo;
			            });
			
			            row.find("#stadiumNo").text($("#editstadiumNo").val());
			            row.find("#stadiumName").text($("#editstadiumName").val());
			            row.find("#stadium_img_url").text($("#editstadium_img_url").val());
			            row.find("#stadium_url").text($("#editstadium_url").val());
			            row.find("#stadium_en_name").text($("#editstadium_en_name").val());
			            row.find("#stadium_position").text($("#editstadium_position").val());
			            row.find("#a_seat_quantity").text($("#edita_seat_quantity").val());
			            row.find("#b_seat_quantity").text($("#editb_seat_quantity").val());
			            row.find("#c_seat_quantity").text($("#editc_seat_quantity").val());
			            row.find("#d_seat_quantity").text($("#editd_seat_quantity").val());
			            row.find("#vip_seat_quantity").text($("#editvip_seat_quantity").val());
			
			            alert('수정되었습니다.');
			            $("#editStadiumModal").modal('hide');
	        		}
	        		else{
	        			alert('수정 오류');
	        		}
	        		
		            
	        	},error: function(xhr, status, error) {
	                alert('오류 발생:  ' + error);
	            }
	        	
	        });
		});
		
		$(".delete_btn").click(function() {
			// 서버로 이메일 값 전송
			var row = $(this).closest("tr");
	    	var stadiumNo = row.find("#stadiumNo").text();
	    	var delete_confirm = confirm("정말로 삭제하시겠습니까?");
	    	
	         $.ajax({
	             type: "POST",
	             url: "/olympic/admin/game/stadium/delete.do",
	             data: { stadium_no : parseInt(stadiumNo) },
	             success: function(data) {
	            	 if(data == 1){
	            		alert('삭제가 완료되었습니다.');
	            		location.reload();
	 					//location.href = "/olympic/admin/game/index.do";
	            	 }else{
	                	 alert("삭제 실패");
	                	 return;
	                 }
	             },
	             error: function(xhr, status, error) {
	                 alert('오류 발생: ' + error);
	             }
	         });
		});
	});
</script>
</head>
<body>
	<%@include file="/WEB-INF/views/common/adminmodals.jsp"%>
	<%@include file="/WEB-INF/views/admin/game/stadium/modals.jsp"%>
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
                    <h1 class="h3 mb-2 text-gray-800">Stadium Table</h1>
                    <p class="mb-4">경기장 관리 테이블입니다.</p>

                    <!-- DataTales Example -->
                    <div class="card shadow mb-4">
                        <div class="card-header py-3">
                            <h6 class="m-0 font-weight-bold text-primary">Stadium Table</h6>
                        </div>
                        <div class="card-body">
							<div class="table-responsive">
								<table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
									<p><span><strong>총 ${map.count }개</strong>  |  ${stadiumVO.page }/${map.totalPage }페이지</span></p>
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
									</colgroup>
									<thead>
										<tr>
											<th>stadium_no</th>
											<th>stadium_name</th>
											<th>stadium_img_url</th>
											<th>stadium_url</th>
											<th>stadium_en_name</th>
											<th>stadium_position</th>
											<th>a_seat_quantity</th>
											<th>b_seat_quantity</th>
											<th>c_seat_quantity</th>
											<th>d_seat_quantity</th>
											<th>vip_seat_quantity</th>
											<th>수정/삭제</th>
										</tr>
									</thead>
									<tbody>
										<c:if test="${empty map.list }">
											<tr>
												<td colspan="11">등록된 경기장이 없습니다.</td>
											</tr>
										</c:if>
										<c:forEach var="vo" items="${map.list }">
											<tr>
												<td id="stadiumNo">${vo.stadium_no }</td>
												<td id="stadiumName">${vo.stadium_name }</td>
												<td id="stadium_img_url">${vo.stadium_img_url }</td>
												<td id="stadium_url">${vo.stadium_url }</td>
												<td id="stadium_en_name">${vo.stadium_en_name }</td>
												<td id="stadium_position">${vo.stadium_position }</td>
												<td id="a_seat_quantity">${vo.a_seat_quantity }</td>
												<td id="b_seat_quantity">${vo.b_seat_quantity }</td>
												<td id="c_seat_quantity">${vo.c_seat_quantity }</td>
												<td id="d_seat_quantity">${vo.d_seat_quantity }</td>
												<td id="vip_seat_quantity">${vo.vip_seat_quantity }</td>
												<td>
													<button type="button" class="update_btn btn btn-info">수정</button>&ensp; 
											        <button type="button" class="delete_btn btn btn-danger">삭제</button>
												</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
								<div>
                                    <a href="/olympic/admin/game/stadium/write.do">경기장 추가</a>
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