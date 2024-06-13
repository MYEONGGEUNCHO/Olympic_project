<%@page import="com.fasterxml.jackson.annotation.JsonInclude.Include"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
    .info-item {
        display: flex;
        justify-content: space-between;
        margin-bottom: 5px; /* 각 항목 사이에 간격 추가 */
    }

    .info-label {
        font-weight: bold;
        margin-right: 10px;
    }
</style>
</head>

<body>
<div id="wrapper">
    <!-- 슬라이더 바 -->
    <!-- 위치에 따라 경로 설정 필요 -->
    <%@include file="/WEB-INF/views/common/adminslide.jsp"%>

    <!-- Content Wrapper -->
    <div id="content-wrapper" class="d-flex flex-column">

        <!-- Main Content -->
        <div id="content">
            <!-- 상단 툴바 -->
            <%@include file="/WEB-INF/views/common/adminheader.jsp"%>
                
            <!-- Begin Page Content -->
            <div class="container-fluid">

                <!-- Page Heading -->
                <h1 class="h3 mb-2 text-gray-800">회원 상세 정보</h1>
                <!--<p class="mb-2">회원 상세 정보 페이지 입니다.</p>  -->

                <!-- DataTables Example -->
                <div class="row p-4">
                    <!-- 회원 정보 -->
                    <div class="col-md-3 card shadow mb-4">
                        <div class="card-header py-3">
                            <h6 class="m-0 font-weight-bold text-primary">회원 정보</h6>
                        </div>
                        <div class="card-body">
						    <div class="avatar avatar-xxl mb-3 text-center">
						        <span class="avatar-title rounded-circle">
						            <i class="fa fa-user"></i>
						        </span>
						    </div>
						    <div class="info-item">
						        <span class="info-label">회원 이름:</span>
						        <span>${detail.name}</span>
						    </div>
						    <div class="info-item">
						        <span class="info-label">회원 이메일:</span>
						        <span>${detail.email}</span>
						    </div>
						    <div class="info-item">
						        <span class="info-label">회원 생년월일:</span>
						        <span>${detail.birthday}</span>
						    </div>
						    <div class="info-item">
						        <span class="info-label">연락처:</span>
						        <span>${detail.phone}</span>
						    </div>
						    <div class="info-item">
						        <span class="info-label">등급:</span>
						        <span>${detail.membership}</span>
						    </div>
						    <div class="info-item">
						        <span class="info-label">포인트:</span>
						        <span>${detail.point}</span>
						    </div>
						</div>
                    </div>

                    <!-- 예매 내역 및 문의 내역 -->
                    <div class="col-md-8 ml-auto">
                        <div class="row">
                            <!-- 예매 내역 -->
                            <div class="col-md-12 card shadow mb-4">
                                <div class="card-header py-3">
                                    <h6 class="m-0 font-weight-bold text-primary">예매 내역</h6>
                                </div>
                                <div class="card-body">
                                    <div class="avatar avatar-xxl mb-3">
                                        <span class="avatar-title rounded-circle">
                                            <i class="fa fa-user"></i>
                                        </span>
                                    </div>
                                    <p>회원 이름: ${detail.name}</p>
                                    <p>회원 이메일: ${detail.email}</p>
                                    <p>회원 생년월일: ${detail.birthday}</p>
                                    <p>연락처: ${detail.phone}</p>
                                    <p>등급: ${detail.membership}</p>
                                    <p>포인트: ${detail.point}</p>
                                </div>
                            </div>

                            <!-- 문의 내역 -->
                            <div class="col-md-12 card shadow mb-4">
                                <div class="card-header py-3">
                                    <h6 class="m-0 font-weight-bold text-primary">문의 내역</h6>
                                </div>
                                <div class="card-body">
                                    <div class="avatar avatar-xxl mb-3">
                                        <span class="avatar-title rounded-circle">
                                            <i class="fa fa-user"></i>
                                        </span>
                                    </div>
                                    <p>회원 이름: ${detail.name}</p>
                                </div>
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