<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html lang="ko">
<style>
	::-webkit-scrollbar {
        height: 4px;
    }

    ::-webkit-scrollbar-thumb {
        background: rgba(136, 136, 136, 0.3);
        border-radius: 10px;
        min-height: 20px;
    }

    ::-webkit-scrollbar-thumb:hover {
        background: rgba(85, 85, 85, 0.3);
    }

    ::-webkit-scrollbar-track {
        background: rgba(241, 241, 241, 0.5);
    }
    
    #couponlist {
        max-height: 400px; 
        overflow-y: auto;  
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
	<section class="pt-7 pb-12">
     <div class="container">
       <div class="row">
         <div class="col-12 text-center">
           <!-- Heading -->
           <h3 class="mb-10">내 쿠폰함</h3>
         </div>
       </div>
       <div class="row">
         <%@include file="../common/mypage.jsp"%>
		<div class="col-12 col-md-9 col-lg-8 offset-lg-1">
		    <!-- Heading -->
		    <h5 class="ms-auto text-end me-2">
		        보유쿠폰 <span class="fs-2 fw-semibold">${coupon.size()} </span> 장
		    </h5>
		    <c:if test="${coupon.size() == 0 }" >
		    	<div class="text-center">보유하신 쿠폰이 없습니다.</div>
		    </c:if>
		    <div id="couponlist">
		    <!-- Card -->
		    	<c:forEach var="coupon" items="${coupon}">
		        	<div class="card card-lg bg-light mb-8">
		            	<div class="card-body p-5">
		                	<div class="row">
		                    	<div class="col-9">
		                        	<!-- Heading -->
		                        	<h4 class="mt-2 mb-3">${coupon.content}</h4>
		                        	<!-- Text -->
		                        	<p class="mb-0"><strong>쿠폰 번호:</strong> ${coupon.coupon_no}</p>
		                    	</div>
		                    	<div class="col-3 text-end">
		                        	<!-- Text -->
		                        	<p class="mb-5">
		                            	<span class="fw-bold fs-2">${coupon.discount} %</span>
		                        	</p>
		                    	</div>
		                	</div>
		            	</div>
		        	</div>
		    	</c:forEach>
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
