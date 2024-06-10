<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
<script>
function goCheck(){
	if($("#password").val()== ''){
		alert("비밀번호를 입력하세요");
		return;
	}
	$("#frm").submit();
	
}

</script>

<body>
	<!-- 	공통 모달 - 헤더 장바구니 등 클릭 시 나오는 사이드 창 -->
	<%@include file="../common/modals.jsp"%>
	<!-- 	타이틀 - 카테고리 - 아이콘들 포함된 헤더 -->
	<%@include file="../common/header.jsp"%>
	<!-- 	헤더 하단 현재 경로 노출 -->
	<%@include file="../common/breadcrumb.jsp"%>
	
	<section class="pt-7 pb-6">
		<div class="container">
			<div class="row justify-content-center">
			<!-- 마이페이지 nav -->
			<div class="row">
	          <div class="col-12 text-center">
	
	            <!-- Heading -->
	            <h3 class="mb-10">비밀번호 확인</h3>
	
	          </div>
	        </div>
				<div class="row">
          			<div class="col-12 col-md-3">

            <!-- Nav -->
            <nav class="mb-10 mb-md-0">
              <div class="list-group list-group-sm list-group-strong list-group-flush-x">
                <a class="list-group-item list-group-item-action dropend-toggle " href="account-orders.html">
                  관심 목록 확인
                </a>
                <a class="list-group-item list-group-item-action dropend-toggle " href="account-wishlist.html">
                  예매 내역 확인
                </a>
                <a class="list-group-item list-group-item-action dropend-toggle active" href="">
                  문의 답변 확인
                </a>
                <a class="list-group-item list-group-item-action dropend-toggle " href="/olympic/member/pwdcheck.do">
                  정보수정
                </a>
                <a class="list-group-item list-group-item-action dropend-toggle " href="/olympic/member/membership.do">
                  멤버십
                </a>
                <a class="list-group-item list-group-item-action dropend-toggle " href="account-payment.html">
                  내 쿠폰함
                </a>
                <a class="list-group-item list-group-item-action dropend-toggle" href="/olympic/member/logout.do">
                  Logout
                </a>
              </div>
            </nav>

          </div>
	 			<div class="col-12 col-md-6">
					<div class="card card-lg">
		            	<div class="card-body pt-1">
    
            			<!-- Text -->
			            <p class="mb-7 fs-sm text-gray-500">
			              비밀번호를 입력하세요
			            </p>
    
			            <!-- Form -->
			            <form name="frm" id="frm" action="/olympic/member/pwdCheck.do" method="post">
			              <!-- Email -->
			              <div class="form-group">
			                <label class="visually-hidden" for="modalPasswordResetEmail">
			                  Password
			                </label>
			                <input class="form-control form-control-sm" id="password" type="password" name="pwd" placeholder="Email Address *" required>
			              	<input type="hidden" name="email" value="${login.email }">
			              </div>
			    
			              <!-- Button -->
			              <button class="btn btn-sm btn-dark" type="button" onclick="goCheck()">
			                check
			              </button>
			    
			            </form>
    
			          	</div>
			       </div>
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
