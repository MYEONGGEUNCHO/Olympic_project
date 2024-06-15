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
	
	<section class="pt-7 pb-12">
		<div class="container">
			<!-- 마이페이지 nav -->
			<div class="row">
	          <div class="col-12 text-center">
	            <!-- Heading -->
	            <h3 class="mb-10">비밀번호 확인</h3>
	          </div>
	        </div>
			<div class="row">
				<%@include file="../common/mypage.jsp"%>
	 			<div class="col-12 col-md-9 col-lg-8 offset-lg-1">
					<div class="card card-lg">
		            	<div class="card-body">
    
            			<h5 class="mt-7 mb-7">비밀번호를 입력하세요</h5>
			            <!-- Form -->
			            <form name="frm" id="frm" action="/olympic/member/pwdCheck.do" method="post">
			              <!-- Email -->
			              <div class="form-group col-8">
			                <label class="visually-hidden" for="modalPasswordResetEmail">
			                  Password
			                </label>
			                <input class="form-control form-control-sm" id="password" type="password" name="pwd" placeholder="Password *" required>
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
	</section>
    
<%-- 	<%@include file="../contactus.jsp"%> --%>
	<!-- 	이 부분에 내용 작성하여 사용 -->
	<!-- 푸터  -->
	<%@include file="../common/footer.jsp"%>
</body>
</html>
