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
 $(document).ready(function() {
     $(".editBtn").click(function() {
     	console.log(1);
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
     
     $("#resetPwdBtn").click(function() {
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
 });
</script>
</head>

<body>
<%@include file="../../common/adminmodals.jsp"%>
<div id="wrapper">
<!-- 슬라이더 바 -->
<%@include file="../../common/adminslide.jsp"%>

		<!-- Content Wrapper -->
        <div id="content-wrapper" class="d-flex flex-column">

            <!-- Main Content -->
            <div id="content">
            <!-- 상단 툴바 -->
			<%@include file="../../common/adminheader.jsp"%>
                
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
                                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                            <th>Email</th>
                                            <th>Name</th>
                                            <th>point</th>
                                            <th>Membership</th>
                                            <th>CreateDate</th>
                                            <th>State</th>
                                            <th>Edit</th>
                                        </tr>
                                    </thead>
                                    <tfoot>
                                        <tr>
                                            <th>Email</th>
                                            <th>Name</th>
                                            <th>point</th>
                                            <th>Membership</th>
                                            <th>CreateDate</th>
                                            <th>State</th>
                                            <th>Edit</th>
                                        </tr>
                                    </tfoot>
                                    <tbody id="memlist">
                                    <c:forEach var="member" items="${memberList }">
                                        <tr>
                                        	<td id="email">${member.email}</td>
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
                                        	<td><button type="button" class="editBtn">수정</button> &ensp; <button>쿠폰지급</button></td>
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