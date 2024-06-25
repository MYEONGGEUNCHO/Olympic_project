<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!doctype html>
<html lang="ko">
<style>
    body {
        padding-bottom: 100px; 
    }
    footer {
        position: fixed;
        bottom: 0;
        width: 100%;
        
    }
</style>
<body>
	<!-- 	공통 모달 - 헤더 장바구니 등 클릭 시 나오는 사이드 창 -->
	<%@include file="../common/modals.jsp"%>
	<!-- 	타이틀 - 카테고리 - 아이콘들 포함된 헤더 -->
	<%@include file="../common/header.jsp"%>
	<!-- 	헤더 하단 현재 경로 노출 -->
	<%@include file="../common/breadcrumb.jsp"%>
	<!-- 	메인 컨텐트 CONTENT 태그 찾아서 그 부분만 사용하면됨-->
	<section class="py-12">
      <div class="container">
        <div class="row justify-content-center">
          <div class="col-12 col-md-10 col-lg-8 col-xl-6 text-center">

            <!-- Icon -->
            <div class="mb-7 fs-1">🤷‍♂️</div>

            <!-- Heading -->
            <h2 class="mb-5">404. Page not found</h2>

            <!-- Text -->
            <p class="mb-7 text-gray-500">
              페이지를 찾을 수 없습니다.
            </p>

            <!-- Button -->
            <a class="btn btn-dark" href="/olympic/index.do">
              Go to Homepage
            </a>

          </div>
        </div>
      </div>
    </section>
	<!-- 	이 부분에 내용 작성하여 사용 -->
<%-- 	<%@include file="../contactus.jsp"%> --%>
	<!-- 	이 부분에 내용 작성하여 사용 -->
	<!-- 푸터  -->
	<footer>
    	<%@include file="../common/footer.jsp"%>
    </footer>
	
</body>
</html>
