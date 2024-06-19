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
			var row = $(this).closest("tr");
			$("#editsportCode").val(row.find("#sport_code").text());
	    	$("#editsportName").val(row.find("#sport_name").text());
	    	$("#editsport_pictogram").val(row.find("#sport_pictogram").text());
	    	$("#edittitle_image").val(row.find("#title_image").text());
	    	$("#editlink").val(row.find("#link").text());
	    	$("#editsport_info").val(row.find("#sport_info").text());
	    	$("#editsport_rule").val(row.find("#sport_rule").text());
	    	$("#editsport_history").val(row.find("#sport_history").text());
	    	
			$("#editSportModal").modal('show');
		});
		
		$("#saveSport").click(function() {
			
	        var form = $("#sportfrm");
	        var formData = form.serialize();
	        
	        $.ajax({
	        	type: 'POST',
	        	url: '/olympic/admin/game/sport/update.do',
	        	data: formData,
	        	success:function(res){
	        		if(res == 1){
	        			var sportCode = $("#editsportCode").val();
		       	 		var row;
		            	// 수정일 경우
			            row = $("#dataTable").find("tr").filter(function() {
			                return $(this).find("#sport_code").text() == sportCode;
			            });
			
			            row.find("#sport_code").text($("#editsportCode").val());
			            row.find("#sport_name").text($("#editsportName").val());
			            row.find("#sport_pictogram").text($("#editsport_pictogram").val());
			            row.find("#title_image").text($("#edittitle_image").val());
			            row.find("#link").text($("#editlink").val());
			            row.find("#country1_flag").text($("#editcountry1_flag").val());
			            row.find("#country2_flag").text($("#editcountry2_flag").val());
			            row.find("#stadium_name").text($("#editstadium_name").val());
			            row.find("#sport_info").text($("#editsport_info").val());
			            row.find("#sport_rule").text($("#editsport_rule").val());
			            row.find("#sport_history").text($("#editsport_history").val());
			
			            alert('수정되었습니다.');
			            $("#editSportModal").modal('hide');
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
	    	var sport_code = row.find("#sport_code").text();
	    	var delete_confirm = confirm("정말로 삭제하시겠습니까?");
	    	
	         $.ajax({
	             type: "POST",
	             url: "/olympic/admin/game/sport/delete.do",
	             data: { sport_code : parseInt(sport_code) },
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
	});
</script>
</head>

<body>
	<%@include file="/WEB-INF/views/common/adminmodals.jsp"%>
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