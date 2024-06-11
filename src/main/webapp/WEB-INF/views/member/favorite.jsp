<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
	<section class="pt-7 pb-12">
      <div class="container">
        <div class="row">
          <div class="col-12 text-center">

            <!-- Heading -->
            <h3 class="mb-10">관심 목록 확인</h3>
          </div>
        </div>
        <div class="row">
          <%@include file="../common/mypage.jsp"%>
			<div class="col-12 col-md-9 col-lg-8 offset-lg-1">
            <!-- Heading -->
            <h5 class="mt-7 mb-7">나의 찜 목록</h5>
            <!-- Card -->
            <div id="favoritelist">

		    <div class="col-12">
		    <!-- 반복문 시작 자리 -->
            <!-- List group -->
            <ul class="list-group list-group-lg list-group-flush-x mb-6">
              <li class="list-group-item py-2">
                <div class="row align-items-center">
                  <div class="col-2 d-flex justify-content-center align-items-center" >

                      <img style="width: 70px;" src="/olympic/img/olympic.png" alt="..." class="img-fluid">
                    

                  </div>
                  <div class="col mt-2">

                    <!-- Title -->
                    <div class="d-flex mb-4 fw-bold">
                      <a class="text-body" href="product.html">펜싱 에페 32강전</a> <span class="ms-auto">펜싱스타디움</span>
                    </div>

                    <!-- Text -->
                    <p class="mb-1 fs-sm text-muted">
                      경기 일자: <br>
                      출전 선수:
                    </p>

                    <!--Footer -->
                    <div class="d-flex align-items-center">
                      <!-- Remove -->
                      <a class="fs-xs text-gray-400 ms-auto" href="#!">
                        <i class="fe fe-x"></i> Remove
                      </a>

                    </div>

                  </div>
                </div>
              </li>
              <li class="list-group-item">
                <div class="row align-items-center">
                  <div class="col-3">

                    <!-- Image -->
                    <a href="product.html">
                      <img src="assets/img/products/product-10.jpg" alt="..." class="img-fluid">
                    </a>

                  </div>
                  <div class="col">

                    <!-- Title -->
                    <div class="d-flex mb-2 fw-bold">
                      <a class="text-body" href="product.html">Suede cross body Bag</a> <span class="ms-auto">$49.00</span>
                    </div>

                    <!-- Text -->
                    <p class="mb-7 fs-sm text-muted">
                      Color: Brown
                    </p>

                    <!--Footer -->
                    <div class="d-flex align-items-center">

                      <!-- Remove -->
                      <a class="fs-xs text-gray-400 ms-auto" href="#!">
                        <i class="fe fe-x"></i> Remove
                      </a>

                    </div>

                  </div>
                </div>
              </li>
            </ul>
			  </div>
            </div>
           </div>     
        </div>
      </div>
    </section>

	<!-- 푸터  -->
	<%@include file="../common/footer.jsp"%>
</body>
</html>
