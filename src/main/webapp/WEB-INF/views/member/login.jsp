<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
<script src="../js/jquery-3.7.1.min.js"></script>
<script>
$(document).ready(function(){
	
	//로그인 이메일 저장(쿠키 사용)
	var key = getCookie("saveId");
	if(key != ""){
		$("#loginEmail").val(key);
	}
	if($("#loginEmail").val() != ""){
		$("#loginRemember").attr("checked", true);
	}
	
	$("#loginRemember").change(function(){
		if($("#loginRemember").is(":checked")){  //아이디 저장 체크시
			setCookie("saveId", $("#loginEmail").val(), 7); //7일 동안 쿠키 보관
		}else{ //해제했을 경우
			deleteCookie("saveId");
		}
	});
	
	$("#loginEmail").keyup(function(){
		if($("#loginRemember").is(":checked")){
			setCookie("saveId", $("#loginEmail").val(), 7);  
		}
		
	});
});
//쿠키 저장 => saveid함수에서 넘겨준 시간이 현재시간과 비교해서 쿠키를 생성하고 지워주는 역할
function setCookie(cookieName, value, exdays){ //쿠키명, 쿠키값, 쿠키 만료일
    var exdate = new Date();
    exdate.setDate(exdate.getDate() + exdays);
    var cookieValue = escape(value) + ((exdays==null) ? "" : "; expires=" + exdate.toGMTString());
    document.cookie = cookieName + "=" + cookieValue;
}
//쿠키 삭제
function deleteCookie(cookieName){
	var expireDate = new Date();
	expireDate.setDate(expireDate.getDate() - 1);
	document.cookie = cookieName + "= " + "; expires=" + expireDate.toGMTString();
}
//쿠키 값 가져오기 
function getCookie(cookieName) {
	cookieName = cookieName + '=';
	var cookieData = document.cookie;
	var start = cookieData.indexOf(cookieName);
	var cookieValue = '';
	if(start != -1){  //쿠키가 존재할 경우
		start += cookieName.length;
		var end = cookieData.indexOf(';', start);
		if(end == -1) // 쿠키 값의 마지막 위치 인덱스 번호 설정
			end = cookieData.length;
		
		cookieValue = cookieData.substring(start, end);
	}
	return unescape(cookieValue);
}
</script>
<body>
	<!-- 	공통 모달 - 헤더 장바구니 등 클릭 시 나오는 사이드 창 -->
	<%@include file="../common/modals.jsp"%>
	<!-- 	타이틀 - 카테고리 - 아이콘들 포함된 헤더 -->
	<%@include file="../common/header.jsp"%>
	<!-- 	헤더 하단 현재 경로 노출 -->
	<%@include file="../common/breadcrumb.jsp"%>
	<!-- 	메인 컨텐트 CONTENT 태그 찾아서 그 부분만 사용하면됨-->
	<!-- 	이 부분에 내용 작성하여 사용 -->
	<section class="pt-8 pb-12">
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
										<label class="visually-hidden" for="loginEmail"> Email Address * </label>
										<input class="form-control form-control-sm" id="loginEmail" name="email" type="email" placeholder="Email Address *" required>
									</div>
								</div>
								<div class="col-12">
									<!-- Password -->
									<div class="form-group">
										<label class="visually-hidden" for="loginPassword"> Password * </label>
										<input class="form-control form-control-sm" id="loginPassword" name="pwd" type="password" placeholder="Password *" required>
									</div>
								</div>
								<div class="col-12 col-md">
									<!-- Remember -->
									<div class="form-group">
										<div class="form-check">
											<input class="form-check-input" id="loginRemember" type="checkbox">
											<label class="form-check-label" for="loginRemember"> 아이디 저장 </label>
										</div>
									</div>
								</div>
								<div class="col-12 col-md-auto">
									<!-- Link -->
									<div class="form-group">
										<a class="fs-sm text-reset" href="/olympic/member/find.do">비밀번호 찾기</a>
										|
										<a class="fs-sm text-reset" href="/olympic/member/regist.do">회원가입</a>
									</div>
								</div>
								<div class="col-12">
									<!-- Button -->
									<button class="btn btn-sm btn-dark" type="submit">Login</button>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- 	이 부분에 내용 작성하여 사용 -->
	<!-- 푸터  -->
	<%@include file="../common/footer.jsp"%>
</body>
</html>
