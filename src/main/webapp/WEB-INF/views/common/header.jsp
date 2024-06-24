<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
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
										<a class="list-styled-link" href="/olympic/game/index.do">경기 일정 확인</a>
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
			<ul class="navbar-nav flex-row align-items-center">
				<li class="nav-item">
					<c:if test="${!empty login }">
						<div>${login.name }님 환영합니다.</div>
					</c:if>
					<c:if test="${empty login }">
						<div>로그인 후 이용하세요.</div>
					</c:if>
				</li>
				<c:if test="${empty login }">
					<li class="nav-item">
						<a class="nav-link" data-bs-toggle="offcanvas" href="#modalLoginForm" title="로그인">
							<i class="fe fe-user"></i>
						</a>
					</li>
				</c:if>
				<c:if test="${!empty login }">
					<li class="nav-item">
						<a class="nav-link" href="/olympic/member/favorite.do" title="마이페이지">
							<i class="fe fe-user"></i>
						</a>
					</li>
					<li class="nav-item">
						<a class="nav-link" href="/olympic/member/logout.do" title="로그아웃">
							<i class="fa-solid fa-arrow-right-from-bracket"></i>
						</a>
					</li>
				</c:if>

			</ul>

		</div>

	</div>
</nav>