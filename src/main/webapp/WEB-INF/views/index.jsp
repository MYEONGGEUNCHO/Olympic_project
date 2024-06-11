<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />

<!-- Favicon -->
<link rel="shortcut icon" href="/olympic/dist/assets/favicon/favicon.ico" type="image/x-icon" />

<!-- Libs CSS -->
<link rel="stylesheet" href="/olympic/dist/assets/css/libs.bundle.css" />

<!-- Theme CSS -->
<link rel="stylesheet" href="/olympic/dist/assets/css/theme.bundle.css" />
<script src="/olympic/js/jquery-3.7.1.min.js"></script>

<!-- Title -->
<title>올림픽 판매하기</title>
<script>
    document
	    .addEventListener(
		    'DOMContentLoaded',
		    function() {
			var countdownElement = document
				.querySelector('[data-countdown]');
			var targetDate = new Date(countdownElement
				.getAttribute('data-date')).getTime();

			function updateCountdown() {
			    var now = new Date().getTime();
			    var distance = targetDate - now;

			    var days = Math.floor(distance
				    / (1000 * 60 * 60 * 24));
			    var hours = Math
				    .floor((distance % (1000 * 60 * 60 * 24))
					    / (1000 * 60 * 60));
			    var minutes = Math
				    .floor((distance % (1000 * 60 * 60))
					    / (1000 * 60));
			    var seconds = Math
				    .floor((distance % (1000 * 60)) / 1000);

			    document.querySelector('[data-days]').innerText = String(
				    days).padStart(2, '0');
			    document.querySelector('[data-hours]').innerText = String(
				    hours).padStart(2, '0');
			    document.querySelector('[data-minutes]').innerText = String(
				    minutes).padStart(2, '0');
			    document.querySelector('[data-seconds]').innerText = String(
				    seconds).padStart(2, '0');

			    if (distance < 0) {
				clearInterval(countdownInterval);
				document.querySelector('[data-days]').innerText = '00';
				document.querySelector('[data-hours]').innerText = '00';
				document.querySelector('[data-minutes]').innerText = '00';
				document.querySelector('[data-seconds]').innerText = '00';
			    }
			}

			var countdownInterval = setInterval(updateCountdown,
				1000);
			updateCountdown();
		    });
</script>
</head>
<!-- NAVBAR -->
<body>
	<!-- 	공통 모달 - 헤더 장바구니 등 클릭 시 나오는 사이드 창 -->
	<%@include file="./common/modals.jsp"%>
	<!-- 	타이틀 - 카테고리 - 아이콘들 포함된 헤더 -->
	<%@include file="./common/header.jsp"%>
	<!-- CONTENT -->
	<section class="bg-cover " style="background-image: url(https://img.olympics.com/images/image/private/t_16-9_1440/f_auto/v1717670192/primary/yrkm73blk5zevhu3zerc);">
		<div class="m-100 bg-dark opacity-70">
			<div class="container d-flex flex-column">
				<div class="row align-items-center justify-content-center min-vh-100 pt-13 pb-12">
					<div class="col-12 col-md-10 col-lg-8 col-xl-6 text-center text-white">

						<!-- Heading -->
						<h1>We are Coming Soon</h1>

						<!-- Text -->
						<p class="mb-9 fs-lg">Our team have been working on somesing amazing.</p>

						<!-- Counter -->
						<div class="d-flex justify-content-center mb-10" data-countdown data-date="Jul 26, 2024 00:00:00">
							<div class="text-center">
								<div class="fs-1 fw-bolder" data-days>00</div>
								<div class="heading-xxs">Days</div>
							</div>
							<div class="px-1 px-md-4">
								<div class="fs-2 fw-bolder">:</div>
							</div>
							<div class="text-center">
								<div class="fs-1 fw-bolder" data-hours>00</div>
								<div class="heading-xxs">Hours</div>
							</div>
							<div class="px-1 px-md-4">
								<div class="fs-2 fw-bolder">:</div>
							</div>
							<div class="text-center">
								<div class="fs-1 fw-bolder" data-minutes>00</div>
								<div class="heading-xxs">Minutes</div>
							</div>
							<div class="px-1 px-md-4">
								<div class="fs-2 fw-bolder">:</div>
							</div>
							<div class="text-center">
								<div class="fs-1 fw-bolder" data-seconds>00</div>
								<div class="heading-xxs">Seconds</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- 푸터  -->
	<%@include file="./common/footer.jsp"%>
</body>
</html>
