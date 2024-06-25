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
<script src="../../js/jquery-3.7.1.min.js"></script>
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
	    	$("#editgame_id").val(row.find("#game_id").text());
	    	$("#editsport_name").val(row.find("#sport_name").text());
	    	$("#editcountry1_name").val(row.find("#country1_name").text());
	    	$("#editcountry2_name").val(row.find("#country2_name").text());
	    	$("#edittournament").val(row.find("#tournament").text());
	    	$("#editcountry").val(row.find("#country").text());
	    	$("#editcountry1_flag").val(row.find("#country1_flag").text());
	    	$("#editcountry2_flag").val(row.find("#country2_flag").text());
	    	$("#editstadium_name").val(row.find("#stadium_name").text());
	    	$("#editparis_date").val(row.find("#paris_date").text());
	    	$("#editparis_time").val(row.find("#paris_time").text());
	    	$("#editkorea_date").val(row.find("#korea_date").text());
	    	$("#editkorea_time").val(row.find("#korea_time").text());
	    	$("#editsport_code").val(row.find("#sport_code").text());
	    	$("#editstadium_no").val(row.find("#stadium_no").text());
			
			$("#editGameModal").modal('show');
		});
		
		$("#saveGame").click(function() {
			
	        var form = $("#gamefrm");
	        var formData = form.serialize();
	        
	        $.ajax({
	        	type: 'POST',
	        	url: '/olympic/admin/game/update.do',
	        	data: formData,
	        	success:function(res){
	        		if(res == 1){
	        			var gameId = $("#editgame_id").val();
		       	 		var row;
		            	// 수정일 경우
			            row = $("#dataTable").find("tr").filter(function() {
			                return $(this).find("#game_id").text() == gameId;
			            });
			
			            row.find("#sport_name").text($("#editsport_name").val());
			            row.find("#country1_name").text($("#editcountry1_name").val());
			            row.find("#country2_name").text($("#editcountry2_name").val());
			            row.find("#tournament").text($("#edittournament").val());
			            row.find("#country").text($("#editcountry").val());
			            row.find("#country1_flag").text($("#editcountry1_flag").val());
			            row.find("#country2_flag").text($("#editcountry2_flag").val());
			            row.find("#stadium_name").text($("#editstadium_name").val());
			            row.find("#paris_date").text($("#editparis_date").val());
			            row.find("#paris_time").text($("#editparis_time").val());
			            row.find("#korea_date").text($("#editkorea_date").val());
			            row.find("#korea_time").text($("#editkorea_time").val());
			            row.find("#sport_code").text($("#editsport_code").val());
			            row.find("#stadium_no").text($("#editstadium_no").val());
			
			            alert('수정되었습니다.');
			            $("#editGameModal").modal('hide');
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
			var row = $(this).closest("tr");
	    	var game_id = row.find("#game_id").text();
	    	var delete_confirm = confirm("정말로 삭제하시겠습니까?");
	    	
	         $.ajax({
	             type: "POST",
	             url: "/olympic/admin/game/delete.do",
	             data: { game_id : parseInt(game_id) },
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
                    <h1 class="h3 mb-2 text-gray-800">Game Table</h1>
                    <p class="mb-4">올림픽 경기일정 관리 테이블입니다.</p>

                    <!-- DataTales Example -->
                    <div class="card shadow mb-4">
                        <div class="card-header py-3">
                            <h6 class="m-0 font-weight-bold text-primary">Game Table</h6>
                        </div>
                        <div class="card-body">
							<div class="table-responsive">
								<table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
									
                                    <p><span><strong>총 ${map.count }개</strong>  |  ${gameVO.page }/${map.totalPage }페이지</span></p>
                                    <colgroup>
                                        <col width="35px">
                                        <col width="35px">
                                        <col width="35px">
                                        <col width="35px">
                                        <col width="35px">
                                        <col width="35px">
                                        <col width="35px">
                                        <col width="35px">
                                        <col width="35px">
                                        <col width="35px">
                                        <col width="35px">
                                        <col width="35px">
                                        <col width="35px">
                                        <col width="35px">
                                        <col width="35px">
                                    </colgroup>
                                    <thead>
                                        <tr>
                                            <th>game_id</th>
                                            <th>sport_name</th>
                                            <th>country1_name</th>
                                            <th>country2_name</th>
                                            <th>tournament</th>
                                            <th>country</th>
                                            <th>country1_flag</th>
                                            <th>country2_flag</th>
                                            <th>stadium_name</th>
                                            <th>paris_date</th>
                                            <th>paris_time</th>
                                            <th>korea_date</th>
                                            <th>korea_time</th>
                                            <th>sport_code</th>
                                            <th>stadium_no</th>
                                            <th>수정/삭제</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:if test="${empty map.list }">
                                            <tr>
                                                <td colspan="15">등록된 종목이 없습니다.</td>
                                            </tr>
                                        </c:if>
                                        <c:forEach var="vo" items="${map.list }">
                                            <tr>
                                                <td id="game_id">${vo.game_id }</td>
                                                <td id="sport_name">${vo.sport_name }</td>
                                                <td id="country1_name">${vo.country1_name }</td>
                                                <td id="country2_name">${vo.country2_name }</td>
                                                <td id="tournament">${vo.tournament }</td>
                                                <td id="country">${vo.country }</td>
                                                <td id="country1_flag">${vo.country1_flag }</td>
                                                <td id="country2_flag">${vo.country2_flag }</td>
                                                <td id="stadium_name">${vo.stadium_name }</td>
                                                <td id="paris_date">${vo.paris_date }</td>
                                                <td id="paris_time">${vo.paris_time }</td>
                                                <td id="korea_date">${vo.korea_date }</td>
                                                <td id="korea_time">${vo.korea_time }</td>
                                                <td id="sport_code">${vo.sport_code }</td>
                                                <td id="stadium_no">${vo.stadium_no }</td>
                                                <td>
													<button type="button" class="update_btn btn btn-info">수정</button>&ensp; 
											        <button type="button" class="delete_btn btn btn-danger">삭제</button>
												</td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>

								</table>
                                <div>
                                    <a href="/olympic/admin/game/write.do">올림픽 경기일정 추가</a>
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