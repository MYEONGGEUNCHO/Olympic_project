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
<title>올림픽 경기일정 관리자 추가</title>
<style type="text/css">
table {
	width: 100%;
	border-collapse: collapse;
}

th, td {
	text-align: center;
	border: 1px solid #ddd;
	padding: 8px;
	max-width: 150px; /* 셀의 최대 너비 설정 */
	overflow: hidden; /* 넘치는 부분 숨기기 */
	text-overflow: ellipsis; /* 넘치는 부분 생략 (...) 표시 */
	white-space: nowrap; /* 텍스트 줄바꿈 방지 */
}
</style>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script
	src="https://cdn.datatables.net/1.10.24/js/jquery.dataTables.min.js"></script>
<link rel="stylesheet" type="text/css"
	href="https://cdn.datatables.net/1.10.24/css/jquery.dataTables.min.css" />
<script type="text/javascript">
	function goSave() {
		if (validateForm()) {
			document.getElementById('frm').submit();
		}
	}

	function validateForm() {
		var form = document.forms['frm'];
		var sport_name = form['sport_name'].value;
		var country1_name = form['country1_name'].value;
		var country2_name = form['country2_name'].value;
		var tournament = form['tournament'].value;
		var country = form['country'].value;
		var country1_flag = form['country1_flag'].value;
		var country2_flag = form['country2_flag'].value;
		var stadium_name = form['stadium_name'].value;
		var paris_date = form['paris_date'].value;
		var paris_time = form['paris_time'].value;
		var korea_date = form['korea_date'].value;
		var korea_time = form['korea_time'].value;
		var sport_code = form['sport_code'].value;
		var stadium_no = form['stadium_no'].value;

		// 경기장 ID 숫자인지 확인
		if (!isNumeric(stadium_no)) {
			alert("좌석 수는 숫자여야 합니다.");
			return false;
		}
		return true;
	}

	function isEmpty(value) {
		return !value.trim();
	}

	function isNumeric(value) {
		return /^[0-9]+$/.test(value);
	}

	$(document).ready(function() {
		$('#dataTable').DataTable({
			"columns" : [ {
				"data" : "sport_name"
			}, {
				"data" : "country1_name"
			}, {
				"data" : "country2_name"
			}, {
				"data" : "tournament"
			}, {
				"data" : "country"
			}, {
				"data" : "country1_flag"
			}, {
				"data" : "country2_flag"
			}, {
				"data" : "stadium_name"
			}, {
				"data" : "paris_date"
			}, {
				"data" : "paris_time"
			}, {
				"data" : "korea_date"
			}, {
				"data" : "korea_time"
			}, {
				"data" : "sport_code"
			}, {
				"data" : "stadium_no"
			} ]
		});
	});
</script>
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
					<h1 class="h3 mb-2 text-gray-800">Game Table</h1>
					<p class="mb-4">올림픽 경기일정 생성 페이지입니다.</p>

					<!-- DataTales Example -->
					<div class="card shadow mb-4">
						<div class="card-header py-3">
							<h6 class="m-0 font-weight-bold text-primary">Game Table</h6>
						</div>
						<div class="card-body">
							<div class="table-responsive">
								<form method="post" name="frm" id="frm"
									action="/olympic/admin/game/create.do">
									<table class="table table-bordered" id="dataTable" width="100%"
										cellspacing="0">
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
										<tbody>
											<tr>
												<th>종목명</th>
												<td><input type="text" name="sport_name" value="" /></td>
											</tr>
											<tr>
												<th>국가1이름</th>
												<td><input type="text" name="country1_name" value="" />
												</td>
											</tr>
											<tr>
												<th>국가2이름</th>
												<td><input type="text" name="country2_name" value="" />
												</td>
											</tr>
											<tr>
												<th>토너먼트</th>
												<td><input type="text" name="tournament" value="" /></td>
											</tr>
											<tr>
												<th>국가대진</th>
												<td><input type="text" name="country" value="" /></td>
											</tr>
											<tr>
												<th>국가1국기_IMG_URL</th>
												<td><input type="text" name="country1_flag" value="" />
												</td>
											</tr>
											<tr>
												<th>국가2국기_IMG_URL</th>
												<td><input type="text" name="country2_flag" value="" />
												</td>
											</tr>
											<tr>
												<th>경기장이름</th>
												<td><input type="text" name="stadium_name" value="" />
												</td>
											</tr>
											<tr>
												<th>파리경기일자</th>
												<td><input type="text" name="paris_date" value="" /></td>
											</tr>
											<tr>
												<th>파리경기시간</th>
												<td><input type="text" name="paris_time" value="" /></td>
											</tr>
											<tr>
												<th>한국경기일자</th>
												<td><input type="text" name="korea_date" value="" /></td>
											</tr>
											<tr>
												<th>한국경기시간</th>
												<td><input type="text" name="korea_time" value="" /></td>
											</tr>
											<tr>
												<th>종목코드</th>
												<td><input type="text" name="sport_code" value="" /></td>
											</tr>
											<tr>
												<th>경기장ID</th>
												<td><input type="text" name="stadium_no" value="" /></td>
											</tr>
										</tbody>
									</table>
									<div>
										<a href="javascript:goSave()">생성</a>
									</div>
								</form>
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
