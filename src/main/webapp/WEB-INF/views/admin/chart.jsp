<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@include file="/WEB-INF/views/common/adminheader.jsp"%>
<meta charset="UTF-8">

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>통계 페이지</title>

<!-- Custom fonts for this template-->
<link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

<!-- Custom styles for this template-->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
    const chartData = ${chartData};
    console.log(chartData);
</script>
<script src="../js/admin-drawchart.js"></script>
</head>
<body id="page-top">
	<!-- 모달 -->
	<%@include file="/WEB-INF/views/common/adminmodals.jsp"%>
	<div id="wrapper">
		<!-- 슬라이더 바 -->
		<%@include file="/WEB-INF/views/common/adminslide.jsp"%>
		<!-- Begin Page Content -->
		<div class="container-fluid">
			<div id="content-wrapper" class="d-flex flex-column">

				<div id="content">
					<!-- Page Heading -->
					<h1 class="h3 mb-2 text-gray-800">통계 보기</h1>
					<p class="mb-4">
						<a href="/olympic/admin/chart.do">새로고침</a>
					</p>

					<!-- Content Row -->
					<div class="row justify-content-center">

						<div class="col-xl-11 col-lg-11">

							<!-- 판매량 Chart -->
							<div class="card shadow mb-4">
								<div class="card-header py-3 d-flex justify-content-between">
									<h6 class="m-0 font-weight-bold text-primary">판매량 확인</h6>
									<button id="salesGameBtn" class="btn" type="button" style="display: none;">종목별 확인하기</button>
									<button id="salesDaysBtn" class="btn" type="button">날짜별 확인하기</button>
								</div>
								<div class="card-body">
									<div class="chart-area" id="sales-chart-area">
										<canvas id="salesChart"></canvas>
									</div>
								</div>
							</div>

							<!-- 취소환불 Chart -->
							<div class="card shadow mb-4">
								<div class="card-header py-3 d-flex justify-content-between">
									<h6 class="m-0 font-weight-bold text-primary">취소량 확인</h6>
									<button id="cancelsGameBtn" class="btn" type="button" style="display: none;">종목별 확인하기</button>
									<button id="cancelsDaysBtn" class="btn" type="button">날짜별 확인하기</button>
								</div>
								<div class="card-body">
									<div class="chart-area" id="cancels-chart-area">
										<canvas id="cancelsChart"></canvas>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<!-- /.container-fluid -->
			</div>
			<!-- End of Main Content -->
			<%@include file="../common/adminfooter.jsp"%>
		</div>
		<!-- End of Content Wrapper -->
	</div>
	<!-- End of Page Wrapper -->

</body>
</html>