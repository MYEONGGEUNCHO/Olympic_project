<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html lang="ko">
    <style>
        
       
       
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
            <h3 class="mb-10">문의 내역 확인</h3>
          </div>
        </div>
        <div class="row">
          <%@include file="../common/mypage.jsp"%>
			<div class="col-12 col-md-9 col-lg-8 offset-1 p-0">
            <!-- Heading -->
            <h5 class="mt-7 mb-5">1:1 문의 내역</h5>
            <p class="fs-7">해당 문의 클릭시 답변을 확인하실 수 있습니다. </p>
            <!-- Card -->
            <div id="favoritelist" class="table-responsive">
		        <table class="table text-center fs-8">
		        <colgroup>
		            <col width=10%>
		            <col width=40%>
		            <col width=20%>
		            <col width=20%>
		        </colgroup>
				  <thead>
				    <tr>
				      <th class="px-0 py-2" scope="col">분류</th>
				      <th class="px-0 py-2" scope="col">제목</th>
				      <th class="px-0 py-2" scope="col">작성일</th>
				      <th class="px-0 py-2" scope="col">답변처리상태</th>
				      
				    </tr>
				  </thead>
				  <tbody>
				  <!-- 반복문 -->
				    <tr>
				      <td class="px-0 py-2">결제</td>
				      <td class="px-0 py-2">결제 부탁드립니다.</td>
				      <td class="px-0 py-2">2024-07-24</td>
				      <td class="px-0 py-2">미완료</td>
				     
				    </tr>
				    
				    <tr>
				      <td class="px-0 py-2">분류</td>
				      <td class="px-0 py-2">제목</td>
				      <td class="px-0 py-2">작성일</td>
				      <td class="px-0 py-2">답변처리상태</td>
				    </tr>
				    <tr>
				      <td class="px-0 py-2">분류</td>
				      <td class="px-0 py-2">제목</td>
				      <td class="px-0 py-2">작성일</td>
				      <td class="px-0 py-2">답변처리상태</td>
				    </tr>
				  </tbody>
				</table>
			  </div>
            </div>
                 
        </div>
      </div>
    </section>

	<!-- 푸터  -->
	<%@include file="../common/footer.jsp"%>
</body>
</html>
