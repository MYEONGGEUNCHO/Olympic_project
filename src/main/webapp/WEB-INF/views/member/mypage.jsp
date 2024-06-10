<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!doctype html>
<html lang="ko">
<script>
function goUpdate(){
	
	if ($("#newpwd").val() == '') {
			alert('비밀번호를 입력하세요');
			$("#pw").focus();
			return;
		}
	if ($("#newpwd").val() != $("#chknewpwd").val()) {
		alert('비밀번호를 확인하세요');
		return;
	}
	var reg = /^(?=.*[a-zA-Z])(?=.*[0-9]).{8,}$/;
	if ($("#newpwd").val().match(reg) == null) {
		alert('비밀번호는 영문+숫자 조합으로 8자이상 입력하세요');
		$("#newpwd").val('');
		$("#chknewpwd").val('');
		return;
	}
	if ($("#name").val() == '') {
		alert('이름을 입력하세요');
		$("#name").focus();
		return;
	}
	
	if(confirm("수정하시겠습니까?")){
		$("#frm").submit();
	}else{
		return;
	}
	
	
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
	<section class="pt-7 pb-12">
      <div class="container">
        <div class="row">
          <div class="col-12 text-center">

            <!-- Heading -->
            <h3 class="mb-10">My Account</h3>

          </div>
        </div>
        <div class="row">
          <div class="col-12 col-md-3">

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
          <div class="col-12 col-md-9 col-lg-8 offset-lg-1">

            <!-- Form -->
            <form name="frm" id="frm" action="/olympic/member/update.do" method="post">
              <div class="row">
                <div class="col-12 col-md-6">

                  <!-- Email -->
                  <div class="form-group">
                    <label class="form-label" for="accountFirstName">
                      Name *
                    </label>
                    <input class="form-control form-control-sm" id="accountFirstName" name="name" type="text" placeholder="name *" value="${login.name }" required>
                  </div>

                </div>
                
                <div class="col-12">

                  <!-- Email -->
                  <div class="form-group">
                    <label class="form-label" for="accountEmail">
                      Email Address *
                    </label>
                    <input class="form-control form-control-sm" id="accountEmail" type="email" placeholder="Email Address *" value="${vo.email }" readonly>
                  </div>

                </div>
                <div class="col-12 col-md-6">

                  <!-- Password -->
                  <div class="form-group">
                    <label class="form-label" for="accountPassword">
                      New Password *
                    </label>
                    <input class="form-control form-control-sm" id="newpwd" name="pwd" type="password" placeholder="New Password *" required>
                  </div>

                </div>
                <div class="col-12 col-md-6">

                  <!-- Password -->
                  <div class="form-group">
                    <label class="form-label" for="AccountNewPassword">
                      Check New Password *
                    </label>
                    <input class="form-control form-control-sm" id="chknewpwd" type="password" placeholder="Check New Password *" required>
                  </div>

                </div>
                <div class="col-12 col-md-6">

                  <!-- Phone -->
                  <div class="form-group">
                    <label class="form-label" for="accountFirstName">
                      phone
                    </label>
                    <input class="form-control form-control-sm" id="accountFirstName" name="phone" type="text" placeholder="Phone *" value="${vo.phone }" required>
                  </div>

                </div>
                <div class="col-12 col-md-6">

                  <!-- Birthday -->
                  <div class="form-group">
                    <label class="form-label" for="accountFirstName">
                      Birthday
                    </label>
                    <input class="form-control form-control-sm" id="accountFirstName" type="text" placeholder="Birth *" value="${vo.birthday }" readonly>
                  </div>

                </div>
                <div class="col-12">

                  <!-- Button -->
                  <button class="btn btn-dark" type="button" onclick="goUpdate()">Save Changes</button>

                </div>
              </div>
              <input type="hidden" name="member_no" value="${login.member_no }"/>
            </form>

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
