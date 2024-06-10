<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!doctype html>
<html lang="ko">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<script src="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.js"></script>
<script>
$(function() {
    var reset = ${reset != null ? reset : 'false'};
    if (reset === true) {
        $("#modalpwdreset").modal("show");
    }
})

function goCheck(){
	if ($('#findName').val() === '') {
        alert('이름을 입력해주세요.');
        $('#findName').focus();
        return;
    }
    if ($('#findEmail').val() === '') {
        alert('이메일을 입력해주세요.');
        $('#findEmail').focus();
        return;
    }
    $("#passwordResetForm").submit();
};
</script>

<body>
	<!-- 	공통 모달 - 헤더 장바구니 등 클릭 시 나오는 사이드 창 -->
	<%@include file="../common/modals.jsp"%>
	<!-- 	타이틀 - 카테고리 - 아이콘들 포함된 헤더 -->
	<%@include file="../common/header.jsp"%>
	<!-- 	헤더 하단 현재 경로 노출 -->
	<%@include file="../common/breadcrumb.jsp"%>
	<!-- 	메인 컨텐트 CONTENT 태그 찾아서 그 부분만 사용하면됨-->
	<section class="pt-7 pb-12">
		<div class="container">
			<div class="row justify-content-center">
				<!-- Card -->
				<div class="card card-lg mb-10 mb-md-0 w-50 ">
					<div class="card-body">

						<!-- Heading -->
						<h6 class="mb-7">비밀번호 찾기</h6>

						<!-- Form -->
						<form action="/olympic/member/checkEmail.do" method="post" id="passwordResetForm">
							<div class="row">
								<div class="col-12">
	
										<!-- name -->
										<div class="form-group">
											<label class="visually-hidden" for="loginPassword">
												name </label> <input class="form-control form-control-sm"
												id="findName" name="name" type="text"
												placeholder="Name *" required>
										</div>
	
									</div>
								<div class="col-12">
									<!-- Email -->
									<div class="form-group" id="mailform">
										<label class="visually-hidden" for="loginEmail"> Email
											Address * </label> <input class="form-control form-control-sm"
											id="findEmail" name="email" type="email"
											placeholder="Email Address *" required>
									</div>
								</div>
											
								<div class="col-12 ">
									<!-- Button -->
									<button class="btn btn-sm btn-dark" id="checkbtn" type="button" onclick="goCheck()">
										확인</button>

								</div>
							</div>
						</form>
						</div>
					</div>
				</div>
				</div>
	</section>
	
<%-- 	<%@include file="../contactus.jsp"%> --%>
	<!-- 	이 부분에 내용 작성하여 사용 -->
	<!-- 푸터  -->
	<%@include file="../common/footer.jsp"%>
</body>
</html>
