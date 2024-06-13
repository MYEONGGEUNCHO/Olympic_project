<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!doctype html>
<html lang="ko">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<script src="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.js"></script>
<script>
$(function() {
	
	const login = ${login.point}; 
	if(login < 10000) {
		$("#purchasebtn").prop("disabled", true);
	}
	
	  // 보유 포인트 및 구매 후 포인트 계산
	  const currentPoints = login;
	  const purchaseCost = 10000;
	  const afterPurchase = currentPoints - purchaseCost;

	  //값 변경
	  $("#after").text(afterPurchase+" p");
})
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
            <h3 class="mb-10">Membership</h3>

          </div>
        </div>
        <div class="row">
          <%@include file="../common/mypage.jsp"%>
			<div class="col-12 col-md-9 col-lg-8 offset-lg-1">
            <!-- Heading -->
            <h5 class="mt-7 mb-7">
              회원님의 멤버십은 <span class="fs-1 fw-semibold"> ${login.membership } </span> 입니다.
            </h5>
            <h6 class="mb-7">보유 포인트: <strong>${login.point }</strong> point</h6>
             <form>

              <!-- Card -->
              <div class="form-group card card-sm border">
                <div class="card-body">

                  <!-- Radio -->
                  <div class="form-check custom-radio">

                    <!-- Input -->
                    <input class="form-check-input collapsed" id="checkoutPaymentCard" name="payment" type="radio" checked>

                    <!-- Label -->
                    <label class="form-check-label d-flex justify-content-between w-100 align-items-center text-body text-nowrap" for="checkoutPaymentCard">
					    <div class="mb-0">
					        <span class="fs-1">VIP</span>
					        <span class="fs-4 ms-2">membership</span>
					    </div>
					    <span class="ms-auto fs-3">10000 point</span>
					    <img style="width: 50px;" class="ms-auto" src="/olympic/img/vip.png" alt="...">
					</label>

                  </div>

                </div>
              </div>
              <!-- Button -->
              <div class="d-flex justify-content-end">
              	<a class="me-auto fs-sm text-reset text-decoration-underline" data-bs-toggle="modal" href="#modalvip">VIP 혜택 상세보기</a>
			    <button class="btn btn-dark col-auto" type="button" id="purchasebtn" data-bs-toggle="modal" data-bs-target="#modalbuymembership">
			      구매하기 <i class="fe fe-arrow-right ms-2"></i>
			    </button>
			  </div>

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
