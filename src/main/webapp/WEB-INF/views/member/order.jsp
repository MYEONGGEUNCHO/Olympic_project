<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html lang="ko">
    <style>
        .table {
            width: 100%;
            table-layout: fixed;
        }
        th, td {
            word-wrap: break-word;
            white-space: nowrap; 
        }
        th {
            font-weight: bold;
            font-size: 13px;
        }
        td {
        	font-size:12px;
        	
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
            <h3 class="mb-10">예매 내역 확인</h3>
          </div>
        </div>
        <div class="row">
          <%@include file="../common/mypage.jsp"%>
			<div class="col-12 col-md-9 col-lg-8 offset-1 p-0">
            <!-- Heading -->
            <h5 class="mt-7 mb-5">예매 확인/취소</h5>
            <p class="fs-7">상세보기 클릭시 결제 내역을 확인하실 수 있습니다.</p>
            <!-- Card -->
            <div id="favoritelist" class="table-responsive">
		        <table class="table text-center fs-8">
		        <colgroup>
		            <col width=11%>
		            <col width=12%>
		            <col width=16%>
		            <col width=15%>
		            <col width=16%>
		            <col width=9%>
		            <col width=10%>
		            <col width=10%>
		        </colgroup>
				  <thead>
				    <tr>
				      <th class="px-0 py-2" scope="col">예매일</th>
				      <th class="px-0 py-2" scope="col">예매번호</th>
				      <th class="px-0 py-2" scope="col">경기종목</th>
				      <th class="px-0 py-2" scope="col">경기일자</th>
				      <th class="px-0 py-2" scope="col">경기장</th>
				      <th class="px-0 py-2" scope="col">좌석등급</th>
				      <th class="px-0 py-2" scope="col">결제상태</th>
				      <th class="px-0 py-2" scope="col">상세</th>
				    </tr>
				  </thead>
				  <tbody>
				  <!-- 반복문 -->
				    <tr>
				      <td class="px-0 py-2">2024-07-24</td>
				      <td class="px-0 py-2">ALkjd82lk</td>
				      <td class="px-0 py-2">펜싱 32강</td>
				      <td class="px-0 py-2">2024-08-03</td>
				      <td class="px-0 py-2">펜싱스타디움</td>
				      <td class="px-0 py-2">VIP</td>
				      <td class="px-0 py-2">완료</td>
				      <td class="px-0 py-2">상세링크</td>
				    </tr>
				    
				    <tr>
				      <td class="px-0 py-2">2024-07-24</td>
				      <td class="px-0 py-2">ALkjd82lk</td>
				      <td class="px-0 py-2">펜싱 32강</td>
				      <td class="px-0 py-2">2024-08-03</td>
				      <td class="px-0 py-2">펜싱스타디움</td>
				      <td class="px-0 py-2">A</td>
				      <td class="px-0 py-2">완료</td>
				      <td class="px-0 py-2">상세링크</td>
				    </tr>
				    <tr>
				      <td class="px-0 py-2">2024-07-24</td>
				      <td class="px-0 py-2">ALkjd82lk</td>
				      <td class="px-0 py-2">펜싱 32강</td>
				      <td class="px-0 py-2">2024-08-03</td>
				      <td class="px-0 py-2">펜싱스타디움</td>
				      <td class="px-0 py-2">D</td>
				      <td class="px-0 py-2">완료</td>
				      <td class="px-0 py-2">상세링크</td>
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
