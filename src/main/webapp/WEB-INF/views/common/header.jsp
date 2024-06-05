<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />

<!-- Favicon -->
<link rel="shortcut icon" href="../dist/assets/favicon/favicon.ico" type="image/x-icon" />

<!-- Libs CSS -->
<link rel="stylesheet" href="../dist/assets/css/libs.bundle.css" />

<!-- Theme CSS -->
<link rel="stylesheet" href="../dist/assets/css/theme.bundle.css" />
<script src="../js/jquery-3.7.1.min.js"></script>

<!-- Title -->
<title>올림픽 판매하기</title>
</head>
<!-- NAVBAR -->
<nav class="navbar navbar-expand-lg navbar-light bg-white border-bottom">
	<div class="container">

		<!-- Brand -->
		<a class="navbar-brand" href="/olympic/index.do">
			<img style="width: 42px;" src="/olympic/img/olympic.png">
			Olympic
		</a>

		<!-- Toggler -->
		<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarCollapse" aria-controls="navbarCollapse" aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>

		<!-- Collapse -->
		<div class="collapse navbar-collapse" id="navbarCollapse">

			<!-- Nav -->
			<ul class="navbar-nav mx-auto">
				<li class="nav-item dropdown">

					<!-- Toggle -->
					<a class="nav-link" data-bs-toggle="dropdown" href="/olympic/game/">경기 일정</a>

					<!-- Menu -->
					<div class="dropdown-menu">
						<div class="card card-lg">
							<div class="card-body">
								<ul class="list-styled fs-sm">
									<li class="list-styled-item">
										<a class="list-styled-link" href="/olympic/game/">경기 일정 확인</a>
									</li>
									<li class="list-styled-item">
										<a class="list-styled-link" href="/olympic/game/">날짜별 보기</a>
									</li>
									<li class="list-styled-item">
										<a class="list-styled-link" href="/olympic/game/">종목별 보기</a>
									</li>
								</ul>
							</div>
						</div>
					</div>

				</li>

				<li class="nav-item dropdown">

					<!-- Toggle -->
					<a class="nav-link" data-bs-toggle="dropdown" href="/olympic/qna/index.do">고객 센터</a>

					<!-- Menu -->
					<div class="dropdown-menu">
						<div class="card card-lg">
							<div class="card-body">
								<ul class="list-styled fs-sm">
									<li class="list-styled-item">
										<a class="list-styled-link" href="/olympic/qna/index.do">문의 목록</a>
									</li>
									<li class="list-styled-item">
										<a class="list-styled-link" href="/olympic/qna/write.do">문의 작성하기</a>
									</li>
								</ul>
							</div>
						</div>
					</div>

				</li>

			</ul>

			<!-- Nav -->
			<ul class="navbar-nav flex-row">
				<li class="nav-item ms-lg-n4">
					<a class="nav-link" data-bs-toggle="offcanvas" href="#modalLoginForm">
						<i class="fe fe-user"></i>
					</a>
				</li>
				<li class="nav-item ms-lg-n4">
					<a class="nav-link" href="./account-wishlist.html">
						<span data-cart-items="2">
							<i class="fe fe-heart"></i>
						</span>
					</a>
				</li>
			</ul>

		</div>

	</div>
</nav>