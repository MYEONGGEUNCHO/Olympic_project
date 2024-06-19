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
<script src="../js/jquery-3.7.1.min.js"></script>
<script>

 $(document).ready(function() {
     $(".editBtn").click(function() {
         // Edit button 클릭 시 모달을 보이도록 함
         var row = $(this).closest("tr");
         var email = row.find("#email").text();
         var name = row.find("#name").text();
         var point = row.find("#point").text();
         var membership = row.find("#membership").text();
         var state = row.find("#state").data("state");

         $("#editEmail").val(email);
         $("#editName").val(name);
         $("#editPoint").val(point);
         $("#editMemberShip").val(membership);
         $("#editState").val(state);

         $("#editModal").modal('show');
     });
     
     $("#saveBtn").click(function() {
         // 폼 데이터를 직렬화하여 전송
         var form = $("#frm");
         var formData = form.serialize();

         $.ajax({
             type: 'POST',
             url: '/olympic/admin/updateMember.do',
             data: formData,
             success: function(data) {
                 if (data == 1) { // 예를 들어 서버에서 성공적으로 처리되었음을 'success' 문자열로 반환한다고 가정
                     var mememail = $("#editEmail").val();
                     var row = $("#dataTable").find("tr").filter(function() {
                         return $(this).find("#email").text() === mememail;
                     });
                     row.find("#name").text($("#editName").val());
                     row.find("#point").text($("#editPoint").val());
                     row.find("#membership").text($("#editMemberShip").val());
                     
                     var stateValue = $("#editState").val(); 
                     row.find("#state").data("state", stateValue);
                     
                     var newState = $("#editState").val(); 
                     row.find("#state").data("state", newState); 
                     
                     switch (newState) {
                         case "0":
                             row.find("#state").text("회원");
                             break;
                         case "1":
                             row.find("#state").text("탈퇴");
                             break;
                         case "2":
                             row.find("#state").text("계정잠금");
                             break;
                         case "3":
                             row.find("#state").text("관리자");
                             break;
                         default:
                             row.find("#state").text("알 수 없음");
                             break;
                     }
                     alert('정보가 수정되었습니다.');
                     
                     $("#editModal").modal('hide'); 
                 } else {
                     alert('업데이트 실패');
                 }
             },
             error: function(xhr, status, error) {
                 alert('오류 발생: ' + error);
             }
         });
     });
     
     
     $(".issueCouponBtn").click(function() {
         var row = $(this).closest("tr");
         var memberNo = row.find("#member_no").text();
         var email = row.find("#email").text();
         
         $("#couponMemberNo").val(memberNo);
         $("#couponEmail").val(email);
         
         $("#couponModal").modal('show');
     });
     
     $(".resetPwdBtn").click(function() {
         // 회원 이메일 값 가져오기
         var email = $("#editEmail").val();
  
         // 서버로 이메일 값 전송
         $.ajax({
             type: "POST",
             url: "/olympic/admin/resetPwd.do",
             data: { email: email },
             success: function(data) {
            	 if(data == 1){
	            	 alert("해당 회원의 비밀번호를 생년월일로 초기화 하였습니다.");
            	 }else{
                	 alert("오류 발생.");
                	 return;
                 }
            	 
             }
             
         });
     });
  // DataTables 초기화
     $('#dataTable').DataTable({
         lengthMenu: [ [10, 5, 20], [10, 5, 20] ],
     }); 
 });
</script>
</head>

<body>
<%@include file="/WEB-INF/views/common/adminmodals.jsp"%>
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
                    <h1 class="h3 mb-2 text-gray-800">Member Table</h1>
                    <p class="mb-4">회원 관리 테이블입니다. 회원을 클릭하시면 회원의 상세정보 조회가 가능합니다.</p>

                    <!-- DataTales Example -->
                    <div class="card shadow mb-4">
                        <div class="card-header py-3">
                            <h6 class="m-0 font-weight-bold text-primary">MemberTables</h6>
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-bordered text-center" id="dataTable" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                        	<th style="display:none;">no</th>
                                            <th>Email</th>
                                            <th>Name</th>
                                            <th>Point</th>
                                            <th>Membership</th>
                                            <th>CreateDate</th>
                                            <th>State</th>
                                            <th>Edit</th>
                                        </tr>
                                    </thead>
                                    <tfoot>
                                        <tr>
                                        	<th style="display:none;">no</th>
                                            <th>Email</th>
                                            <th>Name</th>
                                            <th>Point</th>
                                            <th>Membership</th>
                                            <th>CreateDate</th>
                                            <th>State</th>
                                            <th>Edit</th>
                                        </tr>
                                    </tfoot>
                                    <tbody id="memlist">
                                    <c:forEach var="member" items="${memberList }">
                                        <tr>
                                        	<td id="member_no" style="display:none;">${member.member_no}</td>
                                        	<td id="email"><a href="/olympic/admin/detail.do?member_no=${member.member_no }">${member.email}</a></td>
					                        <td id="name">${member.name}</td>
					                        <td id="point">${member.point}</td>
					                        <td id="membership">${member.membership}</td>
					                        <td>${member.formattedCredate}</td>
					                        <td id="state" data-state="${member.state}">
                                        		<c:choose>
										            <c:when test="${member.state == 0}">회원</c:when>
										            <c:when test="${member.state == 1}">탈퇴</c:when>
										            <c:when test="${member.state == 2}">계정잠금</c:when>
										            <c:when test="${member.state == 3}">관리자</c:when>
										            <c:otherwise>알 수 없음</c:otherwise>
										        </c:choose>
                                        	</td>
                                        	<td>
                                        	<button type="button" class="editBtn btn btn-info">수정</button>&ensp; 
											<button type="button" class="issueCouponBtn btn btn-warning">쿠폰지급</button>
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
            <%@include file="../../common/adminfooter.jsp"%>
            <!-- End of Footer -->

        </div>
        <!-- End of Content Wrapper -->
</div>
</body>
</html>