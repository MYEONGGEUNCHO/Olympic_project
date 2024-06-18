<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />

<!-- Favicon -->
<link rel="shortcut icon" href="/olympic/dist/assets/favicon/favicon.ico" type="image/x-icon" />
<script src="/olympic/js/jquery-3.7.1.min.js"></script>

<!-- Title -->
<title>올림픽 판매하기</title>
<script src="./js/carousel.js"></script>
<script src="./js/timer.js"></script>
<style>
/* carousel style */
#carousel-container {
	position: relative;
	width: 100%;
	max-width: 1440px;
	overflow: hidden;
	max-height: 800px;
	position: relative;
}

#carousel {
	display: flex;
	transition: all 0.5s;
	position: relative;
	flex-wrap: nowrap;
	height: 100%;
}

#carousel>#carousel-item>img {
	object-position: 50% 50%;
	object-fit: cover;
	width: 100vw;
	max-width: 1440px;
}

#prev_button, #next_button {
	cursor: pointer;
	z-index: 2;
	position: absolute;
	top: 50%;
	transform: translate(-50%, -50%);
}

#prev_button {
	left: 4%;
}

#next_button {
	right: 2%;
}

#prev_button>svg, #next_button>svg {
	max-height: 70px;
	height: 5em;
	color: white;
	opacity: 80%;
}

#fixed-container {
	position: absolute;
	display: flex;
	justify-content: center;
	align-items: center;
	align-contents: center;
	height: 100%;
	width: 100%;
	height: 100%;
}

</style>
</head>
<!-- NAVBAR -->
<body>
	<!-- 	공통 모달 - 헤더 장바구니 등 클릭 시 나오는 사이드 창 -->
	<%@include file="./common/modals.jsp"%>
	<!-- 	타이틀 - 카테고리 - 아이콘들 포함된 헤더 -->
	<%@include file="./common/header.jsp"%>
	<!-- CONTENT -->
	<section id="main-container" class="d-flex flex-column align-items-center">
		<!-- 	슬라이드 구현 -->
		<div id="carousel-container" class="d-flex">
			<div id="prev_button">
				<i class="fa-solid fa-caret-left"></i>
			</div>
			<div id="carousel">
				<!-- ajax로 이미지 넣어주기 -->
			</div>
			<div id="next_button">
				<i class="fa-solid fa-caret-right"></i>
			</div>
			<!-- 		고정되는 부분 -->
			<div id="fixed-container" class="bg-dark opacity-70">
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


	</section>
	<!-- 푸터  -->
	<%@include file="./common/footer.jsp"%>
</body>
</html>
