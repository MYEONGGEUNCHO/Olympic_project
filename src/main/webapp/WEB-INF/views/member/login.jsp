<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko"> 

<body>
	<!-- 	공통 모달 - 헤더 장바구니 등 클릭 시 나오는 사이드 창 -->
	<%@include file="../common/modals.jsp"%>
	<!-- 	타이틀 - 카테고리 - 아이콘들 포함된 헤더 -->
	<%@include file="../common/header.jsp"%>
	<!-- 	헤더 하단 현재 경로 노출 -->
	<%@include file="../common/breadcrumb.jsp"%>
	<!-- 	메인 컨텐트 CONTENT 태그 찾아서 그 부분만 사용하면됨-->
	<!-- 	이 부분에 내용 작성하여 사용 -->
	<section class="pt-7 pb-12">
		<div class="container">
			<div class="row justify-content-center">
				<!-- Card -->
				<div class="card card-lg mb-10 mb-md-0 w-50 ">
					<div class="card-body">

						<!-- Heading -->
						<h6 class="mb-7">Login</h6>

						<!-- Form -->
						<form action="/olympic/member/login.do" method="post">
							<div class="row">
								<div class="col-12">
									<div class="form-group">
										<label class="visually-hidden" for="loginEmail"> Email
											Address * </label> <input class="form-control form-control-sm"
											id="loginEmail" name="email" type="email"
											placeholder="Email Address *" required>
									</div>

								</div>
								<div class="col-12">

									<!-- Password -->
									<div class="form-group">
										<label class="visually-hidden" for="loginPassword">
											Password * </label> <input class="form-control form-control-sm"
											id="loginPassword" name="pwd" type="password"
											placeholder="Password *" required>
									</div>

								</div>
								<div class="col-12 col-md">

									<!-- Remember -->
									<div class="form-group">
										<div class="form-check">
											<input class="form-check-input" id="loginRemember"
												type="checkbox"> <label class="form-check-label"
												for="loginRemember"> 아이디 저장 </label>
										</div>
									</div>

								</div>
								<div class="col-12 col-md-auto">

									<!-- Link -->
									<div class="form-group">
										<a class="fs-sm text-reset" data-bs-toggle="modal"
											href="/olympic/member/find.do">비밀번호 찾기</a> <a> | </a> <a
											class="fs-sm text-reset" data-bs-toggle="modal"
											href="/olympic/member/regist.do">회원가입</a>
									</div>

								</div>
								<div class="col-12">

									<!-- Button -->
									<button class="btn btn-sm btn-dark" type="submit">
										Login</button>

								</div>
							</div>
						</form>

					</div>
				</div>
	</section>

	
	<%-- 	<%@include file="../contactus.jsp"%> --%>
	<!-- 	이 부분에 내용 작성하여 사용 -->
	<!-- 푸터  -->
	<%@include file="../common/footer.jsp"%>
</body>
</html>
