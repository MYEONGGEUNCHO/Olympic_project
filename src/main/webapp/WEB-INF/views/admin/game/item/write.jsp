<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 관리자 추가</title>
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
		var a_seat_sold = form['a_seat_sold'].value;
		var b_seat_sold = form['b_seat_sold'].value;
		var c_seat_sold = form['c_seat_sold'].value;
		var d_seat_sold = form['d_seat_sold'].value;
		var vip_seat_sold = form['vip_seat_sold'].value;
		var state = form['state'].value;
		var korean_advancement = form['korean_advancement'].value;
		var a_seat_price = form['a_seat_price'].value;
		var b_seat_price = form['b_seat_price'].value;
		var c_seat_price = form['c_seat_price'].value;
		var d_seat_price = form['d_seat_price'].value;
		var vip_seat_price = form['vip_seat_price'].value;
		var game_id = form['game_id'].value;

		// 필드가 비어있는지 확인
		if (isEmpty(a_seat_sold) || isEmpty(b_seat_sold)
				|| isEmpty(c_seat_sold) || isEmpty(d_seat_sold)
				|| isEmpty(vip_seat_sold) || isEmpty(state)
				|| isEmpty(korean_advancement) || isEmpty(a_seat_price)
				|| isEmpty(b_seat_price) || isEmpty(c_seat_price)
				|| isEmpty(d_seat_price) || isEmpty(vip_seat_price)
				|| isEmpty(game_id)) {
			alert("모든 필드를 입력해주세요.");
			return false;
		}

		// 판매량, 가격 숫자인지 확인
		if (!isNumeric(a_seat_sold) || !isNumeric(b_seat_sold)
				|| !isNumeric(c_seat_sold) || !isNumeric(d_seat_sold)
				|| !isNumeric(vip_seat_sold) || !isNumeric(a_seat_price)
				|| !isNumeric(b_seat_price) || !isNumeric(c_seat_price)
				|| !isNumeric(d_seat_price) || !isNumeric(vip_seat_price)
				|| !isNumeric(game_id)) {
			alert("판매량 가격은 숫자여야 합니다.");
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
				"data" : "a_seat_sold"
			}, {
				"data" : "b_seat_sold"
			}, {
				"data" : "c_seat_sold"
			}, {
				"data" : "d_seat_sold"
			}, {
				"data" : "vip_seat_sold"
			}, {
				"data" : "state"
			}, {
				"data" : "korean_advancement"
			}, {
				"data" : "a_seat_price"
			}, {
				"data" : "b_seat_price"
			}, {
				"data" : "c_seat_price"
			}, {
				"data" : "d_seat_price"
			}, {
				"data" : "vip_seat_price"
			}, {
				"data" : "game_id"
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
					<h1 class="h3 mb-2 text-gray-800">Item Table</h1>
					<p class="mb-4">상품 생성 페이지입니다.</p>

					<!-- DataTales Example -->
					<div class="card shadow mb-4">
						<div class="card-header py-3">
							<h6 class="m-0 font-weight-bold text-primary">Item Table</h6>
						</div>
						<div class="card-body">
							<div class="table-responsive">
								<form method="post" name="frm" id="frm"
									action="/olympic/admin/game/item/create.do">
									<table class="table table-bordered" id="dataTable" width="100%"
										cellspacing="0">
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
										<tbody>
											<tr>
												<th>A좌석 판매량</th>
												<td><input type="text" name="a_seat_sold" value="" /></td>
											</tr>
											<tr>
												<th>B좌석 판매량</th>
												<td><input type="text" name="b_seat_sold" value="" /></td>
											</tr>
											<tr>
												<th>C좌석 판매량</th>
												<td><input type="text" name="c_seat_sold" value="" /></td>
											</tr>
											<tr>
												<th>D좌석 판매량</th>
												<td><input type="text" name="d_seat_sold" value="" /></td>
											</tr>
											<tr>
												<th>VIP좌석 판매량</th>
												<td><input type="text" name="vip_seat_sold" value="" />
												</td>
											</tr>
											<tr>
												<th>상품 상태코드</th>
												<td><select name="state">
														<option value="1">판매</option>
														<option value="0">판매중지</option>
												</select></td>
											</tr>
											<tr>
												<th>한국진출 여부</th>
												<td><select name="korean_advancement">
														<option value="1">한국 진출 여</option>
														<option value="0">한국 진출 부</option>
												</select></td>
											</tr>
											<tr>
												<th>A좌석 가격</th>
												<td><input type="text" name="a_seat_price" value="" />
												</td>
											</tr>
											<tr>
												<th>B좌석 가격</th>
												<td><input type="text" name="b_seat_price" value="" />
												</td>
											</tr>
											<tr>
												<th>C좌석 가격</th>
												<td><input type="text" name="c_seat_price" value="" />
												</td>
											</tr>
											<tr>
												<th>D좌석 가격</th>
												<td><input type="text" name="d_seat_price" value="" />
												</td>
											</tr>
											<tr>
												<th>VIP좌석 가격</th>
												<td><input type="text" name="vip_seat_price" value="" />
												</td>
											</tr>
											<tr>
												<th>경기 ID</th>
												<td><input type="text" name="game_id" value="" /></td>
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
